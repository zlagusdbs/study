# 자바 성능 튜닝

--

# According to
Java - Scott Oaks., 최가인 옮김, 『자바 성능 튜닝』, O'REILLY(2014)

# 1. 서론
> 간략하게 이 책의 구조에 대해 설명하기 때문에 skip한다.

## Java Turning Flag
- Boolean Flag
```text
-XX: +FlagName
  └> 'XX: (+|-)표기값'의 형태이며, 값으로 예시된 "FlagName"값 앞에 "+"기호로 Enable 한다는 뜻
  
-XX: -FlagName
  └> 'XX: (+|-)표기값'의 형태이며, 값으로 예시된 "FlagName"값 앞에 "-"기호로 Unable 한다는 뜻
```

- Parameter Flag
```text
-XX:somekey=somevalue
  └> '-XX:키=값'의 형태이며, 값으로 예시된 "somevalue"는 임의의 값을 나타내는 뭔가로 표현한다.
```

# 2. 성능 테스트
## 실제 에플리케이션을 테스트하자
- 마이크로벤치마크
동기화 메서드 대비 비동기화 메소드를 호출하는데 걸리는 시간, 스레드를 한 개 생성하거나 스레드 풀을 이용할 때의 오버헤드, 산술 알고리즘 한 개 대비 대체 구현체를 실행하는데 걸리는 시간 등  매우 작은 단위의 성능을 측정하도록 설계된 테스트

  - input 값은 미리 정의할 것
    - input 값을 만드는 시간이 유동적이면 안된다. 그러므로 고정값을 사용해야 한다.
    - "정확한 입력 값을 측정해야한다."라는 문장이 있는데, 여러번 테스트를 할 때 input값의 범위도 고정해서 사용하라는 뜻이다.
      이는 int의 범위 또는 long의 범위에 따라 프로그램이 정상적으로 작동될 수도 혹은 안될 수도 있기 때문.
  
  - output 관련된 값을 사용할 것
    - "직접적인 결과를 사용할 것", "관련 없는 동작을 포함해서는 안 된다."라는 문장을 사용하라고 하는데, 결국 변수나 코드블럭 중 사용하지 않는 부분은
      compiler에 의해 제거된 상태로 compile되기 때문에 정확한 테스트가 불가능하니, 불필요한 코드는 반드시 제거하라고 하는 뜻이다.

  - 스레드 마이크로벤치마크일 경우 여러 스레드가 작은 단위의 코드를 실행시킬 때 잠재적으로 동기화 병목 현상이 발생할 확률이 크다는 점을 기억한다.
    - 이것은.. 스레드 관련된 고질적인 문제이지.. 꼭 기억하란다.

- 매크로벤치마크
애플리케이션의 구성 환경을 고려하여 진행하는 테스트

  - 모든 애플리케이션은 동일한 환경의 인증/인가를 LDAP으로 관리한다던가, 애플리케이션의 처리량은 높지만 사용하는 DB의 처리량이 낮을 경우를 고려해야 한다는 뜻. 

- 메조벤치마크
마이크로벤치마크와 매크로벤치마크 중간쯤의 테스트로, 실제 작업 일부를 수행하지만 완전한 형태를 갖추지 않은 애플리케이션인 벤치마크를 가리킬 때 사용.

## 처리율 및 배치와 응답 시간 이해하기
- 경과 시간(배치) 관리
- 처리율 측정
- 응답 시간 테스트
## 변동성 이해하기
## 빠르게 자주 테스트하기
> 일반적인 TPS(Transactions Per Second), OPS(Operations Per Second), RPS(Request Per Second) 등에 대한 내용이다.  
>> 웹 어플리케이션 진영에선 TPS와 OPS를 혼용하여 TPS로 부르기도 한다.
>>> TPS는 데이터베이스의 읽기/쓰기 작업 전체를 하나의 단위
>>> OPS는 TPS보다 더 넓게 쓰이며, 단순한 일기/쓰기 요청 같은 것도 포함

