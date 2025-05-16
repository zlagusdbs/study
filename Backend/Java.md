# Java
  - Scott Oaks., 『자바 성능 튜닝』, 최가인 옮김, O'REILLY(2014)
  - 라울-게이브리얼 우르마, 마리오 푸스코, 앨런 마이크로프트., 『JAVA 8 인 액션』, 우정은 옮김, 한빛미디어(2017)

---


# Java
## Stream
- 데이터 처리 연산을 지원하도록 소스에서 추출된 연속된 요소
- 데이터 처리 연산 : 컬렉션의 주제는 데이터이지만 스트림의 주제는 계산이다.(즉, 컬렉션은 시간과 공간의 복잡성과 관련된 요소의 접근 및 저장을 다루는데 용이하며, 스트림은 filter, sorted, map 처럼 표현 계산식에 주를 이루며 이를 일컬음)
- 소스 : 컬렉션, 배열, I/O자원 등을 제공하는 주체를 소스라 일컬음
- 연속된 요소: 컬렉션과 마찬가지로 스트림은 특정 요소 형식으로 이루어진 연속된 값 집합의 인터페이스를 제공.


## GC
### Memory
### Tuning
#### jinfo
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

#### jstat
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

#### jstack
  - java Thread dump 생성해주는 명령어로 java stack 확인할 때 사용.
  - Unix/Linux 는 Java 5 부터 Windows 는 Java 6 부터 지원
  - Unix/Linux 에서는 kill -3 명령어로도 Thread dump 생성 가능

  ~~~
  // Format: jstack -l [JVM pid]
  
    jstack -l 4740 > td_4740.txt    // 4740이라는 pid에 대한 Thread dump를 td_4740.txt 라는 파일로 생성하라
  ~~~

#### jmap
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

