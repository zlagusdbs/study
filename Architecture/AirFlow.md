
# AirFlow
- Airflow Architecture
  - API Server
  - Scheduler
  - DAG Processor
  - Metadata Database
- Executor
  - LocalExecutor
- Scheduler 내부
  - Scheduler Loop
  - Task 상태 전이
  - Timer
- Task 실행
  - Execution API
  - Trigger Rule
- Airflow 2 -> 3 변경점
- DAG Folder와 PYTHONPATH
- Kubernetes 배포 구성
- Option
- Command
- Reference

---

# Airflow Architecture
DAG(Directed Acyclic Graph, 방향성 비순환 그래프)로 정의된 워크플로우를 스케줄링하고 실행하는 **Workflow Orchestration Tool**

Airflow 3 기준으로 4개의 프로세스와 1개의 DB로 구성된다.
![Airflow Architecture](../Resource/Architecture%2C%20AirFlow/Architecture%2C%20AirFlow.png)

- 각 프로세스는 **독립적으로 기동**된다. 소규모 구성에서는 한 컨테이너에서 `&`로 함께 띄우기도 한다.
- Message 흐름의 중심은 Broker가 아닌 **Metadata Database**다. 모든 상태는 DB에 기록된다.

## API Server
REST API, Web UI, Execution API를 **하나의 프로세스**가 서빙한다.

- Airflow 2의 `webserver`를 대체한다.
- Execution API는 Airflow 3에서 신설된 엔드포인트로, **Task가 자신의 상태를 보고하는 창구**다.

## Scheduler
DAG의 실행 시점을 판단하고, 실행 가능한 Task를 **큐에 넣는 역할**

- DagRun 생성, 의존관계/Pool 판정, Task Instance 상태 전이를 담당한다.
- **Executor를 자기 프로세스 안에 품는다.** 별도 프로세스가 아니다.

## DAG Processor
DAG 파일(`.py`)을 파싱하여 **Serialized DAG(JSON)를 DB에 저장**하는 프로세스

- Airflow 2에서는 Scheduler 내부의 서브프로세스였으나, **Airflow 3에서 독립 컴포넌트로 분리**되어 필수가 되었다.
- Scheduler와 API Server는 DAG 파일을 직접 읽지 않고, **DB의 Serialized DAG만 읽는다.**
  - 즉, DAG 파일을 바꿔도 DAG Processor가 재파싱하기 전까지는 반영되지 않는다.

## Metadata Database
Postgres, MySQL을 사용한다(SQLite는 개발용).

- DagRun, TaskInstance, Variable, Connection, Serialized DAG, Log 메타정보가 전부 여기에 있다.
- **TaskInstance의 `state = queued`가 실질적인 작업 큐**다. Kafka의 Topic에 해당하는 역할을 DB 테이블이 한다.

# Executor
Task를 **어디서, 어떻게 실행할지**를 결정하는 전략. Scheduler 프로세스 안에 로드된다.

| Executor | 실행 위치 | 비고 |
| --- | --- | --- |
| LocalExecutor | Scheduler와 **같은 서버의 자식 프로세스** | 별도 인프라 불필요 |
| CeleryExecutor | 상주하는 **Celery Worker** | Redis/RabbitMQ **Broker 필요** |
| KubernetesExecutor | **Task마다 별도 Pod** | Pod 기동 overhead 존재, 격리 우수 |

- `executor_constants.py`에 이름은 core 상수로 등록되어 있으나, **Celery/Kubernetes의 구현체는 provider 패키지**에 있다. core에 실제로 포함된 구현은 `local_executor.py` 하나다.
- Airflow 3에서 `SequentialExecutor`는 **제거**되었다. LocalExecutor가 그 역할을 흡수했다.

## LocalExecutor
`multiprocessing`으로 Task를 병렬 실행한다.

```python
from multiprocessing import Queue, SimpleQueue

class LocalExecutor:
    activity_queue: SimpleQueue   # scheduler -> worker  (실행할 작업)
    result_queue:   SimpleQueue   # worker -> scheduler  (실행 결과)
    workers: dict[int, multiprocessing.Process]
```

- `activity_queue`는 **프로세스 메모리상의 휘발성 버퍼**다. Scheduler가 죽으면 사라진다.
- 영속적인 큐는 DB의 `state = queued`이므로, Scheduler 재기동 시 `adopt_or_reset_orphaned_tasks`가 복구한다.
- Task는 `multiprocessing.Process`로 **fork**되어 실행된다.

# Scheduler 내부
## Scheduler Loop
`scheduler_job_runner.py`의 `_run_scheduler_loop()`가 아래를 반복한다.

```text
_do_scheduling(session)
  ├─ _create_dag_runs                        DagRun 생성
  ├─ _schedule_dag_run                       의존성/Pool 판정
  ├─ _executable_task_instances_to_queued    DB에 state=queued 기록   <- 진짜 큐
  └─ _enqueue_task_instances_with_queued_state
                                             executor.queue_workload()  <- 메모리 큐
executor.heartbeat()                         activity_queue에서 꺼내 worker fork
_process_executor_events()                   result_queue 결과를 DB에 반영
timers.run()                                 주기 작업
```

