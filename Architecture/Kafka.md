# Kafka
- Kafka Cluster
---

# Kafka Cluster
- Borker들의 집합(보통 Broker는 3개 이상으로 홀수개로 구성하는 것을 추천한다)
- Message 순서보장은 하나의 파티션 내에서만 가능하다.
![Kafka Architecture](../Resource/Infra,%20Kafka,%20architecture/슬라이드1.PNG)
![Kafka Architecture](../Resource/Infra,%20Kafka,%20architecture/슬라이드2.PNG)
![Kafka Architecture](../Resource/Infra,%20Kafka,%20architecture/슬라이드3.PNG)

## Broker
Producer와 Consumer간의 Message는 Serialized된 Message(byte array 형태)만 전송이 가능하기 때문에, serialized된 Message(byte array)만 저장된다.

## Topic / Partition
- Kafka는 하나의 파티션 내에서만 메시지 순서를 보장한다.
- Leader Partition, Follower Partition을 두어 HA를 구성함에 있어, Message의 누락을 방지한다.
  - Leader Partition: 운영이 되는 Partition
  - Follower Partition: exclusive broker에 자신의 partition을 복제해둔다.(replication-factor)

### Command
특정 Topic 조회
```console
[root@kafka-user ~]# kafka-topics --bootstrap-server localhost:9092 --list --topic topic-sample
--------------------------------------
- Command
  - 특정 topic(topic-sample)을 조회한다.
```

특정 Topic 상세조회
```console
[root@kafka-user ~]# kafka-topics --bootstrap-server localhost:9092 --describe --topic topic-sample
--------------------------------------
- Command
  - 특정 topic(topic-sample)을 상세조회한다.
```

Topic 생성
```console
[root@kafka-user ~]# kafka-topics --bootstrap-server localhost:9092 --create --topic topic-sample
--------------------------------------
- Command
  - 특정 topic(topic-sample)을 생성한다.
```

Topic/Multi Partition 생성
```console
[root@kafka-user ~]# kafka-topics --bootstrap-server localhost:9092 --create --topic topic-sample --partitions 3
--------------------------------------
- Command
  - 특정 topic(topic-sample)을 생성한다.
-- Option
  - --partitions
    - multi partition을 만들며, 값으로는 갯수를 기재한다.
```

## Producer
### Strategy
- Key값을 가지지 않는 Message 전송의 파티션 분배 전략
  - Round Robin
  - Sticky

### Command
producer cli
```console
[root@kafka-user ~]# kafka-console-producer --bootstrap-server localhost:9092 --topic topic-sample
> 보낼메시지1
> 보낼메시지2
> 보낼메시지3
--------------------------------------
- Command
  - topic에 데이터를 보낸다.
```

```console
[root@kafka-user ~]# kafka-console-producer --bootstrap-server localhost:9092 --topic topic-sample --property key.separator=: --property parse.key=true
> user1:보낼메시지1
> user2:보낼메시지2
> user3:보낼메시지3
--------------------------------------
- Command
  - topic에 데이터를 key/value 형태로 보낸다.
```

## Consumer
- 모든 Consumer들은 단 하나의 Consumer Group에 소속되어야 하며, Consumer Group은 1개 이상의 Consumer를 가질 수 있다.

### Strategy
- Assign 전략

### Command
auto.offset.reset
```console
[root@kafka-user ~]# kafka-console-consumer --bootstrap-server localhost:9092 --topic topic-sample --from-beginning
--------------------------------------
- Command
  - Consumer로 데이터를 읽어들인다.
- Option
  - --from-beginning
    - Consumer가 Topic에 처음 접속하여, Message를 가져올 때, 가장 먼저 들어온 offset(earliest)을 가져올지, 가장 마지막으로 들어온 offset부터 가져올지 설정하는 파라미터
```

```console
[root@kafka-user ~]# kafka-console-consumer --bootstrap-server localhost:9092 --topic topic-sample --property print.key=true --property print.value=true --from-beginning --property print.partition=true
--------------------------------------
- Command
  - Consumer로 데이터를 key/value형태로 읽어들인다.
- Option
  - --from-beginning
    - Consumer가 Topic에 처음 접속하여, Message를 가져올 때, 가장 먼저 들어온 offset(earliest)을 가져올지, 가장 마지막으로 들어온 offset부터 가져올지 설정하는 파라미터
  - --property print.key=true
    - console에 key를 노출유무를 기재
  - --property print.value=true
    - console에 value를 노출유무를 기재
  - --property print.partition=true
    - console에 partition정보 노출유무를 기재
```

## Consumer Group
- Consumer Group 내 Consumer의 변화가 있을 때 마다 Rebalancing이 이루어진다.
- 보통 하나의 파티션은 하나의 Consumer로 1:1 관계를 맺는다.(다른 Consumer Group과는 신경쓰지 않는다)

### Command
```console
[root@kafka-user ~]# kafka-consumer-groups --bootstrap-server localhost:9092 --list
--------------------------------------
- Command
  - Consumer의 group을 조회한다.
```

```console
[root@kafka-user ~]# kafka-consumer-groups --bootstrap-server localhost:9092 --describe --group consumer-group-sample
--------------------------------------
- Command
  - Consumer의 특정 group의 상세정보를 조회한다.
- Option
  - consumer-group-sample
```

## Config
- [Server Lv] Broker와 Topic Lv Config
  - Broker Config는 base가 되는 config이며, Topic별로 설정하고 싶을 때, Topic의 config에서 override할 수 있다.
- [Clinet Lv] Producer와 Consumer Lv Config

### Command
```console
[root@kafka-user ~]# kafka-configs -bootstrap-server [hostip:port] --entity-type [brokers/topics] --entity-name [broker id/topic name] --all --describe
--------------------------------------
- Command
  - Config 값 확인
```

```console
[root@kafka-user ~]# kafka-configs -bootstrap-server [hostip:port] --entity-type [brokers/topics] --entity-name [broker id/topic name] --alter --add-config property명=value
--------------------------------------
- Command
  - Config 값 설정
```

```console
[root@kafka-user ~]# kafka-configs -bootstrap-server [hostip:port] --entity-type [brokers/topics] --entity-name [broker id/topic name] --alter --delete-config property명
--------------------------------------
- Command
  - Config 값 Unset
```

## Logging
### Command
```console
[root@kafka-user ~]# kafka-dump-log --deep-iteration --files /home/.../sample.log --print-data-log
--------------------------------------
- Command
  - Config 값 설정
```

# Reference
- https://zbvs.tistory.com/35
