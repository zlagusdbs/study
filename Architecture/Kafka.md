# Kafka
- Kafka Cluster
  - Broker
  - Topic
  - Partition
  - Group Coordinator
- Producer
  - Partition Assignment Strategy
  - Send(with acks)
- Consumer
  - Consumer의 구성요소
- Consumer Group
  - Rebalance
  - Partition Assignment Strategy
- Zookeeper
- Trouble Shooting
- Logging
- Kafka Design
  - Enterprise Integration Patterns
    - Request-Reply Pattern
- Reference

---

# Kafka Cluster
- Borker들의 집합(보통 Broker는 3개 이상으로 홀수개로 구성하는 것을 추천한다)
- Message 순서보장은 하나의 파티션 내에서만 가능하다.
![Kafka Cluster Architecture](../Resource/Architecture%2C%20Kafka/%EC%8A%AC%EB%9D%BC%EC%9D%B4%EB%93%9C1.PNG)

![Producer](../Resource/Architecture%2C%20Kafka/%EC%8A%AC%EB%9D%BC%EC%9D%B4%EB%93%9C2.PNG)
- [Producer](Kafka.md#producer)

![Consumer](../Resource/Architecture%2C%20Kafka/%EC%8A%AC%EB%9D%BC%EC%9D%B4%EB%93%9C3.PNG)
- [Consumer](Kafka.md#consumer)

## Broker
Producer와 Consumer간의 Message는 Serialized된 Message(byte array 형태)만 전송이 가능하기 때문에, serialized된 Message(byte array)만 저장된다.

## Topic
K8S의 Namespace와 같은 의미이다. 즉, 논리적 묶음을 뜻한다.

## Partition
K8S의 Pod와 같은 의미이다. 실제로 데이터를 처리하는 서버

- Kafka는 하나의 파티션 내에서만 메시지 순서를 보장한다.
- Leader Partition, Follower Partition을 두어 HA를 구성함에 있어, Message의 누락을 방지한다.
  - Leader Partition: 운영이 되는 Partition
  - Follower Partition: exclusive broker에 자신의 partition을 복제해둔다.(replication-factor)

### Replicas
복제된 Follower Partition 정보

### ISR(In-Sync Replicas)
복제된가 잘 된 Follower Partition 정보

### Preferred Leader Election
Broker가 shutdown 후 재기동 될 때, 파티션 별로 최초 할당된 Leader/Follower Partition 설정을 그대로 유지

- Follwer Partition들은 누구라도 Leader Partition이 될 수 있지만, 단, ISR 내에 있는 Follower Partition들만 가능하다.
- Leader Partition는 Follower Partition들이 Leader Parititon이 될 수 있는지 지속적인 모니터링을 한다.
  - 모니터링 시, offset 번호를 비교한다.

### Unclean Leader Election
Leader Patition이 shutdown되고, Follower Partition이 Leader Partition으로 승격되어야 할 때, Offset 정보가 완전히 복제된 상태가 아니라면, 묻고 떠블로 갈지를 정하는 설정이다.

## Group Coordinator
- Kafka Broker 중 하나가 Consumer Group에 대한 Group Coordinator 역할을 맡는다.
- internal topic(내부적으로 생성되는 토픽)으로 __consumer_offsets 토픽을 갖는다.
- Consumer의 [ConsumerCoordinator](Kafka.md#consumer)가 보낸 OffsetCommitRequest에 대해 offset을 저장한다.
  - __consumer_offsets key: topic name & consumer group name: consumer id(ex. sample-topic&consumer-group-01: consumer-1)
  - __consumer_offsets value: 마지막 커밋된 offset 정보

## Option
replica.lag.time.max.ms
- Follower Partition들은 Leader Partition의 정보를 지정된 시간내에 Leader의 메시지를 가져가도록 한다.

min.insync.replicas
- Topic, Broker의 설정 값으로 Producer가 acks=all로 성공적으로 메시지를 보낼 수 있는 최소한의 ISR Broker 갯수를 의미한다.
- 즉, Broker가 5개 있는데, 3개만 Follower Partition에 복제가 되었다.. 이때 min.insync.replicas가 3이면 성공이라 본다.

auto.leader.rebalance.enable
leader.imbalance.check.interval.seconds
- Preferred Leader Election 수행 여부 및 수행주기

unclean.leader.election.enable
- Unclean Leader Election 수행 여부


## Command
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

# Producer
## 파티션 할당 전략(Partition Assignment Strategy)
- Key값을 가지지 않는 Message 전송의 파티션 분배 전략
  - Round Robin
    - Kafka 2.4 버전 이전 기본 파티션 분배 전략
    - Producer는 데이터를 보내기 전, Batch(=Buffer)에 데이터를 저장하는데, 데이터를 빨리 채우지 못하면 전송이 늦어지거나 배치를 다 채우지 못하고 전송 하면서 성능이 떨어질 수 있다.
  - Sticky(끈끈한)
    - Kafka 2.4 버전 이후 기본 파티션 분배 전략
    - 같은 파티션에 메시지를 묶어서 보내는 방식을 말하며, Record Accumulator의 Batch 가 이에 해당된다.

## Send(with acks)
Producer는 Topic의 Leader Broker에게만 메시지를 보낸다.

- acks
  - acks 0
    - Producer는 Broker로 부터 수신 확인을 받지 않고, 다음 Message를 전송한다.
    - 단, Send의 누락여부를 알 수 없다.
  - acks 1
    - Producer는 Broker로 부터 수신 확인을 받으나, Broker가 Leader Broker에서 Follower Broker에게 복제하지 않은 상태로 응답을 받고 다음 Message를 전송한다.
  - acks all(또는 acks -1)
    - Producer는 Broker로 부터 수신, 복제 확인을 받는고 다음 Message를 전송한다.

## Command
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

## Java Producer Client API
KafkaProducer의 구현(Sync, Async)
```java
public class SimpleProducer {
  public static void main(String[] args) {
    // Server 정보
    String kafkaIp = "localhost:9092";
    String topicName = "simple-topic";
      
    // Properties
    Properties props = new Properties();
    props.setProperty(ProducerConfig.BOOTSTRAP_SERVERS_CONFIG, kafkaIp);
    props.setProperty(ProducerConfig.KEY_SERIALIZER_CLASS_CONFIG, StringSerializer.class.getName());
    props.setProperty(ProducerConfig.VALUE_SERIALIZER_CLASS_COFNIG, StringSerializer.class.getName());
    
    // KafkaProducer
    KafkaProducer<String, String> kafkaProducer = new KafkaProducer<String, String>(props);
    
    // ProducerRecord
    ProducerRecord<String, String> producerRecord = new ProducerRecord(topicName, "key", "value");
    
    // KafkaProducer message send
    try {
      // Sync
      Future future = kafkaProducer.send(producerRecord);
      RecordMetaData syncRecordMetadata = future.get();

      // ASync
      Future future = kafkaProducer.send(producerRecord, new Callback(){
        @Override
        public void onCompletion(RecordMetaData recordMetaData, Exception exception){
          // TODO
        }
      });
    } catch (Exception e) {
    } finally {
      kafkaProducer.flush();
      kafkaProducer.close();
    }
  }
}
```

# Consumer
- Consumer의 구성요소
  - Fetcher
    - Linked Queue에 데이터가 있다면, 데이터를 반환하고, 없다면 ConsumerNetworkClient에게 데이터를 요청한다.
    - Fetcher는 Linked Queue에서만 데이터를 가져온다는 점을 인지해야 한다.
  - Linked Queue
  - ConsumerNetworkClient
    - Broker에게 데이터를 요청하며, Broker에 데이터가 없을 시, 데이터를 지속적으로 요청한다
    - 단, 데이터 요청 주기는 직접 설정하지만, Broker에 데이터가 들어오면 이 설정을 무시하고 데이터를 반환한다.
  - SubscriptionState: Topic을 구독하여 상태를 관리하다.
  - ConsumerCoordinator
    - Offset 등 정보를 담은 OffsetCommitRequest을 Broker의 Group Coordinator에게 요청
    ```text
    [Consumer]
    |
    | -- FindCoordinatorRequest(group.id) -->
    |
    [Kafka Broker A]
    |
    | <-- FindCoordinatorResponse(coordinator=B) --
    |
    | -- JoinGroupRequest --> [Kafka Broker B (Group Coordinator)]
    |
    | <-- JoinGroupResponse (with leader info) --
    |
    | -- SyncGroupRequest --> (by leader)
    |
    | <-- SyncGroupResponse (partition assignments)
    |
    | -- HeartbeatRequest (주기적) -->
    | -- OffsetCommitRequest (커밋 시점) -->
    ```
    - Consumer의 Manual Commit의 Sync, Async
      - Sync
        ```text
        1차 poll() -> 처리.. -> 1차 poll()의 commit -> 실패 -> 1차 poll()의 commit 재시도 -> commit 성공 -> 2차 poll()
        ```
      - Async
        ```text
        1차 poll() -> 처리.. -> 1차 poll()의 commit -> 실패 -> 2차 poll()
                                                         └-> 1차 poll()의 commit 재시도
        ```
  - Heart Beat Thread: 별도의 쓰레드로 Broker에게 Heart Beat을 보내 건재함?!을 알린다.

- 모든 Consumer들은 단 하나의 [Consumer-Group](Kafka.md#consumer-group)에 소속되어야 하며, Consumer-Group은 1개 이상의 Consumer를 가질 수 있다.

## Option
auto.offset.reset
- Consumer가 Topic에 처음 접속하여, Message를 가져올 때 offset설정이 없다. 이때 가장 먼저 들어온 offset(earliest)을 가져올지, 가장 마지막으로 들어온 offset부터 가져올지 설정하는 옵션

fetch.min.bytes
- Fetcher가 record들을 읽어들이는 최소 bytes. Broker는 fetch.min.bytes 이상의 새로운 메시지가 쌓일 때 까지 전송을 하지 않음. 기본은 1

fetch.max.wait.ms
- Fetch가 record들을 읽어들이는 최대 대기 시간.
- poll()은 데이터가 없을 때 기다리는 것이지만, 해당 옵션은 데이터가 있어도 기다린다는 뜻

max.partition.fetch.bytes
- Fetcher가 파티션별 한번에 최대로 가져올 수 있는 bytes

max.poll.records

auto.enable.commit
- Data를 읽어 온 후, Broker에 바로 commit하지 않고, 정해진 주기 마다 자동으로 Commit을 수행한다.

## Command
Record 조회
```console
[root@kafka-user ~]# kafka-console-consumer --bootstrap-server localhost:9092 --topic topic-sample --from-beginning
--------------------------------------
- Command
  - Consumer로 데이터를 읽어들인다.
- Option
  - --from-beginning
    - Consumer가 Topic에 처음 접속하여, Message를 가져올 때 offset설정이 없다. 이때 가장 먼저 들어온 offset(earliest)을 가져올지, 가장 마지막으로 들어온 offset부터 가져올지 설정하는 옵션. 이중 가장 earliest의 값을 뜻 한다.
```

Record 조회(key/value 형태)
```console
[root@kafka-user ~]# kafka-console-consumer --bootstrap-server localhost:9092 --topic topic-sample --property print.key=true --property print.value=true --from-beginning --property print.partition=true
--------------------------------------
- Command
  - Consumer로 데이터를 key/value형태로 읽어들인다.
- Option
  - --from-beginning
    - Consumer가 Topic에 처음 접속하여, Message를 가져올 때 offset설정이 없다. 이때 가장 먼저 들어온 offset(earliest)을 가져올지, 가장 마지막으로 들어온 offset부터 가져올지 설정하는 옵션. 이중 가장 earliest의 값을 뜻 한다.
  - --property print.key=true
    - console에 key를 노출유무를 기재
  - --property print.value=true
    - console에 value를 노출유무를 기재
  - --property print.partition=true
    - console에 partition정보 노출유무를 기재
```

## Java Consumer Client API
KafkaConsumer의 구현
```java
public class SimpleConsumer {
  public static void main(String[] args) {
    // Server 정보
    String kafkaIp = "localhost:9092";
    String topicName = "simple-topic";
    String groupId = "group-id-01";

    // Properties
    Properties props = new Properties();
    props.setProperty(ConsumerConfig.BOOTSTRAP_SERVERS_CONFIG, kafkaIp);
    props.setProperty(ConsumerConfig.KEY_DESERIALIZER_CLASS_CONFIG, StringSerializer.class.getName());
    props.setProperty(ConsumerConfig.VALUE_DESERIALIZER_CLASS_COFNIG, StringSerializer.class.getName());
    props.setProperty(ConsumerConfig.GROUP_ID_CONFIG, "groupId");

    // KafkaConsumer
    KakfaConsumer<String, String> kakfaConsumer = new KafkaConsumer<String, String>(props);
    kafkaConsumer.subscribe(topicName);           // 단일 topic
    kakfaConsumer.subscribe(List.of(topicName));  // 복수 topic

    // ConsumerRecords
    try {
      while (true) {
        ConsumerRecords consumerRecords = kafkaConsumer.poll(Duration.ofMillis(1000));  // poll()는 비동기 방식
        for (ConsumerRecord consumerRecord : consumerRecords) {
          // TODO
          
          /**
           * Commit Sync, Async으로 enable.auto.commit=false일 때만 사용한다. true일 때 하위 코드는 무시해도 괜찮타.
           */
          // props 설정 필요
          props.setProperty(ConsumerConfig.ENABLE_AUTO_COMMIT_CONFIG, "fase");
          
          // Sync 또는 Async
          try {
            // Sync
            kafkaConsumer.commitSync();
            
            // Async
            kafkaConsumer.commitAsync(new OffsetCommitCallback(){
              @Override
              public void onComplete(Map<TopicPartition, OffsetAndMetadata> offsets, Exception exception) {
                  if(exception != null) {
                      // TODO: error processing
                  }
              }
            });  
          } catch (CommitFailedException cfe) {
          }
        }
      }
    } catch (WakeupException we) {
      // TODO
    } finally {
      kafkaConsumer.close();
    }

    // Main-Thread 종료 시, 별도의 Thread로 KafkaConsumer의 wakeup을 호출
    Thread mainThread = Thread.currentThread();
    Runtime.getRuntime().addShutdownHook(new Thread() {
      public void run() {
        try {
          mainThread.join();  // mainThraed가 완료를 기다린다.
        } catch (Exception e) {
        }

        kafkaConsumer.wakeup();
      }
    });
  }
}
```

# Consumer Group
- Consumer Group 내 Consumer의 변화가 있을 때 마다 Rebalancing이 이루어진다.
- 보통 하나의 파티션은 하나의 Consumer로 1:1 관계를 맺는다.(다른 [Consumer-Group](Kafka.md#consumer-group)과는 신경쓰지 않는다)

## Rebalance
Partition과 Consumer간 연결을 다시한다.

- Rebalance 시점
  - Consumer Group 내 Consumer의 변경
  - Topic에 새로운 Partition이 추가될 때
  - session.timeout.ms이내에 Heartbeat이 응답이 없을 때
  - max.poll.interval.ms 이내에 poll()이 호출되지 않을 경우

- Consumer Rebalancing Protocol
  - Eager Mode
    - 모든 파티션의 할당을 취소하고 [파티션 할당 전략](Kafka.md#파티션-할당-전략partition-assignment-strategy) 전략에 따라 재할당
  - Incremental Cooperative Mode
    - 대상이 되는 Consumer들에 대해, 파티션에 따라 점진적으로 Consumer를 할당하면서 Rebalance를 수행

## 파티션 할당 전략(Partition Assignment Strategy)
하나의 Consumer Group 내, 여러 Consumer들에게 Topic Partition을 어떻게 나눠줄지 결정하는 방식
Consumer Group의 Rebalance 시점에서 중요한 역활을 한다.

- Strategy
  - (Eager)RangeAssignor: 각 Consumer는 연속적인 범위의 Partition을 받음
    ```text
    # Topic: 1개, Partition: 6, Consumer: 2
    Consumer 1: Partition 0,1,2
    Consumer 2: Partition 3,4,5
    ```
  
  - (Eager)RoundRobinAssignor: 모든 Partition을 순환하면서 Consumer에게 균등하게 분배
    ```text
    # Topic: 1개, Partition: 6, Consumer: 2
    Consumer 1: Partition 0,2,4
    Consumer 2: Partition 1,3,5
    ```
    
  - (Eager)StickyAssignor(Kafka 2.4+)
    - 기본적으로는 RoundRobin 방식을 사용한다
    - 기존 할당을 참고하지만, 파티션을 전부 반납하고 새로 할당
    - 단, 문제가 없는 Consumer는 기존의 연결 정보를 기억하여 최대한 동일하게 하되, Rebalance에 대상이 되는 Consumer들에 대해, 파티션에 따라 점진적으로 Consumer를 할당하면서 Rebalance를 수행.
    - **Rebalace Protocol의 Incremental Cooperative는 Partition을 아예 끊지 않고, 점진적으로 수행되는 반면, 파티션 할당전랴게서 말하는 Sticky는 일단 모든 Partition 연결을 끊고 점진적으로 재연결 한다는데 의미가 있다**
  
  > Spring for Apache Kafka3.3.6는 Default로 StickyAssignor를 사용한다.
  > 
  > CooperativeStickyAssignor는 아직 2025년 05월 기준 70~80% 수준의 이점을 제공하며, 구현복잡도 및 버그 가능성이 높다고 한다.
  > 
  >> props.setProperty(ConsumerConfig.PARTITION_ASIGNMENT_STARTEGE_CONFIG, StickyAssignor.class.getName());

  - (Incremental Cooperative)CooperativeStickyAssignor: (Kafka 2.4+)
    - 대상이 되는 Consumer들에 대해, 파티션에 따라 점진적으로 Consumer를 할당하면서 Rebalance를 수행
    - 기존 할당을 최대한 유지하면서 필요한 파티션만 재연결

## Command
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

# Consumer Static Group Membership
- Consumer Group 내의 Consumer들에게 고정된 id를 부여
- Consumer 별로 Consumer Group 최초 조인 시, 할당된 파티션을 그대로 유지하고 Consumer가 shtudown되어도, sesstion.timeout.ms내에 재 기동되면 rebalance가 수행되지 않고 기존에 파티션이 재할당 된다.

# Config
- [Server Lv] Broker와 Topic Lv Config
  - Broker Config는 base가 되는 config이며, Topic별로 설정하고 싶을 때, Topic의 config에서 override할 수 있다.
- [Clinet Lv] Producer와 Consumer Lv Config

## Command
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

# Zookeeper(사육사)
분산 시스템간의 정보를 신속하게 공유하기 위한 Coordinator System

- Zookeeper 의 역활
  - Kafka Cluster 내, 개별 Broker의 상태 정보를 관리하며, 분산 시스템에서 Controller Broker를 선출한다. 가장 먼저 들어온 Broker가 선출된다..
    - Controller Broker는 여러 Broker들 사이에서 Partition Leader를 선출하는 것이다.
  - 개별 Broker간 상태 정보의 동기화를 위한 복잡한 Lock 관리 기능을 제공
  - 간편한 디렉토리 구조 기반의 Z Node를 활용
    - Z Node는 Broker들의 중요 정보를 담는다.
    - Broker들은 Zookeeper의 Z Node를 계속 모니터링하며, Z Node에 변경 발생 시, Watch Event가 Trigger되어 변경 정보가 개별 Broker들에게 통보된다.
  - Zookeeper 자체의 Clustering 기능제공

## Option
zookeeper.session.timeout.ms
- 지정돈 시간내에 HeartBeat를 받지 못하면, 해당 Broker를 삭제하고, Controller Broker에게 이 사실을 알린다.

# Trouble Shooting
Duplicate Read
- Consumer 1이 record 1,2,3을 처리하고, DB를 저장했지만, Consumer Coordinator가 Group Coordinator에 OffsetCommitRequest 요청을 하기전에 shutdown되었을 때, Rebalance 되면서 다른 Consumer가 다시 읽어서 작업을 진행할 수 있다.
  - Application Level에서 PK Validation으로 resolve 할 수 있다.

Read Loss
- Consumer 1이 처리전에 OffsetCommitRequest을 요청하고, Exception이 발생할 때, Read Loss가 이뤄질 수 있다.
  - Application Level에서 Validation을 resolve 할 수 있다.

# Logging
## Segment
Kafka의 Log Message는 실제로는 segment에 저장이 된다.
일정 segment가 되면, 새로운 segment를 만들고 저장한다.

## Command
```console
[root@kafka-user ~]# kafka-dump-log --deep-iteration --files /home/.../sample.log --print-data-log
--------------------------------------
- Command
  - Config 값 설정
```
# Kafka Design
## Enterprise Integration Patterns
'기업 통합 패턴'이라는 번역서도 존재한다고 한다.

- Request-Reply Pattern
Kafka 기반의 비동기 메시징 환경에서 일종의 동기식 통신 흐름을 구현하려는 방식
```text
Producer -> Topic ┐
                  └-> Consumer
                    ┌
Consumer <- Topic <-┘
```

  - Kafka는 본래 양방향 통신을 지원하지 않기 때문에, Reply Topic을 별도로 구성해야 한다. 
  - Consumer는 KafkaTemplate.sendAndReceive()를 사용하여 구현할 수 있다.
  ```java
  public class KafkaConfigurer {
    @Bean
    public ReplyingKafkaTemplate<String, Request, Response> replyingKafkaTemplate(
            ProducerFactory<String, Request> pf,
            ConcurrentMessageListenerContainer<String, Response> repliesContainer) {
        return new ReplyingKafkaTemplate<>(pf, repliesContainer);
    }
    
    @Bean
    public ConcurrentMessageListenerContainer<String, Response> repliesContainer(
            ConsumerFactory<String, Response> cf) {
        ContainerProperties containerProperties = new ContainerProperties("reply-topic");
        return new ConcurrentMessageListenerContainer<>(cf, containerProperties);
    }
  }

  public class SimpleService {
    @Autowired
    private ReplyingKafkaTemplate<String, Request, Response> replyingKafkaTemplate;

    public Response sendRequest(Request request) throws Exception {
      ProducerRecord<String, Request> record = new ProducerRecord<>("request-topic", request);
      record.headers().add(KafkaHeaders.REPLY_TOPIC, "reply-topic".getBytes());

      RequestReplyFuture<String, Request, Response> future = replyingKafkaTemplate.sendAndReceive(record);
      ConsumerRecord<String, Response> response = future.get(10, TimeUnit.SECONDS); // timeout 설정 가능

      return response.value();
    }
  }
  
  public class SimpleConsumer {
    @KafkaListener(topics = "request-topic")
    @SendTo("reply-topic") // 자동으로 응답을 해당 토픽으로 전송
    public Response handleRequest(Request request) {
      // 요청 처리 로직
      return new Response("processed: " + request.getData());
    }
  }
  ```

# Reference
- https://zbvs.tistory.com/35