핵심은 **DB 기록이 먼저, Executor 전달이 나중**이라는 점이다. 그래서 Scheduler가 죽어도 작업이 유실되지 않는다.

Executor로 넘기는 지점은 아래와 같다.

```python
def _enqueue_task_instances_with_queued_state(self, task_instances, executor, session):
    for ti in task_instances:
        workload = workloads.ExecuteTask.make(ti, generator=executor.jwt_generator)
        executor.queue_workload(workload, session=session)
```

- `executor.jwt_generator`가 Task에게 쥐여줄 **JWT를 발급**한다. Task는 이 토큰으로 Execution API에 접근한다.

## Task 상태 전이
```text
none -> scheduled -> queued -> running -> success
                                       └> failed
                                       └> up_for_retry -> scheduled
                                       └> up_for_reschedule (Sensor)
                                       └> deferred (Triggerer)
```

전체 상태값은 아래와 같다.

```text
removed, scheduled, queued, running, success, restarting,
failed, up_for_retry, up_for_reschedule, upstream_failed, skipped, deferred
```

- DagRun의 상태는 `queued`, `running`, `success`, `failed` 4개뿐이다.
- `queued`에서 넘어가지 못하는 Task는 `_handle_tasks_stuck_in_queued`가 처리한다.

## Timer
Scheduler Loop 안에서 주기적으로 수행되는 작업들

| 작업 | 기본 주기 | 내용 |
| --- | --- | --- |
| `_emit_pool_metrics` | 5초 | Pool 사용량 metric 발행 |
| `_find_and_purge_task_instances_without_heartbeats` | 10초 | Zombie Task 정리 |
| `check_trigger_timeouts` | 15초 | Deferred Task의 timeout 확인 |
| `_update_dag_run_state_for_paused_dags` | 60초 | Pause된 DAG의 DagRun 상태 갱신 |
| `adopt_or_reset_orphaned_tasks` | 300초 | Scheduler 비정상 종료 시 남은 Task 복구 |

# Task 실행
## Execution API
Airflow 3에서 **Task는 Metadata DB에 직접 접근하지 않는다.**

```text
[Airflow 2]  task ──(DB 접속정보)──> Metadata DB
[Airflow 3]  task ──(JWT)──> api-server ──> Metadata DB
```

- Scheduler가 Task를 띄울 때 JWT를 함께 발급하고, Task는 그 토큰으로 api-server의 Execution API에 상태를 보고한다.
- **Task에게 DB 자격증명을 배포할 필요가 없어진 것**이 Airflow 3 보안 모델의 핵심 변화다.

## Trigger Rule
Upstream Task의 결과에 따라 해당 Task를 실행할지 판단하는 규칙. 기본값은 `all_success`.

```text
all_success    all_failed     all_done     all_skipped
one_success    one_failed     one_done
none_failed    none_skipped   none_failed_min_one_success
all_done_min_one_success      all_done_setup_success
always
```

- `all_done`은 성공/실패와 무관하게 upstream이 **끝나기만 하면** 실행된다. 정리(cleanup) Task에 쓴다.
- `none_failed_min_one_success`는 분기(Branch) 뒤에 합류하는 Task에 쓴다.

# Airflow 2 -> 3 변경점
| 구분 | Airflow 2 | Airflow 3 |
| --- | --- | --- |
| Web | `webserver` | **`api-server`** (REST + UI 통합) |
| DAG 파싱 | Scheduler 내부 서브프로세스 | **`dag-processor` 독립 프로세스(필수)** |
| Task의 DB 접근 | 직접 접속 | **Execution API + JWT 경유** |
| 날짜 | `execution_date` | `logical_date` |
| 스케줄 | `schedule_interval` | `schedule` |
| 데이터 인식 스케줄링 | `Dataset` | **`Asset`** |
| SubDAG | 지원 | **제거** (TaskGroup 사용) |
| import | `airflow.operators.*` | **`airflow.sdk`**, `airflow.providers.standard.*` |
| SequentialExecutor | 존재 | **제거** |

- `airflow.task.trigger_rule`은 3.1부터다. 3.0.3에는 없고 `airflow.utils.trigger_rule`만 있다.
  - 즉, 해당 import를 쓰는 DAG는 **Airflow 3.1 이상**을 요구한다.

# DAG Folder와 PYTHONPATH
Airflow 3는 **DAG 폴더를 `sys.path`에 자동으로 추가하지 않는다.**

```text
dags/
├── common/            <- __init__.py 없음 (namespace package)
│   └── util.py
└── my_dag.py          <- from common.util import ... 시 ModuleNotFoundError
```

- DAG 파일에서 공통 모듈을 import하려면 `PYTHONPATH`에 DAG 폴더를 **명시적으로 넣어야 한다.**

```console
[root@airflow-user ~]# export PYTHONPATH=/opt/airflow/dags
--------------------------------------
- Command
  - DAG 폴더를 모듈 탐색 경로에 추가한다. dag-processor, scheduler, api-server 모두에 적용되어야 한다.
```

