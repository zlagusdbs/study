# Overview
Elasticsearch

## RDBMS와 Elasticsearch의 용어비교
| RDBMS     | Elasticsearch  |
|-----------|-----------------|
| Schema    | Mapping         |
| Database  | Index           |
| Partition | Shard           |
| Table     | Type            |
| Row       | Document        |
| Column    | Field           |

# Quickstart
elasticsearch.yml 파일에 설정하는 것 외에도 Elasticsearch 실행 시 커맨드 명령에 -E <옵션>=<값> 을 이용해서 환경 설정이 가능합니다. 예를 들어 클러스터명은 my-cluster 노드명은 node-1로 노드를 실행하기 위해서는 다음과 같이 실행합니.
```
# 환경 설정이 elasticsearch.yml 과 커맨드 명령 -E 에 모두 있는 경우에는 -E 커맨드 명령에서 한 설정이 더 우선해서 적용이 됩니다.
$ bin/elasticsearch -E cluster.name=my-cluster -E node.name="node-1"
[2019-08-26T14:23:51,399][INFO ][o.e.e.NodeEnvironment    ] [node-1] using [1] data paths, mounts [[/ (/dev/disk1s1)]], net usable_space [88.9gb], net total_space [465.6gb], types [apfs]
[2019-08-26T14:23:51,401][INFO ][o.e.e.NodeEnvironment    ] [node-1] heap size [989.8mb], compressed ordinary object pointers [true]
[2019-08-26T14:23:51,455][INFO ][o.e.n.Node               ] [node-1] node name [node-1], node ID [RDBLYDInSxmMV1PEVit_pQ], cluster name [my-cluster]
[2019-08-26T14:23:51,455][INFO ][o.e.n.Node               ] [node-1] version[7.3.0], pid[50389], build[default/tar/de777fa/2019-07-24T18:30:11.767338Z], OS[Mac OS X/10.14.6/x86_64], JVM[Oracle Corporation/Java HotSpot(TM) 64-Bit Server VM/1.8.0_151/25.151-b12]
[2019-08-26T14:23:51,456][INFO ][o.e.n.Node               ] [node-1] JVM home [/Library/Java/JavaVirtualMachines/jdk1.8.0_151.jdk/Contents/Home/jre]
[2019-08-26T14:23:51,456][INFO ][o.e.n.Node               ] [node-1] JVM arguments [-Xms1g, -Xmx1g, -XX:+UseConcMarkSweepGC, -XX:CMSInitiatingOccupancyFraction=75, -XX:+UseCMSInitiatingOccupancyOnly, -Des.networkaddress.cache.ttl=60, -Des.networkaddress.cache.negative.ttl=10, -XX:+AlwaysPreTouch, -Xss1m, -Djava.awt.headless=true, -Dfile.encoding=UTF-8, -Djna.nosys=true, -XX:-OmitStackTraceInFastThrow, -Dio.netty.noUnsafe=true, -Dio.netty.noKeySetOptimization=true, -Dio.netty.recycler.maxCapacityPerThread=0, -Dlog4j.shutdownHookEnabled=false, -Dlog4j2.disable.jmx=true, -Djava.io.tmpdir=/var/folders/0d/m7m670h13pz3lvr9xjz07zk80000gn/T/elasticsearch-5549928559955731670, -XX:+HeapDumpOnOutOfMemoryError, -XX:HeapDumpPath=data, -XX:ErrorFile=logs/hs_err_pid%p.log, -XX:+PrintGCDetails, -XX:+PrintGCDateStamps, -XX:+PrintTenuringDistribution, -XX:+PrintGCApplicationStoppedTime, -Xloggc:logs/gc.log, -XX:+UseGCLogFileRotation, -XX:NumberOfGCLogFiles=32, -XX:GCLogFileSize=64m, -Dio.netty.allocator.type=unpooled, -XX:MaxDirectMemorySize=536870912, -Des.path.home=/Users/kimjmin/elastic/getStart/elasticsearch-7.3.0, -Des.path.conf=/Users/kimjmin/elastic/getStart/elasticsearch-7.3.0/config, -Des.distribution.flavor=default, -Des.distribution.type=tar, -Des.bundled_jdk=true]
```

