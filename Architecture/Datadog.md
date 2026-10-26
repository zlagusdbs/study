# Datadog
- Metrics
  - Query
  - Tag
- Monitors
  - Monitor
  - Status
  - Option
    - Choose the detection method
    - Define the metric
    - Set alert conditions
    - Configure notifications and automations
    - Define permissions and audit notifications
  - Example
- Reference

---

# Metrics
Datadog 전반(Monitors, Dashboards, Notebooks 등)에서 공통으로 쓰는 지표 조회 방식

## Query
```text
p50:trace.servlet.request{env:prod,service:my-api} by {resource_name}
```

| 구성 | 의미 | 예시 |
| --- | --- | --- |
| 집계 방식 | 여러 값을 어떤 통계로 합칠지 (avg, sum, min, max, p50, p99 등) | `p50`: 중간값 |
| 지표 이름 | 볼 지표 | `trace.servlet.request`: 서버가 받은 HTTP 요청의 처리 시간 |
| `{...}` (from) | 범위를 좁히는 태그 조건 | `env:prod`, `service:my-api` |
| `by {...}` | 무엇별로 나눌지 | `by {resource_name}`: URI 별로 따로 계산 |
| 함수 (Modify) | 쿼리 결과에 함수 적용 | `.as_count()`, 이동평균 등 |
| Formula | 여러 쿼리를 계산식으로 묶음 | 에러율 = `a / b` (a: 에러 수, b: 전체 요청 수) |

- 화면에서는 `a` `b` `c` 로 쿼리 이름이 붙는다. `Add Query` 로 쿼리를, `Add Formula` 로 계산식을 추가한다.
- `by` 를 쓰지 않으면 화면에 `(everything)` 으로 표시된다. 나누지 않고 전체를 하나의 값으로 본다.

## Tag
Datadog 의 모든 데이터에 붙는 `key:value` 꼬리표. 검색, 필터, 그룹 기준으로 쓴다.

| 예시 | 의미 |
| --- | --- |
| `env:prod` | 운영 환경 |
| `service:my-api` | 서비스 이름 |
| `resource_name:get_/orders` | APM 에서 요청 URI |
| `http.status_code:503` | HTTP 응답 코드 |

- 태그 형식을 통일해야 필터와 알림 정책이 일관되게 동작한다.

# Monitors
## Monitor
Metric, Trace, Log 등의 지표를 주기적으로 평가하여, 조건을 만족하면 **알림(Notification)을 보내는 기능**

- 모니터는 보통 **1분마다** 쿼리를 다시 계산해서 상태를 정한다.
- 알림은 **상태가 바뀔 때** 발송된다. 같은 상태가 유지되는 동안에는 다시 보내지 않는다(Renotification 제외).

## Status
| 상태 | 의미 |
| --- | --- |
| OK | 기준 이하 |
| Warn | Warning 기준 초과 |
| Alert | Alert 기준 초과 |
| No Data | 정해진 시간 동안 데이터가 들어오지 않음 |

## Option
모니터 생성/수정 화면의 순서대로 정리한다.

### 1. Choose the detection method
어떤 방식으로 "이상하다"고 판단할지 정한다.

| 방식 | 의미 | 예시 (API 응답시간 p50 기준) |
| --- | --- | --- |
| **Threshold Alert** | 고정된 기준값을 넘으면 울림 | p50 이 0.1초를 넘으면 경보 |
| Change Alert | 이전 시점과 비교한 **변화량**이 크면 울림 | 30분 전 0.02초 → 지금 0.06초 (3배) |
| Anomaly Detection | 과거 패턴(요일·시간대)에서 벗어나면 울림 | 평소 월요일 10시 0.02초인데 오늘 0.05초 |
| Outliers Alert | 여러 그룹 중 **혼자 튀는** 그룹을 찾음 | 파드 10개 중 1개만 0.3초 |
| Forecast Alert | 추세로 보아 **곧** 기준을 넘을 것 같으면 미리 울림 | 디스크 사용률이 이 속도면 3일 뒤 100% |
| Watchdog | 설정 없이 Datadog 이 자동으로 이상 탐지 | - |

