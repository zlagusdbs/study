
# Spring Batch
  - Spring Batch
  - Quartz Scheduler


---

# Spring Boot
  - 참고사이트: [https://spring.io/projects/spring-batch#learn](https://spring.io/projects/spring-batch#learn)

## Spring Meta Table
  ![Spring Meta Table](https://github.com/zlagusdbs/study/blob/ac5949d9e566e97e94b6aafb703aba28348ed138/resource/Prog,%20Spring%20Batch,%20Spring%20Meta%20Table.png)

  - JobInstance(BATCH_JOB_INSTANCE)
    - Job의 실행단위(Job(약간 Configurer느낌)을 실행한 단위)
    - JobInstance에 대한 모든 정보를 포함
  - BATCH_JOB_EXECUTION_PARAMS
    - JobInstance를 구별할 수 있게하며, JobInstance에 매개변수 역활
    - Job을 실행 시킬 때 사용한 JobParameters 정보를 저장
  - JobExecution(BATCH_JOB_EXECUTION)
    - Job을 이용하여, JobInstance를 실행하도록 시도하는 객체
    - JobInstance의 라이프사이클 정보(시작시간, 종료시간, 종료코드 등)를 담고있음.
    - JobExecution에 대한 정보를 저장
    - JobInstance에 대한 단 한번의 시도를 의미하는 객체로서, Job 실행 중에 발생한 정보들을 저장하고 있는 객체
      - 시간, 상태(시작,완료,실패), 종료상태의 속성을 갖음
    - JobExecution의 실행 상태 결과가 'COMPLETED' 될 때까지 하나의 JobInstance 내에서 여러번의 시도가 생길 수 있으며, 'COMPLETED' 상태라면 재실행할 수 없다.(단, allowStartIfComplete으로 허용할 수 있음)
  - BATCH_JOB_EXECUTION_CONTEXT
  - StepExecution(BATCH_STEP_EXECUTION)
    - Batch Job을 구성하는 독립적인 하나의 단계로서 실제 배치 처리를 정의하고 컨트롤하는 데 필요한 모든 정보를 가지고 있는 도메인 객체
    - Step에 대한 한번의 시도를 의미하는 객체로서 Step 실행 중에 발생한 정보들을 저장하고 있는 객체
    - Step이 매번 시도될 때마다 생성되며 각 Step 별로 생성(재실행시, 실패한 Step만 실행)
    - Step이 이용하는 기본 구현체
      - TaskletStep
        - 가장 기본이 되는 클래스로서 Tasklet 타입의 구현체들을 제어
      - PartitionStep
        - Multi-Thread 방식으로 하나의 Step을 여러 개로 분리해서 실행한다.
      - JobStep
        - Step 내에서 Job을 실행하도록 한다.
      - FlowStep
        - Step 내에서 Flow를 실행하도록 한다.
        - Flow는 여러 Step을 여러 개로 분리해서(병렬처리) 실행한다.
  - BATCH_STEP_EXECUTION_CONTEXT
    - 

## Step
![Spring Batch, Step, Architecture](https://github.com/zlagusdbs/study/blob/2bc44afebdd3cf36efdf7a1866f4713751bbaa3a/resource/Prog,%20Spring%20Batch,%20architecture.PNG)

### 처리방식
  - tasklet
    - task 기반처리
    ```
    public Step exampleStep(){
        return new stepBuilderFactory.get("exampleStep")
            .<I, O>chunk(10)
            .reader(itemReader())
            .writer(itemWriter())
            .falutTolerant()                              // 내결함성(skip, retry 등)
            .skip(Class<? extends Throwable> type)        // skip 할 예외타입 설정
            .skipLimit(int skipLimit)                     // skip 제한횟수 설정
            .skipPolicy(SkipPolicy skipPolicy)            // skip의 조건과 기준에 대한 정책을 설정
            .noSkip(Class<? extends Throwable> type)      // exclusive skip 할 예외타입 설정
            .retry(Class<? extends Throwable> type)       // retry 할 예외타입 설정
            .retry(limit(int retryLimit)                  // retry 제한횟수 설정
            .retryPolicy(RetryPolicy retryPolicy)         // retry의 조건과 기준에 대한 ㅓㅇ책을 설정
            .backOffPolicy(BackOffPolicy backOffPolicy)   // retry 하기 까지의 지연시간(ms) 설정
            .noRetry(Class<? extends Throwable> type)     // exclusive retry 할 예외타입 설정
            .noRollback(Class<? extends Throwable> type)  // rollback 하지 않을 예외타입 설정
            .build();
    }
    ```
    
  - chunk
    - chunk 기반처리
    - ItemReader, ItemProcessor, ItemWriter 를 이용하여 처리
    ```
    ```


## FaultTolerant
  - Spring Batch의 반복 및 오류제어
  - Skip
    - ItemReader, ItemProcessor, ItemWriter에  
  - Retry
    - ItemProcessor, ItemWriter에 적용가능

## Repeat
- Spring Batch의 반복을 제어하는 기능을 제공
- Step, Chunk의 반복을 RepeatOperation을 사용하여 처리(Default 구현체로 RepeatTemplate가 존재)
```

Job -> Step -> RepeatTemplate -iterator()-> RepeatCallback -doInIteratorion()-> tasklet <───────┐
                    ↑                                                              ↓            │
                    └-------------------------------- ExceptionHandler <-Y---- exception ?      │
                    │                                                              ↓ N          │
                    │                                                       CompletionPolicy    │
                    │                                                              ↓            │
                    └----------------------------------------------------Y---- Complete ?       │
                    │                                                              ↓ N          │
                    │                                                        RepeatStatus       │
                    │                                                              ↓ N          │
                    └────────────────────────────────────────────────────Y─── FINISHED ? ───N───┘


               
            -> ChunkOrentedTasklet -> ChunkProvider -> ItemReader
                                      내부적으로 RepeatTemplate를 가지고 있으며, 이를 이용하여 반복적으로 ItemReader에서 데이터를 가져올 수 있도록 한다.
               
```

### Repeat의 종료
- RepeatStatus
  - CONTINUABLE : repeat
  - FINISHED : exit
    
- CompletionPolicy<interaffce>
  - 정상 종료를 marking
  - RepeatTemplate의 iterate method안에서 판단
  ```
  RepeatTemplate repeatTemplate = new RepeatTemplate();
  repeatTemplate.setCompletionPolicy(new XXXCompletionPolicy());
  repeatTeamplte.iterator(new RepeatCallback(){
    @Override
    public RepeatStatus doInIteration(RepeatContext repeatContext){
      System.out.println("hi !");
      return RepeatStatus.CONTINUABLE;
    }
  })
  ```
  
  - CompletionPolicy의 구현체

- ExceptionHandler
  - 비정상 종료를 marking
  - RepeatCallback안에서 예외발생 시, RepeatTemplate가 ExceptionHandler를 참조해서 예외를 다시 발생할지 결정(다시 예외발생 시, 반복종료)

## Skip
- 데이터를 처리하는 동안 Exception이 발생하였을 경우, 해당 데이터를 처리하지 않고, 다음 데이터를 처리할 수 있게하는 기능
```
public Step exampleStep(){
    return stepBuilderFactory.get("exampleStep")
            .<I, O>chunk(숫자)
            .reader(ItemReader)
            .writer(ItemWriter)
            .falutTolerant()
            .skip(예외타입)
            .skipLimit(숫자)
            .skipPolicy(SkipPolicy skipPolicy)
            .noSkip(예외타입)
            .build();
}
```

- at ItemReader : 예외가 발생한 Item은 Chunk에 담지 않는다.
- at ItemProcessor : ItemProcessor에서 예외발생 시, ItemReader부터 모든Chunk(예외가 발생한 Item 포함)를 다시 받는다.
                     단, Exception을 발생했던 Item에는 Exception이 marking되어있음으로 이때 skip이 이루어진다.
- at ItemWriter : ItemWriter에서 예외발생 시, ItemReader부터 모든Chunk(예외가 발생한 Item 포함)를 다시 받는다.
                  단, 더이상 ItemProcessor에서 Chunk단위로 받지 않고, 한 건씩 받아 처리하게 되어진다.

### SkipPolicy<interface>의 구현체
  - AlwaysSkipItemSkipPolicy : 항상 skip
  - ExceptionClassifierSkipPolicy : 예외대상을 분류하여 skip
  - CompositeSkipPolicy : 여러 SkipPolicy를 탐색하면서 skip
  - LimitCheckingItemSkipPolicy : count 및 예외대상의 결과에 따라 skip(DEFAULT)
  - NeverSkipItemSkipPolicy : None skip

## Listeners
  - Listener는 Spring Batch 실행 중, 각 실행 단계에 발생하는 event를 받아 활용할 수 있도록 제공하는 interceptor기능의 class(뭐.. Interceptor 또는 AOP라 생각하면 된다)
  
### Job
  - JobExecutionListener: Job 실행 전후
### Step
  - StepExecutionListener: Step 실행 전후
  - ChunkListener: transaction이 시작되기 전
    - Method
      - void beforeChunk(ChuckContext context)      // ItemReader의 read() Method를 호출하기 전
      - void afterChunk(ChunkContext context)       // ItemWriter의 writer() 메소드를 호출한 후(롤백 시, 호출되지 않음)
      - void afterChunkError(ChunkContext context)  // 오류 발생 및 롤백시
      ```
      public Job job(){
          return jobBuilderFactory.get("job")
                   .chunk(chunkSize)
                   .listener(ChunkListener)
                   .build();
      }
      ```
  - ItemReadListener: ItemReader 실행 전후(단, item이 null일 경우 호출되지 않음)
    - Method
      - void beforeRead()               // read() Method를 호출하기 전 매번 호출
      - void afterRead(T item)          // read() Method의 호출을 성공할 때마다 매번 호출
      - void onReadError(Exception ex)  // 읽는 도중 예외발생 시 호출
      ```
      public Job job(){
          return jobBuilderFactory.get("job")
                   .chunk(chunkSize)
                   .listener(ChunkListener)
                   .reader(ItemReader)  
                   .listener(ItemReadListener)
                   .build();
      }
      ```
  - ItemProcessListener: ItemProcessListener 실행 전후(단, item이 null일 경우 호출되지 않음)
    - Method
      - void beforeProcess(T item)                     // process() Method를 호출하기 전 매번 호출
      - void afterProcess(T item, @Nullable S result)  // process() Method의 호출을 성공할 때마다 매번 호출
      - void onProcessError(T item, Exception ex)      // 처리 도중 예외발생 시 호출
      ```
      public Job job(){
          return jobBuilderFactory.get("job")
                   .chunk(chunkSize)
                   .listener(ChunkListener)
                   .reader(ItemReader)
                   .listener(ItemReadListener)
                   .processor(ItemProcessor)
                   .listener(ItemProcessListener)
                   .build();
      }
      ```
  - ItemWriteListener: ItemWriteListener 실행 전후(단, item이 null일 경우 호출되지 않음)
    - Method
      - void beforeWrite(List<? extends S> items)                 // write() Method를 호출하기 전 매번 호출
      - void afterWrite(List<? extends S> items)                  // write() Method의 호출을 성공할 때마다 매번 호출
      - void onWriteError(Exception ex, List<? extends S> items)  // 쓰기 도중 예외발생 시 호출(단, 성공과 실패한 chunk단위가 모두 들어온다.)
      ```
      public Job job(){
          return jobBuilderFactory.get("job")
                   .chunk(chunkSize)
                   .listener(ChunkListener)
                   .reader(ItemReader)
                   .listener(ItemReadListener)
                   .processor(ItemProcessor)
                   .listener(ItemProcessListener)
                   .writer(ItemWriter)
                   .listener(ItemWriteListener)
                   .build();
      }
      ```
      ```
      # Job      
      @Configuration
      class Job {

        ...
      
        @Bean
        @JobScope
        fun step() = stepBuilderFactory.get(STEP_NAME)
          .chunk<Int, Int>(3)
          .reader(reader())
          .processor(processor())
          .writer(writer())
          .listener(CustomWriteListener())
          .build()

        @Bean
        @StepScope
        fun reader(): ListItemReader<Int> {
          return ListItemReader(listOf(0,1,2,3,4,5,6,7,8,9,10))
        }

        ...

        @Bean
        @StepScope
        fun writer(): ItemWriter<Int> {
          return ItemWriter { targets ->
            println("========== writer : $targets")
            targets.forEach{ target ->
              if(target%3==0)
                throw UnableToProcessing("test")
            }
          }
        }
      }

      # CustomWriteListener
      class CustomWriteListener {
        ...

        override fun onWriteError(exception: Exception, items: MutableList<out S>){
            println("========== onWriteError : $items")
        }
      }

      # result
      ========== writer : [0, 1, 2]
      ========== onWriteError : [0, 1, 2]  // 이후 skip이 없음으로 Job은 종료된다.
      ```
### Skip & Retry
  - SkipListener: Item처리가 skip 될 경, skip된 Item을 추적
  - Chunk(Read, Processor, Write) 한 싸이클이 돈 후에 Listener가 작동한다고 하는데... 내가 테스트 할 때는 비동기로 도는것 처럼 테스트가 되었는데.. 이것은 core좀 따봐야겠다.
    - Method
      - void onSkipRead(Throwable t)              // read 수행 중, skip이 발생할 경우 호출
      - void onSkipInProcess(I tem, Throwable t)  // process 수행 중, skip이 발생할 경우 호출
      - void onSkipInWrite(S item, Throwable t)   // write 수행 중, skip이 발생할 경우 호출
  - RetryListener: Retry 실행 전후 & 에러시점
    - Method
      - boolean open(RetryContext context, RetryCallback<T, E> callback)                       // 재시도 전 매번 호출, false를 반환할 경우 retry를 시도하지 않음
      - void close(RetryContext context, RetryCallback<T, E> callback, Throwable throwable)    // 재시도 후 매번 호출
      - void onError(RetryContext context, RetryCallback<T, E> callback, Throwable throwable)  // 재시도 실패 시, 매번 호출