# 3. 자바 성능 도구 상자
## 자바 모니터링 도구
[Java Profiler](Java.md#profilers), [Java bin](Java.md#bin) 의 내용을 참고하도록 하자.

> Java Mission Control: Windows용 JVM의 모니터링 UI
> JFR(Java Flight Recorder): JVM의 과거성능과 동작을 진단 할 수 있도록 이력을 모니터링하는 UI

# 4. JIT(Just In Time) Compiler로 작업하기
[Java Compile+Interpreter](Java.md#compileinterpreter-란) 중 동적컴파일 부분을 참고하자.

> Turning에 대한 얘기들이 있는데, JIT을 Turning할 정도는 아닌거 같다.

# 5. Garbage Collection 입문
# 6. Garbage Collection Algorithm
[Java GC(Garbage Collection)](Java.md#gcgarbage-collection) 의 내용을 참고하도록 하자.

# 7. Heap Memory Best Practice
[Java bin](Java.md#bin) 중 jhat, jvisualvm 등의  내용을 참고하도록 하자.

## Heap Dump
- 자동 Heap Dump
  - -XX:+HeapDumpOnOutOfMemoryError: 메모리 부족 에러가 발생할 때마다 JVM이 Heap Dump를 생성한다.(default> false))
  - -XX:HeapDumpPath=<path>: Heap Dump가 생성될 위치를 명시한다.(default> java_pid<pid>.hprof)
  - -XX:+HeapDumpBeforeFullGC: Full GC가 수행되기 전에 Heap Dump를 생성한다.
  - -XX:+HeapDumpAfterFullGC: Full GC가 수행된 후에 Heap Dump를 생선한다.

## Memory 적게 사용하기
> 이 글은 조금.. 공감할 순 없는 부분도 많다.
> 오랜된 참조의 경우 명시적으로 null 값을 넣으면 조금에 성능을 향상시킬 수 있다고 하는데..
> 사실 난 코드에 깔끔하도 중요하게 생각하기 때문에 크게 공감할 수 없는 문단이였던것 같다.
>> 오래된 참조에 대한 개념이 중요하다고 하나.. 크게 게의치 않으려 한다.

# 8. Native Memory Best Practice
> 성능을 최적화 하는것은 중요한 사항이지만.. 근래(기재일은 2025년이며, 본 서적을 7~8년만에 다시 읽고 정리하는 중)에 들어서는 이런 작업이 필요한가 싶다..

# 9. Threading과 Synchronization 성능
- Thread 최소 개수 설정하기
  - 최소 개수를 설정할 때는 작업시간과 유휴시간을 고려하여야 한다.
  - 더불어 CPU의 처리량과 메모리 또한 고려해야 한다.
- Thread Pool Task 크기 설정하기
  - 실제 애플리케이션을 측정하는 것이 유일한 방법으로.. 돌려보고 결정하란다.. 이때, 내부의 Queue 사이즈 및 CPU, Memory 또한 고려해야 한다고 한다.

## Thread Pool 종류
- ThreadPoolExecutor
  - 동기식 큐, 무한 큐, 제한된 큐의 설정으로 인해 다르게 작동할 수 있는 Thread Pool 이다.
    - 동기식 큐: 큐가 실제로 저장 공간을 가지지 않음. 즉, 작업이 큐에 들어가는 즉시 다른 스레드가 그것을 처리해야 한다.
    - 무한 큐: Queue 구현이 LinkedBlockingQueue으로 크기가 무한하다. corePoolSize보다 많은 요청이 들어와도 새로운 스레드를 생성하지 않고 큐에 저장할 수 있다.
    - 제한된 큐: Queue 구현이 ArrayBlockingQueue으로 크기가 고정된 큐. 큐가 꽉 차면 작업을 큐에 저장하지 못하고 거부 정책 또는 새 스레드 생성으로 대응해야 한다.

- ForkJoinPool
  - 병렬처리에 최적화된 Executor로 ThreadPoolExecutor와는 다른 방식으로 처리
  - 작업을 작은 단위로 쪼개서(fork) 병렬로 처리한 후, 결과를 모으는(join) 데 최적화된 스레드 풀이다.
  - **Java8의 Stream의 parallelStream()도 내부적으로 ForkJoinPool을 사용한다.**
  ```java
  import java.util.concurrent.ForkJoinPool;
  import java.util.concurrent.RecursiveTask;
  
  public class SimpleForkJoinFibonacci {
      public static void main(String[] args) {
          ForkJoinPool pool = new ForkJoinPool(); // 병렬 스레드 풀 생성
          int n = 10;
  
          FibonacciTask task = new FibonacciTask(n);
          int result = pool.invoke(task);
  
          System.out.println("Fibonacci(" + n + ") = " + result);
      }
  
      // RecursiveTask: 반환값이 있는 작업
      static class FibonacciTask extends RecursiveTask<Integer> {
          private final int n;
  
          FibonacciTask(int n) {
              this.n = n;
          }
  
          @Override
          protected Integer compute() {
              // 종료 조건 (Base Case)
              if (n <= 1) return n;
  
              // 큰 작업을 두 개의 작은 작업으로 분할
              FibonacciTask f1 = new FibonacciTask(n - 1);
              FibonacciTask f2 = new FibonacciTask(n - 2);
  
              // 비동기적으로 작업 실행 (fork)
              f1.fork();
  
              // 현재 스레드로 f2 실행, f1은 백그라운드에서 처리됨
              int result2 = f2.compute();
  
              // f1 결과 기다림 (join)
              int result1 = f1.join();
  
              // 결과 병합
              return result1 + result2;
          }
      }
  }
  ```
  
## Thread Synchronization
[[Theory] 동시성](%5BTheory%5D%20%EB%8F%99%EC%8B%9C%EC%84%B1.md) 을 참고한다.

> 결국 Java 8 부터는 CAS(Compared-And-Swap)을 사용하며, 이는 낙관적 Lock의 이점을 설명한다.

# 10. Java EE 성능
> 근래는 Spring Boot를 확용하며, EJB는 사실상 사용하지 않기 때문에 Skip 

# 11. Database 성능 Best Practice
> Statement, PreparedStatement 차이점 등.. 너무 old한 설명이 즐비하다.. 그냥 JPA 쓰면 된다.

> Transaction에 대한 내용도 나오니, [[Theory] Transaction](%5BTheory%5D%20Transaction.md)를 참고한다. 

# 12. Java SE API 팁
## Lambda와 Anonymous Class
## Stream 과 Filter 성능
> 기대한 부분이지만 간단한 소개 정도이다.. 이것은 Java8에 대한 문서나 다른 서적으로 공부하는것이 더 낫겠다.