## Download
[Elasticsearch](https://www.elastic.co)  
[Java Version 확인](https://www.elastic.co/support/matrix#matrix_jvm)

## Analyzer
- 색인(indexing) : 데이터가 검색될 수 있는 구조로 변경하기 위해 원본 문서를 검색어 토큰들으로 변환하여 저장하는 일련의 과정
- 인덱스(index, indices) : 색인을 거친 결과물, 또는 색인된 데이터가 저장되는 저장소입니다. 또한 Elasticsearch에서 도큐먼트들의 논리적인 집합을 표현하는 단위이기도 하다
- 검색(search) : 인덱스에 들어있는 검색어 토큰들을 포함하고 있는 문서를 찾아가는 과정
- 질의(query) : 사용자가 원하는 문서를 찾거나 집계 결과를 출력하기 위해 검색 시 입력하는 검색어 또는 검색 조건

```
# Text Analyzer
text -> Character Filters -> Tokenizer -> TokenFilter -> Inverted Index
          Pattern Replace      Tokenizer    lowercase
          Mapping                           stop
          HTML Strip                        snowball
```

### 

# Envrionment
## Java Option
### Java Heap Memory
- jvm.options
```
-Xms1g
-Xmx1g
```
## Elasticsearch Option
```
# config/elasticsearch.yml
cluster:
  name: {클러스터명}
  initial_master_nodes: [ "{노드-1}", "{노드-2}" ]

node:
  name: {노드명}
  attr:
    {KEY}:{VALUE}
  master: true
  data: true
  ingest: true
  ml: true

path:
  data: /var/lib/elasticsearch
  logs: /var/log/elasticsearch

bootstrap:
  memory_lock: true

network:
  host: {ip 주소}

http:
  port: {port 번호}
```

- cluster.name: {클러스터명}
  - 클러스터명을 설정할 수 있습니다. Elasticsearch의 노드들은 클러스터명이 같으면 같은 클러스터로 묶이고 클러스터명이 다르면 동일한 물리적 장비나 바인딩이 가능한 네트워크상에 있더라도 서로 다른 클러스터로 바인딩이 됩니다. 디폴트 클러스터명은 "elasticsearch" 이며 충돌을 방지하기 위해 클러스터명은 반드시 고유한 이름으로 설정하도록 합니다.

- node.name: {노드명}
  - 실행중인 각각의 elasticsearch 노드들을 구분할 수 있는 노드의 이름을 설정할 수 있습니다. 설정하지 않으면 노드명은 7.0 버전 부터는 호스트명, 6.x 이하 버전에서는 프로세스 UUID의 첫 7글자가 노드명으로 설정됩니다.

- node.attr.{KEY}: {VALUE}
  - 노드별로 속성을 부여하기 위한 일종의 네임스페이스를 지정합니다. 이 설정을 이용하면 hot / warm 아키텍쳐를 구성하거나 물리 장비 구성에 따라 샤드 배치를 임의적으로 조절하는 등의 설정이 가능합니다.

- node.master: true
  - 마스터 후보(master eligible) 노드 여부를 설정합니다. false인 경우 이 노드는 마스터 노드로 선출이 불가능합니다. 모든 클러스터는 1개의 마스터 노드가 존재하며 마스터 노드가 다운되거나 끊어진 경우 남은 마스터 후보 노드들 중에서 새로운 마스터 노드가 선출되게 됩니다.

- node.data: true
   - 노드가 데이터를 저장하도록 합니다. false인 경우 이 노드는 데이터를 저장하지 않습니다.

- node.ingest: true
  - 데이터 색인시 전처리 작업인 ingest pipleline 작업의 수행을 할 수 있는지 여부를 지정합니다. false인 경우 이 노드에서는 ingest pipeline 작업의 실행이 불가능합니다.

- node.ml: true
  - 이 노드가 머신러닝 작업 수행을 할 수 있는지 여부를 지정합니다. false 인 경우 이 노드애서는 머신러닝 작업이 수행되지 않습니다.

    예를 들어 클러스터에서 어떤 노드를 데이터는 저장하거나 색인하지 않고 오직 클러스터 상태를 관리하는 마스터 노드의 역할만 수행하도록 설정하려면 아래와 같이 설정합니다.
    ```
    node.master: true
    node.data: false
    node.ingest: false
    node.ml: false
    ```
    이런 방법으로 클러스터 안의 노드들을 마스터 전용 노드, 데이터 전용 노드 등으로 분리하여 유연한 구성을 할 수 있습니다.
    ```
    앞선 node의 master~ml까지의 설정을 false 로 하게 되면 해당 노드는 데이터를 저장하거나 색인하지 않고 클러스터 상태를 업데이트도 하지 않으며 오직 클라이언트와 통신만 하는 역할로 사용이 가능합니다. 이런 노드를 코디네이트 온리 노드 (coordinate only node) 라고 부릅니다.
    ```

- path.data: {경로}
  - 색인된 데이터를 저장하는 경로를 지정합니다. 디폴트는 Elastcisearch가 설치된 홈 경로 아래의 data 디렉토리 입니다. 배열 형태로 여러개의 경로값의 입력이 가능하기 때문에 한 서버에서 디스크 여러개를 사용할 수 있습니다.

- path.logs: {경로}
  - Elasticsearch 실행 로그를 저장하는 경로를 지정합니다. 디폴트는 Elastcisearch가 설치된 홈 경로 아래의 logs 디렉토리 입니다. 실행중인 시스템 로그는 <클러스터명>.log 형티의 파일로 저장되며 날짜가 변경되면 이전 로그 파일은 뒤에 날짜가 붙은 파일로 변경됩니다.

- bootstrap.memory_lock: true
  - Elasticsearch가 사용중인 힙메모리 영역을 다른 자바 프로그램이 간섭 못하도록 미리 점유하는 설정입니다 항상 true 로 놓고 사용하는것을 권장합니다.

- network.host: {ip 주소}
  - Elasticsearch가 실행되는 서버의 ip 주소입니다. 디폴트는 루프백(127.0.0.1) 입니다. 주석 처리 되어 있거나 루프백인 경우에는 Elasticsearch 노드가 개발 모드로 실행이 됩니다. 만약에 이 설정을 실제 IP 주소로 변경하게 되면 그 때부터는 운영 모드로 실행이 되며 노드를 시작할 때 부트스트랩 체크를 하게 됩니다. network.host는 서버의 내/외부 주소를 모두 지정하는데 만약 내부망에서 사용하는 주소와 외부망에서 접근하는 주소를 다르게 설정하고자 하면 아래의 값 들을 이용해서 구분이 가능합니다.
    ```
    network.bind_host : 내부망
    network.publish_host : 외부망
    ```
  - 그리고 network.host 설정에 사용되는 특별한 변수값이 있는데 다음과 같습니다.
    ```
    _local_ : 루프백 주소 127.0.0.1 과 같습니다. 디폴트로 설정되어 있습니다.
    _site_ : 로컬 네트워크 주소로 설정됩니다. 실제로 클러스터링 구성 시 주로 설정하는 값입니다. 
    _global_ : 네트워크 외부에서 바라보는 주소로 설정합니다.
    ```
    실제로 클러스터를 구성할 때 설정을 network.host: _site_ 로 해 놓으면 서버의 네트워크 주소가 바뀌어도 설정 파일은 변경하지 않아도 되기 때문에 편리합니다.

- http.port: {port 번호}
  - Elasticsearch가 클라이언트와 통신하기 위한 http 포트를 설정합니다. 디폴트는 9200 이며, 포트가 이미 사용중인 경우 9200 ~ 9299 사이 값을 차례대로 사용합니다.

- transport.port: <포트 번호>
  - Elasticsearch 노드들 끼리 서로 통신하기 위한 tcp 포트를 설정합니다. 디폴트는 9300 이며, 포트가 이미 사용중인 경우 9300 ~ 9399 사이의 값을 차례대로 사용합니다.

- discovery.seed_hosts: [ "<호스트-1>", "<호스트-2>", ... ]
  - 클러스터 구성을 위해 바인딩 할 원격 노드의 IP 또는 도메인 주소를 배열 형태로 입력합니다. 주소만 적는 경우 디폴트로 9300~9305 사이의 포트값을 검색하며, tcp 포트가 이 범위 밖에 설정 된 경우 포트번호 까지 같이 적어주어야 합니다. 이렇게 원격에 있는 노드들을 찾아 바인딩 하는 과정을 디스커버리 라고 합니다. 디스커버리에 대해서는 3.1 클러스터 구성 : 디스커버리 부분에서 설명하고 있습니다.
  ```
  discovery.seed_hosts 옵션은 7.0 부터 추가된 기능입니다. 6.x 이전 버전에서는 대신에 젠 디스커버리를 사용했습니다. 사용 방법은 아래와 같습니다.
  
  discovery.zen.ping.unicast.hosts: [ "<호스트-1>", "<호스트-2>", ... ]
  ```

- cluster.initial_master_nodes: [ "<노드-1>", "<노드-2>" ]
  - 클러스터가 최초 실행 될 때 명시된 노드들을 대상으로 마스터 노드를 선출합니다. 마스터 노드에 대해서는 3.3 마스터 노드와 데이터 노드 장에서 자세 다루도록 하겠습니다.
  ```
  cluster.initial_master_nodes 옵션 역시 7.0 부터 추가된 기능입니다. 6.x 이전 버전에서는 최소 마스터 후보 노드를 지정하기 위해 다음 옵션을 사용했습니다. 7.0 버전 부터는 최소 마스터 후보 노드의 크기가 능동적으로 변경됩니다.

  discovery.zen.minimum_master_nodes: 2
  ```
  노드 실행시 지정된 환경변수를 elasticsearch.yml 에서 ${환경변수명} 형식으로 사용이 가능합니다.
  ```
  node.name: ${HOSTNAME}
  network.host: ${ES_NETWORK_HOST}
  ```


# Architecture
## Cluster
Elasticsearch의 노드들은 클라이언트와의 통신을 위한 http 포트(9200~9299), 노드 간의 데이터 교환을 위한 tcp 포트 (9300~9399) 총 2개의 네트워크 통신을 열어두고 있습니다.
일반적으로 1개의 물리 서버마다 하나의 노드를 실행하는 것을 권장하고 있습니다.
3개의 다른 물리 서버에서 각각 1개 씩의 노드를 실행하면 각 클러스터는 다음과 같이 구성됩니다.

## Node
### Master Node(=Dedicated Master Node)
인덱스의 메타 데이터, 샤드의 위치와 같은 클러스터 상태(Cluster Status) 정보를 관리하는 등 단지 마스터 노드의 역할만을 수행한다.
```
# config/elasticsearch.yml
node:
  master: true
  data: false
```
### Data Node
실제로 색인된 데이터를 저장하고 있는 노드
```
# config/elasticsearch.yml
node:
  master: false
  data: true
```
### Split Brain
각자의 클러스터에 데이터가 추가되거나 변경되고 나면 나중에 네트워크가 복구 되고 하나의 클러스터로 다시 합쳐졌을 때 데이터 정합성에 문제가 생기고 데이터 무결성이 유지될 수 없게 되는 문제를 Split Brain 이라고 합니다.
```
# config/elasticsearch.yml
discovery.zen.minimum_master_nodes: 2    # =((전체 마스터 후보 노드 / 2) + 1)
```

## Index & Shard


# Reference
[이보다 더 깔끔한 강의는 없었던거 같다.](https://esbook.kimjmin.net/)
