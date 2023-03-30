
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

## Repeat
- Spring Batch의 반복을 제어하는 기능을 제공
- Step, Chunk의 반복을 RepeatOperation을 사용하여 처리(Default 구현체로 RepeatTemplate가 존재)
```

Job -> Step -> RepeatTemplate -> Tasklet -> RepeatTemplate -> Chunk
               반복                          반복
               
```

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

- at ItemReader : 예외가 발생한 Item은 Chunck에 담지 않는다.
- at ItemProcessor : ItemProcessor에서 예외발생 시, ItemReader부터 모든Chunck(예외가 발생한 Item 포함)를 다시 받는다.
                     단, Exception을 발생했던 Item에는 Exception이 marking되어있음으로 이때 skip이 이루어진다.
- at ItemWriter : ItemWriter에서 예외발생 시, ItemReader부터 모든Chunck(예외가 발생한 Item 포함)를 다시 받는다.
                  단, 더이상 ItemProcessor에서 Chunck단위로 받지 않고, 한 건씩 받아 처리하게 되어진다.

### SkipPolicy<interface>의 구현체
  - AlwaysSkipItemSkipPolicy : 항상 skip
  - ExceptionClassifierSkipPolicy : 예외대상을 분류하여 skip
  - CompositeSkipPolicy : 여러 SkipPolicy를 탐색하면서 skip
  - LimitCheckingItemSkipPolicy : count 및 예외대상의 결과에 따라 skip(DEFAULT)
  - NeverSkipItemSkipPolicy : None skip
