# Java
  - JVM
    - Compile+Interpreter 란?
  - Profiler
    - Sample Profiler, Instrumented Profiler, Native Profiler
  - bin
    - jconsole, jmap, jhat, jstat, jstack, jinfo
  - Profilers
  - GC(Garbage Collection)
  - 정규표현식(Regex: Regular Expression)
  - Stream

---

# JVM
## Compile+Interpreter 란?
Java는 Compile+Interpreter의 하이브리드 방식

```text
Source Code(xxx.java)  -Compiler->  Byte Code(xxx.class)  -interpreter------------------------> 실행
                                                          └JIT Compile(c1+c2)->  Native Code  ┘
```
- Compile
Java의 Compile은 정적 컴파일(Compiler)과 동적 컴파일(JIT(Just-In-Time) Compiler)로 나눌 수 있다.

  - 정적 컴파일(ex> javac)
    고급언어를 저수준언어(기계어 또는 중간언어)로 변환하는 프로그램.
    **단, Java의 Byte Code는 JVM에서 실행 가능한 기계어일 뿐, 흔히 말하는 기계어는 아니다.**
    확장자 .java(고급언어)를 확장자 .class(기계어)로 변환한다.
  
  - 동적 컴파일(ex> JIT Compiler, 정규표현식 엔진)
    - JIT(Just-In-Time) Compiler
      Byte Code를 Run-Time 시점에 Native Code(기계어)로 변환하는 역할
      Hot-Spots(빈번히 호출되는 메소드)영역을 실행 중에 기계어 코드로 변환하여, JVM 내부에 Caching한 뒤, 이후 실행에서 다시 기계어 코드로 빠르게 실행.
      즉, 코드가 처음 실행될 때 JIT Compiler는 개입하지 않는다.
      개입이 시작되면, '메서드 인라인화', '루프 최적화', '죽은코드제거', 'JVM영역에 Caching' 등의 작업을 진행한다.
  
      - JIT Compiler는 두개의 Compiler로 다시 나뉘며, Tiered Compilation(티어드 컴파일) 방식을 사용한다.
        - C1 Compiler(Client Compiler): 빠른 시작과 짧은 실행 시간을 목표로 최적화가 이루어진다. 초기 실행 성능을 중요시한다.
        - C2 Compiler(Server Compiler): 고성능 목표로 최적화가 이루어진다.
      - 즉, 처음에는 C1 Compiler로 진행하다, 10만번 정도의 많은양의 호출이 이루어지면 C2 Compiler로 진행.

    - 정규표현식 엔진
      - 정규표현식은 [동적 컴파일](Java.md#정규표현식-엔진)에 포함

- Interpreter
  코드를 한 줄씩 읽고 실행하는 방법. Native Code로 변환하지는 않고 JVM 내부 로직에 의해 바로 처리된다.

# Profilers
## Sampling Profiler

## Instrumented Profiler(장착형 프로파일러)
- Profiling 도구인 NetBeans Profiler를 이용할 수 있다. 이는 blocking method와 thread timeline 을 분석할 수 있다.

## Native Profiler
JVM 자체를 Profiling한다.

> Profiler라는게 있다.. 정도만 알아도 될 뜻하다.

# bin
## jconsole
- 스레드 사용률 및 클래스 사용률과 GC 활동 내역을 포함해서 JVM 활동 내역을 그래픽 형태로 노출

## jmap
- java Heap dump 생성해주는 명령어로 java Heap을 확인할 때 사용.
- Options
  -histo : 클래스별 객체 수와 메모리 사용량 확인
  -dump : heap dump 생성

  ~~~
  // Format: jmap [-Options] [JVM pid]
  
  jmap -dump:format=b,file=hd_4740.bin 4740    //4740이라는 pid에 대한 Heap dump를 hd_4740.bin 라는 파일로 생성

  jmap -histo:live 24760    //24760이라는 pid에 대한 클래스별 객체 수와 메모리 사용량을 확인

  jmap -histo:live 24760 | more
  num     #instances         #bytes  class name
  ----------------------------------------------
   1:        327969       19974168  [C
   2:        112277       15139136  <constMethodKlass>
   3:        112277        9886040  <methodKlass>
   4:        330181        7924344  java.lang.String
   5:        176627        7783016  <symbolKlass>
   6:         10189        6167032  <constantPoolKlass>
   7:         97618        4685664  com.sun.tools.javac.zip.ZipFileIndexEntry
   8:         10189        4531304  <instanceKlassKlass>
   9:         46349        3980768  [Ljava.util.HashMap$Entry;
  10:          8970        3606368  <constantPoolCacheKlass>
  ~~~

## jhat
- 메모리 힙 덤프를 읽고 분석하는데 도움을 준다. 이건 후처리(PostProcessing) 유틸리티다.
  - 보통 저자는 Eclipse의 mat 도구를 이용하여 분석한다.

## jstat
- JVM 측정을 위한 성능 통계를 표시한다.
- 항목 설명
    - Timestamp : JVM의 시작 시간 이후의 시간
    - S0 : Survivor0의 사용률
    - S1 : Survivor0의 사용률
    - E : Eden 영역의 사용률
    - O : Old 영역의 사용률
    - P : Permanent 영역의 사용률
    - YGC : Young generation의 GC 이벤트 수
    - YGCT : Young generation의 가비지 컬렉션 시간
    - FGC : Full GC 이벤트 수
    - FGCT : Full의 가비지 컬렉션 시간
    - GCT : 가비지 콜렉션 시간
- Options
    - -class : 클래스로드의 동작에 대한 통계
    - -compiler : 핫스팟 컴파일러의 동작의 통계를 표시
    - -gc : 가비지 콜렉트된 힙 영역에 대한 통계
    - -gccapacity : Generation과 해당 공간의 용량 통계
    - -gcutil : 가비지 콜렉션 통계 요약
- OutputOptions
    - -h [n] : 칼럼 머리글마다 n개의 출력 행 표시
    - -t : 출력되는 첫번째 칼럼에 타임스탬프 표시 (타임스탬프는 JVM의 시작 시간 이후의 시간이다.)
  ~~~
  // Format: jstat -options -outputoptions [pid] [interval] [count]
  
  jstat -gcutil -h 5 -t 22820 10000 100
  // 22820의 pid에 10초(10000ms)간격으로 100개의 샘플을 취득해 -gcutil 옵션에 따라 출력하라(단 5개 출력 마다 머리글 표시 첫 번째 칼럼엔 타임스탬프를 표시) > jstat -gcutil -h 5 -t 22820 10000 100
  // Result
  Timestamp         S0     S1     E      O      P     YGC     YGCT    FGC    FGCT     GCT   
        1239777.3  32.23   0.00  98.88   1.54  13.76    430  100.417     0    0.000  100.417
        1239787.3  32.23   0.00  99.24   1.54  13.76    430  100.417     0    0.000  100.417
        1239797.3   0.00  36.26  19.20   1.54  13.76    431  100.490     0    0.000  100.490
        1239807.4   0.00  36.26  38.71   1.54  13.76    431  100.490     0    0.000  100.490
        1239817.4  29.82   0.00  15.43   1.54  13.76    432  100.722     0    0.000  100.722
  Timestamp         S0     S1     E      O      P     YGC     YGCT    FGC    FGCT     GCT   
        1239827.4  29.82   0.00  34.67   1.54  13.76    432  100.722     0    0.000  100.722
        1239837.4  29.82   0.00  35.03   1.54  13.76    432  100.722     0    0.000  100.722
        
  // 2행과 3행을 보면 Minor gc가 발생하여 Eden 영역이 감소하고 YGC와 YGCT가 증가함을 볼 수 있다.
  ~~~

## jstack
- java Thread dump 생성해주는 명령어로 java stack 확인할 때 사용.
- Unix/Linux 는 Java 5 부터 Windows 는 Java 6 부터 지원
- Unix/Linux 에서는 kill -3 명령어로도 Thread dump 생성 가능

  ~~~
  // Format: jstack -l [JVM pid]
  
    jstack -l 4740 > td_4740.txt    // 4740이라는 pid에 대한 Thread dump를 td_4740.txt 라는 파일로 생성하라
  ~~~

## jinfo
- JVM option(java command option)을 확인
- java command option
  - -X는 표준이 아닌 설정으로 Macro한 측면에서 JVM제어 기능을 제공 (모든 JVM에서 지원한다는 보장이 없음)
  - -XX는 표준이 아닌 설정으로 안정적이지 않은 옵션. (-X Option보다 세밀한 제어 기능을 제공하며, 성능 튜닝/버그 Workaround를 위해서 주로 사용됨)
  - -XX:+<옵션>은 해당 옵션을 활성화 -XX:-<옵션>은 해당 옵션을 비활성화
  - -XX:<옵션>=<숫자> 시 'm','M'은 메가바이트 'k','K'는 킬로바이트 'g','G'는 기가바이트를 표현

  - UNIX/Linux/Windows JAVA 5 이상 제공.
  - Heap, PermSize 등 옵션지정 없는 프로세스에 대해 default값 확인 가능.
  - HP-UX에서는 -flag 필수, Linux에서는 -flag없이 pid만 포함하면 해당 프로세스 JVM 전체 정보 출력.
  ~~~
  jinfo -flag [JVMflag] [pid]    // 5555라는 pid의 PermSize를 출력하라 > $JAVA_HOME/bin/jinfo -flag PermSize 5555
  // jinfo -flag PermSize{또는-XX:PermSize=134217728} 5555
  ~~~

# GC(Garbage Collection)
JVM(Java Virtual Machine)이 관리하는 메모리 중, Heap 영역(동적할당영역)에서 더 이상 사용되지 않는 객체를 자동으로 감지하고 메모리에서 제거하는 프로세스

## GC의 구조
GC는 Young Generation에서 Old Generation으로 승격시키고, Old Generation의 객체를 수고하는 방식으로 동작.
```text
|                         Young Generation                         |    Old Generation    |    Metaspace(JDK 7 이하, PermGen(Permanent Generation))    |
|  Eden Space  |  S0(Survivor Spaces 0)  |  S1(Survivor Spaces 1)  |                      |                                                           |

 <--------------------------  Minor GC  --------------------------> <----- Full GC ------>
```
- Eden Space
  객체를 참조하지 않을 경우, Eden Space에 할당
- Survivor Spacess 0, 1
  Eden Space에 유지된 객체들을 Survivor Spaecs로 이동
- Old Generation
  Survivor Spaces에서 여러번의 마이그레이션을 거쳐 Old Generation으로 이동
  단, Old Generation의 영역에 객체가 포화상태가 되면, Full GC가 일어난다.

  > cf. Stop-the-World 현상
  >> Full GC는 CPU 점유율의 우선순위가 굉장히 높기 때문에, 일시적으로 CPU를 독점하여 애플리케이션이 잠시 멈추는 현상을 일컫는다.

## GC Process(Mark-And-Sweep)
- Marking
  사용중인 객체를 찾는 과정으로, 루트 객체에서 시작하여 모든 참조 가능한 객체를 찾아 Marking한다.
- Sweeping
  Markding 되지 않은 객체들을 Garbage 대상으로 간주하고 제거한다. 이 객체들은 메모리에서 해제된다.

## GC의 종류
- Serial GC
  단일 쓰레드 방식으로 동작.
  작은 애플리케이션이나 단일코어 시스템에서 적합하다.
- Parallel GC
  멀티 쓰레드를 사용한다.
  멀티코어 시스템에서 적합하다.
- CMS(Concurrent Mark-Sweep) GC
  애플리케이션의 동작을 멈추지 않고, 동시에 Garbage Collection 대상을 수집한다.
- G1(Garbage First) GC
  다양한 컴퓨터 환경에 맞춰 조정할 수 있는 옵션이 많다.
  큰 애플리케이션에 적합하다.
- ZGC, Shenandoah GC

## Options
- -XX:+UseG1GC: G1 GC를 활성화한다(Java 8 이상버전은 G1 GC가 Default)
- -Xmx: JVM Heap의 최대 크기를 설정
- -Xms: JVM Heap의 최소 크기를 설정
- -XX:+PrintGCDateStamps: 많은 정보를 포함하는 GC 로그를 만드는 것이며, 권장사항이다.
- -Xloggc:filename: 플래그로 위치를 변경할 수 있지만, GC 로그는 표준 형식으로 출력된다..

# 정규표현식(Regex: Regular Expression)
문자열의 특정한 패턴을 찾고, 매칭하거나 조작하는 표현식

## 정규표현식의 Compile
정규표현식은 [동적컴파일](Java.md#compileinterpreter)으로처리 된다.
정규표현식은 Compile 시, 문자열 그대로 바이트코드 상수 풀(Constant Pool)에 저장된다.
이후 Run-Time 중, 정규표현식 엔진(Pattern **Class**)이 정규 표현식을 Constant Pool에서 조회하여 compile하고, 정규표현식을 Pattern 객체로 변환한다.
> 시점: Pattern.compile()이 실행될 때
>> Pattern.matches() 메소드 안에서 Pattern.compile()가 호출된다.

## Issue
- [동적컴파일-정규표현식의 Compile](Java.md#정규표현식의-compile)에 의하여 Run-Time 중 무분별한 Compile과 Pattern 객체의 인스턴스화가 일어난다.
- 위의 문제를 해결하고자 정규표현식은 먼저 compile한 뒤 재사용하는 것으로 사용한다.
  ```java
  import java.util.regex.Pattern;
  
  public class SimpleRegex {
    private static final String PHONE_NUMBER_REGEX = "^010(-?\\d{3,4}-?\\d{4})$";
    private static final String EMAIL_REGEX = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$";
  
    // Pattern 객체를 미리 컴파일하여 static final로 선언
    private static final Pattern PHONE_NUMBER_PATTERN = Pattern.compile(PHONE_NUMBER_REGEX);
    private static final Pattern EMAIL_PATTERN = Pattern.compile(EMAIL_REGEX);
  
    private boolean isValidPhoneNumber(String phoneNumber) {
      // 컴파일된 Pattern 객체를 재사용
      return phoneNumber != null && PHONE_NUMBER_PATTERN.matcher(phoneNumber).matches();
    }
  
    private boolean isValidEmail(String email) {
      // 이메일 검증을 위한 Pattern 객체 재사용
      return email != null && EMAIL_PATTERN.matcher(email).matches();
    }
  
    public static void main(String[] args) {
      CustomerQueryValidator validator = new CustomerQueryValidator();
  
      System.out.println(validator.isValidPhoneNumber("010-1234-5678"));  // true
      System.out.println(validator.isValidEmail("example@email.com"));    // true
    }
  }
  ```

# Stream
명령적 스타일에서 선억적 스타일로 변경된 형태로, 선억적으로 컬렉션 데이터를 처리할 수 있는 데이터 처리 API이다.

> 선언적: 무엇을 할지(즉, 루프와 if 조건문 등 제어 블록을 사용해서 어떻게 동작을 구현할지 지정할 필요 없다.)
> 명령적: 어떻게 할지

## Stream의 연산
- 생성
- 중간연산(Lazy 연산: 단말 연산(=최종연산)을 스트림 파이프라인에 실행하기 전까지는 아무 연산도 수행하지 않으며, 오직 chaining만!)
  - filter
  - distinct
  - skip
  - limit
  - map
  - flatMap
  - sorted
- 최종연산
  - anyMatch
  - noneMatch
  - allMatch
  - findAny
  - findFirst
  - forEach
  - collect
  - reduce
  - count

## Stream Class diagram
![Stream class diagram](../Resource/Backend%2C%20Java%2C%20Stream/%EC%8A%AC%EB%9D%BC%EC%9D%B4%EB%93%9C1.PNG)

![Stream class diagram 부연설명](../Resource/Backend%2C%20Java%2C%20Stream/%EC%8A%AC%EB%9D%BC%EC%9D%B4%EB%93%9C2.PNG)