### 2. Define the metric
무엇을 볼지 정한다. 쿼리 작성법은 [Metrics - Query](#query) 와 같다.

```text
a   trace.servlet.request   from   env:prod, service:my-api   p50 by   (everything)
```

- `by` 에 따라 알림 단위가 달라진다.
  - `(everything)`: 모니터 1개가 전체 값 하나를 본다. 알림도 1개다. **Simple Alert**
  - `by resource_name`: URI 별로 따로 판단한다. 한 URI 만 느려도 그 URI 알림만 온다. **Multi Alert**

#### Evaluation Details
| 칸 | 의미 | 예시 |
| --- | --- | --- |
| **Evaluate the** | 기간 안의 값을 어떤 숫자 하나로 줄일지 (average, max, min, sum, percentile 등) | percentile(p50): 5분 동안 요청 100,000건을 빠른 순으로 세워 50,000번째 값 = 0.03초 |
| **Of the query over the** | 계산에 쓰는 기간 (평가 창) | last 5 minutes: 10:07 평가 → 10:02~10:07 요청만 사용 |

- 평가 창이 **길면** 순간적인 튐에 덜 울리지만 알림이 늦다.
- 평가 창이 **짧으면** 빨리 울리지만 잠깐 튄 것에도 울린다.
- 선택 가능한 기간은 드롭다운에 있는 값만 가능하다. (예: last 2 minutes 는 없음)

### 3. Set alert conditions
언제 울릴지 정한다.

#### Threshold
| 칸 | 의미 | 예시 |
| --- | --- | --- |
| **Trigger when the evaluated value is** | above(클 때) / below(작을 때) 등 | above |
| **Alert threshold** | 이 값을 넘으면 Alert | `> 0.1` (100ms) |
| **Warning threshold** | 이 값을 넘으면 Warn (선택) | `> 0.05` (50ms) |

#### If data is missing
`If data is missing for N minutes` : N분 동안 데이터가 없을 때 할 일

| 선택지 | 데이터가 끊기면 |
| --- | --- |
| Evaluate as zero | 값을 0으로 보고 판단 (대개 OK) |
| Show OK | 상태를 OK 로 둠 |
| Show NO DATA | 상태를 No Data 로 바꿈, **알림 안 보냄** |
| Show NO DATA and notify | 상태를 No Data 로 바꾸고 **알림 보냄** |

- 같은 지표를 보는 모니터가 여러 개면, **한 모니터만** `and notify` 로 두면 중복 알림을 피할 수 있다.

#### Advanced options - Recovery Thresholds
**얼마나 내려와야 풀리는지**를 따로 정한다.

| 칸 | 의미 | 예시 |
| --- | --- | --- |
| Alert recovery threshold | Alert 에서 빠져나오려면 이 값 **이하** | `<= 0.08` |
| Warning recovery threshold | Warn 에서 OK 로 가려면 이 값 **이하** | `<= 0.04` |

- 회복 기준이 없으면 값이 기준 근처에서 0.101 → 0.099 → 0.102 로 흔들릴 때 알림이 켜졌다 꺼졌다를 반복한다(flapping).
- 켜는 기준(0.1)보다 끄는 기준(0.08)을 낮게 둬서 이를 막는다(hysteresis).
- 회복 기준값을 Alert/Warning threshold 칸에 넣지 않도록 주의한다.

시간 순서 예시 (Alert 0.1 / Warning 0.05 / 회복 0.08 / 0.04, 1분마다 평가)

| 시각 | p50 | 상태 | 이유 |
| --- | --- | --- | --- |
| 10:00 | 0.03 | OK | 0.05 이하 |
| 10:01 | 0.06 | **Warn** | 0.05 초과 |
| 10:02 | 0.12 | **Alert** | 0.1 초과 |
| 10:03 | 0.09 | Alert 유지 | 0.1 아래지만 0.08 까지 안 내려옴 |
| 10:04 | 0.07 | **Warn** (alert → warning) | 0.08 이하라 Alert 해제, 아직 0.05 초과 |
| 10:05 | 0.045 | Warn 유지 | 0.05 아래지만 0.04 까지 안 내려옴 |
| 10:06 | 0.03 | **OK** (recovery) | 0.04 이하 |

#### Advanced options - Missing data options
| 칸 | 의미 | 예시 |
| --- | --- | --- |
| If a group stops reporting data, resolve after N hours | Multi Alert 에서 **특정 그룹**의 데이터가 끊기면 N시간 뒤 그 그룹의 경보를 자동 정리 | `by pod` 일 때 파드가 재배포되어 사라지면 2시간 뒤 그 파드의 경보 삭제 |

- Simple Alert(`(everything)`)는 그룹이 하나뿐이라 꺼 둬도 된다.

#### Advanced options - Evaluation options
| 칸 | 의미 | 예시 |
| --- | --- | --- |
| Delay monitor evaluation by N seconds | 평가를 N초 늦춰, 늦게 도착하는 데이터까지 포함 | 60 이면 10:07 평가가 10:01~10:06 구간을 봄. 클라우드 지표처럼 늦게 들어오는 경우에 씀 |
| Do not require / Require a full window of data | **Require** 면 평가 창이 데이터로 꽉 차야만 평가 | 요청이 드문 지표에서 1~2건으로 판단하는 것을 막음 |

- 초당 수백 건씩 들어오는 지표라면 `0초 / Do not require` 로 둬도 된다.

### 4. Configure notifications and automations
#### Message (Template Variable)
메시지 본문에서 상태별로 다른 문구를 보낼 수 있다.

| 변수 | 출력 시점 |
| --- | --- |
| `{{#is_alert}}...{{/is_alert}}` | Alert 상태 |
| `{{#is_warning}}...{{/is_warning}}` | Warn 상태 |
| `{{#is_alert_to_warning}}...{{/is_alert_to_warning}}` | Alert → Warn 으로 내려올 때 |
| `{{#is_no_data}}...{{/is_no_data}}` | No Data 상태 |
| `{{#is_recovery}}...{{/is_recovery}}` | OK 로 회복될 때 |
| `{{^is_alert_to_warning}}...{{/is_alert_to_warning}}` | `^` 는 부정. Alert → Warn 이 **아닐 때** |
| `{{value}}` | 평가된 값 |
| `@handle` | 알림을 보낼 대상 (예: `@teams-채널명`, `@slack-채널명`) |

- Alert → Warn 으로 내려올 때는 `is_warning` 과 `is_alert_to_warning` 이 **둘 다 참**이다. 두 블록이 함께 출력되지 않게 하려면 warning 블록을 부정으로 감싼다.

```text
{{#is_alert}}
🚨 응답 느림: p50 {{value}}초 (경보 0.1초)
{{/is_alert}}

{{#is_warning}}{{^is_alert_to_warning}}
⚠️ 응답 느려지는 중: p50 {{value}}초 (주의 0.05초)
{{/is_alert_to_warning}}{{/is_warning}}

{{#is_alert_to_warning}}
↘️ 응답 일부 회복: p50 {{value}}초
{{/is_alert_to_warning}}

{{#is_recovery}}
✅ 응답 회복
{{/is_recovery}}

@teams-my-channel
```

- 저장 전에 메시지 칸 위의 **Preview** 에서 Alert / Warn / OK 상태를 하나씩 눌러, 상태마다 해당 블록만 보이는지 확인한다.

#### Automate Response / Runbook / Bits
| 칸 | 의미 | 예시 |
| --- | --- | --- |
| Automate Response (Add Workflow) | 알림이 울릴 때 Datadog Workflow 자동 실행 | 스크립트 실행, 티켓 생성 |
| Add Runbook | 대응 절차 문서를 알림에 연결 | - |
| Investigate with Bits | Datadog AI 가 원인 조사를 제안 | - |

#### Notification Options
| 칸 | 의미 | 예시 |
| --- | --- | --- |
| Content displayed in notification | 알림에 쿼리·그래프 등 부가 정보를 얼마나 붙일지 | **Hide All**: 메시지 본문만 |

- `Hide All` 로 두어도 `Monitor tags`, 발송 경로(webhook handle) 줄은 지울 수 없다.

#### Renotification
| 칸 | 의미 | 예시 |
| --- | --- | --- |
| If this monitor stays in [status] renotify every [time] | 해결되지 않으면 일정 간격으로 같은 알림을 다시 보냄 | Alert 상태로 30분마다: 10:02 Alert → 10:32, 11:02 재발송 |

- 꺼 두면 상태가 바뀔 때만 알림이 온다.

#### Metadata
| 칸 | 의미 | 예시 |
| --- | --- | --- |
| Priority | 중요도 (P1 가장 높음 ~ P5) | P1 (Critical) |
| Tags | 모니터 검색·분류용 태그 ([Metrics - Tag](#tag)) | `env:production` |
| Team | 담당 팀 지정 | - |

- Tags 를 비워 두면 알림에 `Monitor tags: []` 로 표시된다.

### 5. Define permissions and audit notifications
| 칸 | 의미 | 예시 |
| --- | --- | --- |
| Unrestricted / Edit Access | 누가 모니터를 수정할 수 있는지 | Unrestricted: 조직 안 누구나 수정 가능 |
| Audit Notifications | 모니터가 **수정되면** 생성자와 수신자에게 알릴지 | Do not notify |

- 중요한 기간에 기준값이 임의로 바뀌는 것을 막으려면 Edit Access 를 제한하고 Audit Notifications 를 켠다.

## Example
API 응답시간 p50 모니터 설정 예시
```text
[1. Choose the detection method]
Threshold Alert

[2. Define the metric]
query                           p50:trace.servlet.request{env:prod,service:my-api}
Evaluate the                    percentile (p50)
Of the query over the           last 5 minutes

[3. Set alert conditions]
Trigger when                    above
Alert threshold                 0.1
Warning threshold               0.05
If data is missing for 5 min    Show NO DATA (알림 안 보냄)
Alert recovery threshold        0.08
Warning recovery threshold      0.04
resolve after N hours           미사용
Delay evaluation                0 seconds
Full window of data             Do not require

[4. Configure notifications and automations]
Content displayed               Hide All
Renotification                  미사용
Priority                        P1
Tags                            없음

[5. Define permissions and audit notifications]
Access                          Unrestricted
Audit Notifications             Do not notify
```

# Reference
- Metrics Query: [https://docs.datadoghq.com/metrics/](https://docs.datadoghq.com/metrics/)  
- Tagging: [https://docs.datadoghq.com/getting_started/tagging/](https://docs.datadoghq.com/getting_started/tagging/)  
- Metric Monitor: [https://docs.datadoghq.com/monitors/types/metric/](https://docs.datadoghq.com/monitors/types/metric/)  
- Monitor Configuration: [https://docs.datadoghq.com/monitors/configuration/](https://docs.datadoghq.com/monitors/configuration/)  
- Template Variables: [https://docs.datadoghq.com/monitors/notify/variables/](https://docs.datadoghq.com/monitors/notify/variables/)  
