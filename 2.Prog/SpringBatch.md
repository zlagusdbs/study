
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
  - ERD
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