# Kubernetes 배포 구성
LocalExecutor + Postgres 조합의 최소 구성

```text
사용자 -> Route -> Service(8080) -> [ Pod: airflow ]

[ Pod: airflow ]
 ├─ initContainers
 │    clone-repo(git) -> emptyDir -> install-oc -> wait-postgres
 └─ container: airflow   (scheduler & dag-processor & api-server)
      ├─ /opt/airflow/dags   <- emptyDir  (initContainer가 채움)
      └─ /opt/airflow/logs   <- PVC       (Pod가 죽어도 보존)

[ Pod: airflow-postgres ]
      └─ /var/lib/postgresql/data  <- PVC
```

- **DAG는 emptyDir**이 맞다. git clone으로 언제든 복원되므로 영속화할 이유가 없다.
- **로그는 PVC**여야 한다. Pod 재기동 후에도 과거 Task의 로그를 UI에서 봐야 하기 때문이다.
- `/opt/airflow`는 Airflow의 기본 경로(`AIRFLOW_HOME`)다. 그 외 경로는 전부 임의로 정한 값이므로, clone 경로 / mountPath / `dags_folder` 세 곳이 **일치해야 한다.**

# Option
```text
[core]
executor                        사용할 Executor. 기본 LocalExecutor
parallelism                     전체 동시 실행 Task 수 상한
max_active_tasks_per_dag        DAG 하나당 동시 실행 Task 수 상한
max_active_runs_per_dag         DAG 하나당 동시 실행 DagRun 수 상한
dags_folder                     DAG 파일 경로

[scheduler]
scheduler_heartbeat_sec         Scheduler Loop 주기
parsing_processes               DAG 파싱 병렬 프로세스 수

[dag_processor]
refresh_interval                DAG 폴더 재탐색 주기
min_file_process_interval       같은 파일을 다시 파싱하기까지의 최소 간격

[api]
port                            api-server 포트. 기본 8080
```

- 운영 중 DAG 파일만 교체하는 배포(이미지 재빌드 없음)를 쓴다면 `refresh_interval`이 **반영 지연 시간**이 된다.

# Command
각 컴포넌트 기동
```console
[root@airflow-user ~]# airflow api-server --port 8080
--------------------------------------
- Command
  - REST API와 UI를 함께 서빙하는 프로세스를 띄운다.
-- Option
  - --port
    - 바인딩할 포트. 기본 8080
```

```console
[root@airflow-user ~]# airflow scheduler
--------------------------------------
- Command
  - DagRun 생성과 Task 스케줄링을 수행한다. Executor를 내부에 품는다.
```

```console
[root@airflow-user ~]# airflow dag-processor
--------------------------------------
- Command
  - DAG 파일을 파싱하여 Serialized DAG를 DB에 저장한다. Airflow 3에서는 필수다.
```

DB 초기화
```console
[root@airflow-user ~]# airflow db migrate
--------------------------------------
- Command
  - 메타데이터 DB의 스키마를 현재 버전에 맞게 생성/변경한다.
```

DAG 재직렬화
```console
[root@airflow-user ~]# airflow dags reserialize
--------------------------------------
- Command
  - dags_folder의 DAG를 다시 파싱하여 DB에 반영한다. dag-processor의 주기를 기다리지 않고 즉시 반영할 때 쓴다.
```

DAG 목록/파싱 오류 확인
```console
[root@airflow-user ~]# airflow dags list
--------------------------------------
- Command
  - DB에 등록된 DAG 목록을 조회한다. 여기에 없으면 파싱 단계에서 실패한 것이다.
```

```console
[root@airflow-user ~]# airflow dags list-import-errors
--------------------------------------
- Command
  - DAG 파싱 중 발생한 import 오류를 조회한다. ModuleNotFoundError는 대부분 PYTHONPATH 문제다.
```

DAG 수동 실행
```console
[root@airflow-user ~]# airflow dags trigger sample_dag --conf '{"dryRun": true}'
--------------------------------------
- Command
  - DAG를 즉시 1회 실행한다.
-- Option
  - --conf
    - DagRun에 전달할 파라미터. DAG 내에서 dag_run.conf로 접근한다.
```

단일 Task만 테스트
```console
[root@airflow-user ~]# airflow tasks test sample_dag sample_task 2026-10-06
--------------------------------------
- Command
  - DagRun을 만들지 않고 Task 하나만 실행한다. DB에 상태를 기록하지 않으므로 로직 검증에 쓴다.
```

올인원 기동(개발용)
```console
[root@airflow-user ~]# airflow standalone
--------------------------------------
- Command
  - api-server, scheduler, dag-processor, triggerer를 한 번에 띄운다. 운영에는 쓰지 않는다.
```

# Reference
- Airflow Architecture Overview: [https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/overview.html](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/overview.html)  
- Airflow 3 Upgrade Guide: [https://airflow.apache.org/docs/apache-airflow/stable/installation/upgrading_to_airflow3.html](https://airflow.apache.org/docs/apache-airflow/stable/installation/upgrading_to_airflow3.html)  
- Executor: [https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html](https://airflow.apache.org/docs/apache-airflow/stable/core-concepts/executor/index.html)  
