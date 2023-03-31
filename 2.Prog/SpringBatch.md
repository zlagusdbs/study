
# Spring Batch
  - Spring Batch
  - Quartz Scheduler


---

# Spring Boot
  - 참고사이트: [https://spring.io/projects/spring-batch#learn](https://spring.io/projects/spring-batch#learn)

## 용어설명
  - JobExecution
    - Job을 이용하여, JobInstance를 실행하도록 시도하는 객체
    - JobInstance의 라이프사이클 정보(시작시간, 종료시간, 종료코드 등)를 담고있음.
  - Job
    - 배치처리 과정을 하나의 단위로 묶은 객체(약간 Configurer느낌)
  - JobInstance
    - Job의 실행단위(Job(약간 Configurer느낌)을 실행한 단위)
  - JobParameter
    - JobInstance를 구별할 수 있게하며, JobInstance에 매개변수 역활
  - Step
    - ItemReader
    - ItemWriter
    - ItemProcessor
    - Tasklet
  - StepExecution
  - ExecutionContext
    - JobExecutionContext
    - StepExecutionContext
  - JobRepositroy
  - JobLauncher

## Spring Meta Table
  ![Spring Meta Table](https://github.com/zlagusdbs/study/blob/master/resource/Prog%2C%20Spring%20Batch%2C%20Spring%20Meta%20Table.png)
  
  - BATCH_JOB_INSTANCE
    - JobInstance에 대한 모든 정보를 포함
  - BATCH_JOB_EXECUTION_PARAMS
    - Job을 실행 시킬 때 사용한 JobParameters 정보를 저장
  - BATCH_JOB_EXECUTION
    - JobExecution에 대한 정보를 저장
  - BATCH_JOB_EXECUTION_CONTEXT
  - BATCH_STEP_EXECUTION
  - BATCH_STEP_EXECUTION_CONTEXT

## Step
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
  - ChunkListener: Chunk(또는 Tasklet) 실행 전후, 오류시점
  - ItemReadListener: ItemReader 실행 전후(단, item이 null일 경우 호출되지 않음)
  - ItemProcessListener: ItemProcessListener 실행 전후(단, item이 null일 경우 호출되지 않음)
  - ItemWriteListener: ItemWriteListener 실행 전후(단, item이 null일 경우 호출되지 않음)
### SkipListener
  - SkipListener: Item처리가 skip 될 경, skip된 Item을 추적
### RetryListener
  - RetryListener: Retry 실행 전후 & 에러시점
