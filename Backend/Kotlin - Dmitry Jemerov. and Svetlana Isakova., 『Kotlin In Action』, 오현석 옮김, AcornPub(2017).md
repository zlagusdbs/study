# Kotlin

---

# According to
Dmitry Jemerov. and Svetlana Isakova., 『Kotlin In Action』, 오현석 옮김, AcornPub(2017)

## 1장. 코틀린이란 무엇이며, 왜 필요한가?
  - Kotlin이란, Java PlatForm에서 돌아가는 새로운 프로그래밍 언어.
  - 간결하고 실용적이며, 자바 코드와의 상호운용성을 중시한다.
  - 대표적으로 서버개발, 안드로이드 앱 개발 등의 분야에서 사용할 수 있다.

### 코틀린 맛보기
  - 예제 실행 사이트: [http://try.kotl.in](http://try.kotl.in)
  ```
  data class Person(val name: String,                      // 데이터 클래스
                    val age: Int? = null)                  // 널이 될 수 있는 타입(Int?)과 파라미터 디폴트 값
  fun main(args: Array<String>){                           // 최상위 함수
      val persons = listOf(Person("영희"),
                           Person("철수", age=29))          // 이름을 붙인 파라미터
      val oldest = persons.maxBy{ it.age ?: 0 }            // 람다 식과 엘비스 연산자
      println("나이가 가장 많은사람: $oldest)                   // 문자열 템플릿
  }
  
  //결과: 나이가 가장 많은 사람: Person(name=철수, age=20)        // toString 자동 생성
  ```
  
### 코틀린의 주요 특성
  - 대상 플랫폼
    - 서버, 안드로이드 등 자바가 실행되는 모든 곳
    - iOS 디바이스: 인텔의 멀티OS 엔진을 사용하여 실행가능.
    - DeskTop 디바이스: 토네이도FX, 자바FX 등을 함께 사용하여 실행가능.
    - Front-End: 2017년03월01일 부로 자바스크립트로도 코틀린을 컴파일 가능.
  - 정적 타입 지정언어(Kotlin, Java 등)
    - 모든 프로그램 구성 요소의 타입을 컴파일 시점에 알 수 있고
    - 프로그램 안에서 객체의 필드나 메소드를 사용할 때마다 컴파일러가 타입을 검증해준다는 뜻.
    - 다만, Kotlin과 Java의 차이는 존재한데, 대부분의 경우 코틀린 컴파일러는 문맥으로부터 변수 타입을 유추하여 자동으로 타입을 정의해준다.
    ```
    var x = 1    // 코틀린은 변수를 정의하는 곳의 리터러를 통해, 변수 x를 정수형으로 초기화한다.
    ```
  - 동적 타입 지정언어(Groovy, JRuby 등)
    - 타입과 관계없이 모든 값을 변수에 넣을 수 있고
    - 필드나 메소드 접근에 대한 검증이 실행 시점에 일어나며, 그에 따라 코드가 더 짧아지고 데이터 구조를 더 유연하게 사용 가능
    - 다만, 실행시점에 오류를 알 수 있다는 단점이 존재.
  - 함수형 프로그래밍과 객체지향 프로그래밍(여기서 함수형 프로그래밍은 람다식을 포함한다)
    - 함수형 프로그래밍을 통해 소스가 간결해진다.
    - Thread Safety하다.
  - 무료 오픈소스

### 코틀린 응용
  - 코틀린 서버 프로그래밍
  - 코틀린 안드로이드 프로그래밍

### 코틀린 철학
  - 실용성
  - 간결성
  - 안전성
  - 상호운용성

### 코틀린 도구 사용
  * 난, Jetbrains Toolbox를 구매하여 사용 중 임으로 별도 글은 작성하지 않음.

## 2장. 코틀린 기초
  - 뒷절에 상세히 설명이 나오고, 이미 OOP를 공부한 사람이라면 큰 영양가?!가 없는 내용임으로 기재하지 않음
  
## 3장. 함수 정의와 호출
  - Java는 다양한 정적 메소드들을 모아두는 역할만 담당할뿐, 클래스와 인스턴스로의 의미가 전혀 없는 클래스들이 존재한다.
  - 이를 Kotlin에서는 의미 없는 클래스는 생략되도록 사용한다.
  - Java는 다양한 편의를 제공하기 위해, 많은 수의 생성자를 오버로딩하여 제공할 수 있다.
  - 이를 Kotlin에서는 디폴트값을 이용하여, 소스를 더욱 간결하게 표혀한다.
  
  ```
  // Java
  package strings
  
  public class JoinKt{
      public static String joinToString(...){...}
  
      // Java의 오버라이딩 영역
      public static String joinToString(Collection collection){...}
      public static String joinToString(Collection collection, String separator){...}
      public static String joinToString(Collection collection, String separator, String prefix){...}
      public static String joinToString(Collection collection, String separator, String prefix, String postfix){...}
  }
  
  
  // Kotlin
  // Kotlin 파일(확장자포함)을 Join.kt로 기재하였을 경우 위 코드와 완전히 동일하다.
  // 단, Kotlin 파일(확장자포함)명과 상이한 클래스 명으로 사용하고 싶을경우 "JvmName" Annotation을 package 구문 바로 앞에 사용한다.
  
  @file: JvmName("StringFunctions")
  package strings
  
  fun joinToString(...): String {...}
  
  // Kotlin에서 생성자 오버라이딩을 금지하기 위한 영역
  fun <T> joinToString(
      collection: Collection<T>,
      separator: String = ", ",
      prefix: String = "",
      postfix: String = ""
  ): String
  ```

### 3.3. 메소드를 다른 클래스에 추가: 확장 함수와 확장 프로퍼티
  - 기존 코드와 코틀린 코드를 자연스럽게 통합하는 것은 코틀린 핵심 목표 중 하나.
  - 즉, 코틀린을 기존 자바 프로젝트에 통합하는 경우 코틀린으로 직접 변환할 수 없거나 미처 변환하지 않은 기존 자바 코드를 처리할 수 있어야 함을 포함.
  - 기존 자바 API를 재작성 하지 않고 코틀린이 제공하는 편리한 기능을 사용할 수 있도록 하는 역활을 확장 함수와 확장 프로퍼티가 해결 한다.

#### 확장 함수
  - define
  ```
  fun 수신객체타입.메소드명(): 반환형 = this.메소드명()      // 여기서 this는 수신객체를 뜻한다.
  ```

  - example
  ```
  // Strings.kt
  package strings
  
  fun String.lastChar(): Char = get(length-1)
  
  
  // Any.java
  import strings.lastChar
  
  val = c = "Kotlin".lastChar()
  
  
  // Another.java
  char c = StringsKt.lastChar("Java")
  ```

#### 확장 프로퍼티
  - Backing Field가 없음으로 게터를 반드시 정의해야 한다.  
  -> 코틀린의 프로퍼티에는 그 프로퍼티 값을 저장하기 위한 필드가 있다. backing field라고 하는데, 원한다면 그 값을 그때그때 계산할 수도 있고, 커스텀 게터를 작성하면 그런 프러퍼티를 만들 수 있다.

### 3.4. 컬렉션 처리: 가변 길이 인자, 중위 함수 호출, 라이브러리 지원
  - 가변 길이 인자(vararg)
  ```
  fun 메소트명(vararg 변수명: 타입): 반환형{...}
  ```

  - 중위 호출
  ```
  // define
  infix fun Any.to(other: Any) = Pair(this, other)
  
  // use
  val map = mapOf(1 to "one", 7 to "seven", 53 to "fifty-three")
  
  
  // 아래 두 코드는 동일
  1.to("one")
  1 to "one"
  ```

  - 구조 분해 선언(Destructuring declaration)
  ```
  var (number, name) = 1 to "one"
  
  // 결과: number 의 값은 1 이며, name의 값은 one 으로 초기화 된다.
  ```

### 3.5. 문자열과 정규식 다루기

### 3.6. 코드 다듬기: 로컬 함수와 확장
  - 로컬 함수
    - 함수 안에 함수를 정의할 수 있으며, JavaScript의 closure와 같이 사용 가능하다.
    - 이를 이용하여 코드를 깔끔하게 작성할 수 있다.
    ```
    // define 1
    
    // define 2
    
    // define 3
    
    // define 4
    ```

## 4장. 클래스, 객체, 인터페이스
### 4.1.3. 가시성 변경자: 기본적으로 공개(=접근제어자)
  - public
    - 모든 곳
  - internal
    - 같은 모듈
  - protected
    - only super class
  - private
    - only same class

  ```
  internal open class TalkativeButton: Focusable{
      private fun yell() = println("Hey!")
      protected fun whisper() = println("Let's talk!")
  }
  
  
  fun TalkativeButton.giveSpeech(){        // public 멤버가 자신의 internal 수신타입인 TalkativeButton을 노출하여 에러
      yell()                               // yell에 접근할 수 없음, yell은 TalkativeButton의 private 멤버임으로
      whisper()                            // whisper에 접근할 수 없음, TalkativeButton의 protected 멤버임으로
  }
  ```


  * 모듈이란 ?
    - 한 번에 한꺼번에 컴파일되는 코틀린 파일들을 의미
    - 인텔리J나 이클립스, 메이븐, 그레이들 등 프로제트가 모듈이 될 수 있고, 하나의 프로젝트에 있더라도 앤트 테스크가 한 번 실행될 때 함께 컴파일 되는 파일의 집합만이 모듈이 될 수 있다.
    ```
    - ★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
    - 사실 이렇게만 인지할 경우 단일 프로젝트일 경우 public과 internal의 구분이 모호해지는것 같다.
    - 모듈에 개념이나 코틀린에서 public의 의미가 다르거나 뭔가 캥긴다..
    - ★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
    ```
    
## 4.4. object 키워드: 클래스 선언과 인스턴스 생성
  - object 키워드를 다양한 경우에 사용하지만, 모든 경우 클래스를 정의 하면서 동시에 인스턴스(객체)를 생성한다는 공통점이 존재.
  - 객체선언(object declaration)은 싱글턴을 저의하는 방법 중 하나.
  - 동반 객체(companion object)는 인스턴스 메소드는 아니지만 어떤 클래스와 관련 있는 메소드와 팩토리 메소드를 담을 때 사용. 동반 객체 메소드에 접근할 때는 동반 객체가 포함된 클래스의 이름을 사용할 수 있다.
  - 객체 식은 자바의 무명 내부 클래스(Anonymous inner class)대신 사용한다.

### 4.4.1. 객체선언(object declaration)
  - 자바에서 클래스의 생성자를 private로 제한하고 정적인 필드에 그 클래스의 유일한 객체를 저장하는 '싱글턴 패턴'을 통해 구현
  - 코틀린의 객체 선언 기능을 통해 싱글턴을 언어에서 기본 지원한다.
  - 객체 선언은 클래스 선언과 그 클래스에 속한 단일 인스턴스의 선언을 합친 선언이다.
  - 단, 생성자(주 생성자, 부 생성자 모두) 객체 선언에 쓸 수 없다.
  - example
  ```
  // object declaration
  object Payroll{
      val allEmployees = arrayListOf<Person>()
      
      fun calculateSalary(){
          for( person in allEmployees) {
              ...
          }
      }
  }
  
  
  // used
  Payroll.allEmployees.add(Person(...))
  Payroll.calculateSalary()
  ```
  - exmaple 2
  ```
  // object declaration
  data class Person(val name: String){
      object NameComparator: Comparator<Person>{
          override fun compare(p1: Person, p2: Person): Int = p1.name.compareTo(p2.name)
      }
  }
  
  
  // used
  val persons = listOf(Person("Bob"), Person("Alice"))
  println(persons.sortedWith(Person.NameComparator))
  
  
  // result
  [Person(name=Alice), Person(name=Bob)]
  ```

### 4.4.2. 동반객체(companion object)
  - 코틀린은 클래스 안에는 정적인 멤버가 없다.(자바의 static을 지원하지 않음)
  - 그대신 코틀린에서는 패키지 수준의 최상위 함수와 객체선언을 활용하며, 대부분의 경우 최상이 함수를 활용하는 편을 더 권장한다.
  - 다만, 최상위 함수는 private 로 표시된 클래스 비공개 멤버에 접근할 수 없다. 그래서 클래스의 인스턴스와 관계없이 호출해야 하지만, 클래스 내부 정보에 접근해야 하는 함수가 필요할 때는 클래스에 중첩된 객체선언의 멤버변수로 정의해야한다.
  - 대표적인 예로 팩토리 메소드를 들 수 있다.
  - example
  ```
  // define
  class A{
      companion object{
          fun bar(){
              println("Companion object called")
          }
      }
  }
  
  
  // used
  A.bar()
  
  
  // result
  Companion object called
  ```

### 4.4.3. 동반객체(companion object)를 일반 객체처럼 사용
  - 동반 객체는 클래스 안에 정의된 일반 객체다.
  - 따라서 동반 객체에 이름을 붙이거나, 동반 객체가 인터페이스를 상속하거나, 동반 객체 안에 확장 함수와 프로퍼티를 정의할 수 있다.

  - 동반객체확장
    - Person 클래스의 관심사를 더 명확히 분리하고 싶다고 하자.
    - Person 클래스는 핵심 비즈니스 로직 모듈의 일부다.
    - 하지만, 그 비즈니스 모듈이 특정 데이터 타입에 의존하기를 원치않는다.
    - 특히, 역직렬화의 경우 통신모듈을 따로 두어 그쪽에 넣기를 원한다.
    - example
    ```
    // 비즈니스 모듈
    class Person(val firstName: String, val lastName: String) {
        companion object{        // 비어있는 동반객체 선언
        }
    }
    
    
    // 클라이언트/서버 통신 모듈
    fun Person.Companion.fromJSON(json: String): Person{        // 확장 함수를 선언.
        ...
    }
    
    
    // used
    val person = Person.fromJSON(json)
    ```

### 4.4.4. 객체 식: 무명 내부 클래스를 다른 방식으로 작성
  - example
  ```
  val listener = object: MouseAdapter(){
      override fun mouseClicked(e: MouseEvent){...}
      override fun mouseEntered(e: MouseEvent){...}
  }
  ```
  - 단, SAM(Single Abstract Method)일 경우, 람다를 사용하는 것이 코드 관리 차원에서 더 유용하다.

## 5장. 람다로 프로그래밍
### 5.3 지연 연산(lazy) 컬렉션 연산
  - 자바의 stream과 동일한 개념으로 코틀린에서는 sequence의 개념이 있다.
  - example
  ```
  people.asSequence()
      .map(Person::name)
      .filter{it.startsWith("A")}
      .toList()
  ```  

  -> 후에 inline을 배우겠지만... 이 글은 inline학습이 끝난 후 다시 돌아와서 기재하는 글이다.  
  -> 읽는이도 inline을 공부한 후에 다시 읽기를 추천한다.  
  -> filter와 map을 동시에 사용할 때, 시퀀스를 사용하면 중간 리스트로 인한 부가 비용은 줄어든다.  
  -> 이때 각 중간 시퀀스는 람다를 필드에 저장하는 객체로 표현되며, 최종 연산은 중간 시퀀스에 있는 여러 람다를 연쇄 호출한다.  
  -> (본래는 filter나 map은 inline함수라 인라이닝된다.)   
  -> 따라서 지연 계산을 통해 성능을 향상시키려는 이유로 모든 컬렉션 연산에 asSequence를 붙여서는 안 된다.  
  -> 시퀀스 연산에서는 람다가 인라이닝되지 않기 때문에 크기가 작은 컬렉션은 오히려 일반 컬렉션 연산이 더 성능이 나을 수 있다.  
  -> 즉, 결론은 큰 컬렉션에만 asSequence를 사용해야 한다.

### 5.3.1 시퀀스 연산 실행: 중간 연산과 최종연산
  - 자바의 람다와 동일한 개념으로 특별히 기재하지 않는다. 다른 언어를 사용해도 개념은 같을 것이라 판단된다.
  - 단, map, filter 를 혼용하여 사용할 경우 filter를 먼저 사용하여 연산횟수를 줄이는 것이 좋은 코드 습관이다.

### 5.5 수신 객체 지정 람다: with와 apply
#### with
  - 어떤 객체의 이름을 반복하지 않고도 그 객체에 대해 다양한 연산을 수행하도록 하는 것
  - 파라미터를 2개를 받으며, 첫번째는 수신객체를 보내고, 두번째는 람다를 보내기 때문에, 마지막 람다는 괄호 밖으로 빼내는 관례를 이용하여 전체 함수 호출이 언어가 제공하는 특별 구문으로 보일 수 있다.
  ```
  // define
  fun alphabet(): String{
      val result = StringBuilder()
      for( letter in 'A'..'Z'){
          result.append(letter)
      }
      result.append("\nNow I know the aplhabet!")
      return result.toString()
  }
  
  
  // used
  println(alphabet())
  
  
  // result
  ABCDEFGHIJKLMNOPQRSTUVWXYZ
  Now I know the alphabet!
  ```
  
  ```
  // refacotring
  fun alphabet(): String{
      val stringBuilder = StringBuilder()
      
      return with(stringBuilder){                     // 메소드를 호출하려는 수신 객체를 지정한다.
          for(letter in 'A'..'Z'){
              this.append(letter)                     // this를 명시해서 앞에서 지정한 수신객체의 메소드를 호출한다.
          }
          append("\nNow I know the alhpabet!")        // this 를 생략하고 메소드를 호출 할 수도 있다.
          this.toString()
      }
  }
  ```

  ```
  // refacotring, with와 식을 본문으로 하는 함수를 활용
  fun alphabet() = with(StringBuilder()){
      for( letter in 'A'..'Z' ){
          append(letter)
      }
      append("\nNow I know the alphabet!")
      toStrig()
  }
  ```

#### apply
  - with와 거의 비슷하다.
  - 유일한 차이점이란 항상 자신에게 전달된 객체)즉, 수신 객체)를 반환한다는 것 뿐이다.
  - apply를 이용한 refactoring
  ```
  fun alphabet() = StringBuilder().apply{
      for( letter in 'A'..'Z' ){
          append(letter)
      }
      append("\nNow I know the alphabet!")
  }.toString()
  ```

#### DSL(Domain Specific Language)[영역 특화 언어]
  - with, apply의 예제를 DSL언어인 buildString을 사용하여 간소화 할 수 있다.
  - 이는 차후 설명할 예정이다.

## 7장. 연산자 오버로딩과 기타 관례
### 7.5. 프로퍼티 접근자 로직 재활용: 위임 프로퍼티
#### 7.5.1. 위임 프로퍼티 소개
  - 값을 뒷받침하는 필드에 단순히 저장하는 것보다 더 복잡한 방식으로 작동하는 프로퍼티를 쉽게 구현할 수 있다.
  - 또한 그 과정에서 접근자 로직을 매번 재구현할 필요도 없다.
  - 예를 들어 프로퍼티는 위임을 사용해 자신의 값을 필드가 아니라 데이터베이스 테이블이나 브라우저 세션, 맵 등에 저장할 수 있다.
  - 이런 기반에는 위임(Delegation)이 있다. 이때 작업을 처리하는 객체를 위임객체(Delegate)라고 부른다.
  - Grammar
  - by 예약어를 이용하여 프로퍼티와 위임 객체를 연결 할 수 있다.
  ```
  // 1
  class Foo {
      private val delegate = Delegate()
      var p: Type
      set(value: Type) = delegate.setValue(..., value)
      get() = delegate.getValue(...)
  }
  
  
  // 2
  class Foo {
      var p: Type by Delegate()        // by 예약어를 이용하여 프로퍼티와 위임 객체를 연결 할 수 있다.
  }
  ```

#### 7.5.2. 위임 프로퍼티 사용: by lazy()를 사용한 프로퍼티 초기화 지연
  - 상황: Person, Email, Person의 Email을 조회하는 func. 이렇게 3개의 코드를 작성해야 할 때, 이메일을 불러오기 위해서는 Person의 email 필드를 null로 초기화 시켜놨다가 호출 시 꺼내오게 해야한다.
  - 전통적인 방법의 example
    - thread unsafety
    - unclean
  ```
  class Person(val name: String) {
      private var _emails: List<Email>? = null
      val emails: List<Email>
        get() {
            if( _emails == null ) {
                _emails = loadEmails(this)
            }
            
            return _emails!!
        }
  }
  
  >>> val p = Person("Alice")
  >>> p.emails
  Load emails for Alice
  >>> p.emails
  ```

  - 위임 프로퍼티를 통한 구현
    - thread safety
  ```
  class Person(val name: String){
      val emails by lazy { loadEmails(this) }
  }
  ```

#### 7.5.3 위임 프로퍼티 구현
#### 7.5.4 위임 프로퍼티 컴파일 규칙
  - 위임 프로퍼티가 어떤 방식으로 동작하는가 ?
  - 컴파일러는 아래 예제의 MyDelegate 클래스의 인스턴스를 감춰진 프로퍼티에 저장하며, 그 감춰진 프로퍼티를 <dlegate>라는 이름으로 사용한다.
  - 또한 컴파일러는 프로퍼티를 표현하기 위해 KProperty 타입의 객체를 사용하고, 그 객체를 <property>라고 사용한다.  
    -> 실제로 '<delegate>', '<property>'와 같이 꺽쇠를 사용하여 사용한다고 한다.
  ```
  // origin
  class C {
      var prop: Type by MyDelegate()
  }
  
  
  // convert
  class C {
      private val <delegate> = MyDelegate()
      var prop: Type
      get() = <delegate>.getValue(this, <property>)
      set(value: Type) = <delegate>.setValue(this, <property>, value)
  }
  ```
  - 이 메커니즘은 상당히 단순하지만 흥미로운 활용법이 많다.
  - 프로퍼티 값이 저장될 장소를 바꿀 수도 있고(맵, 데이터베이스 테이블, 사용자 세션의 쿠키 등) 프로퍼티를 읽거나 쓸 때 벌어질 일을 변경할 수도 있다(값 검증, 변경 통지 등)
  - 이 모두를 간결한 코드로 달성할 수 있다.

#### 7.5.5 프로퍼티 값을 맵에 저장
  - 사용빈도가 낮다고 한다. 사용할 때 다시 기재하겠다.

#### 7.5.6 프레임워크에서 위임 프로퍼티 사용
  - 사용빈도가 낮다고 한다. 사용할 때 다시 기재하겠다.

## 8장. 고차 함수: 파라미터와 반환 값으로 람다 사용
### 8.1 고차 함수 정의
  - 고차 함수란 람다나 함수 참조를 인자로 넘길 수 있거나 람다나 함수 참조를 반환하는 함수.
  - 예를 들어 'filter' 함수는 술어 함수를 인자로 받으므로 고차 함수다.

#### 8.1.1 함수타입
  - Grammer
  ```
  val func = 파라미터타입 -> 반환타입 = {몸체}
  ```
  - example
  ```
  val sum: (Int, Int) -> Int = {x, y -> x + y}
  val action: () -> Unit = {println(42)}
  
  val sum = {x: Int, y: Int -> x + y}
  val action: {println(42)}
  ```

#### 8.1.2 인자로 받은 함수 호출
  - Grammer
  ```
  fun 수신객체타입.메소드명(파라미터이름: 파라미터함수타입): 반환형
  ```
  - example
  ```
  fun String.filter(predicate: (Char) -> Boolean): String
  ```
  - example 2
  ```
  fun String.filter(predicate: (Char) -> Boolean): String{
      val sb = StringBuilder()
      for( index in 0 until length ){
          val element = get(index)
          if( predicate(element) ) sb.append(element)        # predicate 파라미터로 전달받은 함수를 호출한다.
      }
      
      return sb.toString()
  }
  
  
  >>> println("ab1c".filter{it in 'a'..'z'})                 # 람다를 predicate 파라미터로 전달한다. 
  abc
  ```

#### 8.1.3 자바에서 코틀린 함수 타입 사용
  - 필요할 때 사용한다.

#### 8.1.4 디폴트 값을 지정한 함수 타입 파라미터나 널이 될 수 있는 함수 타입 파라미터
  - 별 특별한거 없다.. 그냥 ? 하나로 된다..

#### 8.1.5 함수를 함수에서 반환
  - 함수가 함수를 인자로 받는경우가 더 많치만, 함수를 반환해야하는 경우도 있다고 하네..
  ```
  enum class Delivery { STANDARD, EXPEDITED {
  
  class Order(val itemCount: Int)
  
  fun getShippingCostCalCulator( delivery: Delivery ): (Order) -> Double {        # 함수를 반화하는 함수를 선언
      if( delivery == Delivery.EXPEDITED ) {
          return { order -> 6+2.1*order.itemCount }                               # 함수에서 람다를 반환
      }
      
      return { order -> 1.2*order.itemCount}                                      # 함수에서 람다를 반환
  }
  
  
  >>> val calculator = getShippingCostCalculator(Delivery.EXPEDITED)              # 반환받은 함수를 변수에 저장
  >>> println("Shipping costs ${calculator(Order(3))}")                           # 반환받은 함수를 호출
  Shipping costs 12.3
  ```

#### 8.1.6 람다를 활용한 중복 제거
  - 그냥.. 람다를 좀더 다양하게 쓰는 방법 정도로.. 필요할 때 다시 참고하면 될거 같다..

### 8.2 인라인 함수: 람다의 부가 비용 없애기
  - 코틀린이 보통 람다를 무명 클래스로 컴파일 하지만, 그렇다고 람다 식을 사용할 때마다 새로운 클래스가 만들어지지는 않는다.
  - 또한, 람다가 변수를 포획하면 람다가 생성되는 시점마다 새로운 무명 클래스 객체가 생긴다.
  - 이런 경우 실행 시점에 무명 클래스 생성에 따른 부가 비용이 든다.
  - 즉, 일반 함수를 사용한 구현보다 덜 효율적이라는 뜻이다.
  - 반복되는 코드를 별도의 라이브러리 함수로 빼내되 컴파일러가 자바의 일반 명령문만큼 효율적인 코드를 생성하게 함으로 문제를 해결한다.
  - 그때 사용하는 것이 바로 'inline' 변경자이다.
  - 'inline'변경자를 어떤 함수에 붙이면 컴파일러는 그 함수를 호출하는 모든 문장을 함수 본문에 해당하는 바이트코드로 바꿔치기 해준다.

#### 8.2.1 인라이닝이 작동하는 방식
  - 어떤 함수를 inline으로 선언하면 그 함수의 본문이 인라인된다.
  - 다른 말로 하면 함수를 호출하는 코드를 함수를 호출하는 바이트코드 대신에 함수 본문을 번역한 바이트 코드로 컴파일 한다는 뜻이다.
  - 즉, JavaScript의 include처럼 된다는 것과 같은 느낌임.. 이게 어떻게 가능하지..
  - example
  ```
  // synchronized inline function
  inline fun <T> synchronized(lock: Lock, action: () -> T): T{
      lock.lock()
      try{
          return action()
      }finally{
          lock.unlock()
      }
  }
  
  
  // used
  fun foo(l: Lock){
      println("Before sync")
      
      synchronized(l){
          println("Action")
      }
      
      println("After sync")
  }
  
  
  // converted
  fun __foo__(l: Lock){
      println("Before sync")
      
      l.lock()
      try{
          println("Action")
      } finally {
          l.unlock()
      }
      
      println("After sync")
  }
  ```
  - synchronized 함수의 본문뿐 아니라, synchronized에 전달된 람다의 본문도 함께 인라인된다는 점에 유의.
  - 람다의 본문에 의해 만들어지는 바이트코드는 그 람다를 호출하는 코드(synchronized) 정의의 일부분으로 간주되기 때문에 코틀린 컴파일러는 그 람다를 함수 인터페이스를 구현하는 무명 클래스로 감싸지 않음.

#### 8.2.2 인라인 함수의 한계
  - 인라이닝을 하는 방식으로 인해 람다를 사용하는 모든 함수를 인라이닝할 수는 없다.
  - 함수가 인라이닝될 때 그 함수에 인자로 전달된 람다 식의 본문은 결과 코드에 직접 들어갈 수 있다.
  - 단, 이렇게 람다가 본문에 직접 펼쳐지기 때문에 함수가 파라미터로 전달받은 람다를 본문에 사용하는 방식이 한정될 수 밖에 없다.
  - 즉, 함수 본문에서 파라미터로 받은 람다를 호출한다면 그 호출을 쉽게 람다 본문으로 바꿀 수 있지만(8.2.1처럼), 파라미터로 받은 람다를 다른 변수에 저장하고 나중에 그 변수를 사용한다면 람다를 표현하는 객체가 어딘가는 존재해야 하기 때무네 람다를 인라이닝할 수 없다.

#### 8.2.5 자원 관리를 위해 인라인된 람다 사용
  - 일반적인 패턴으로 자바 1.7의 try-with-resource와 같은 코틀린의 use 함수가 있다.
    
### 8.3 고차 함수 안에서 흐름 제어
#### non-local
  - return이 바깥쪽 함수를 반환시킬 수 있는 메커니즘
  - non-local을 사용할 수 있는 경우는 람다를 인자로 받는 함수가 인라인 함수인 경우뿐.
  - inlince함수를 include되었다고 생각하면 충분히 가능하다.
  ```
  fun lookForAlice(people: List<Person>){
      poople.forEach{
          if( it.name == "Alice" ){
              println("Found!")
              return                        # 이 부분을 유심히 봐봐.. forEach가 인라인 함수인데,
                                            # forEach문의 return이 아니라, lookForAlice함수의 리턴으로 작동하잖아 ?
                                            # 이걸 가능하게 해주는 메커니즘이 non-local이라는 것이지..
          }
      }
      println("Alice is not found")
  }
  ```

#### 8.3.2 람다로부터 반환: 레이블을 사용한 return
  - label을 사용해서 break문처럼 동작 할 수 있도록 할수 있다. 다만, 람다 안에 여러 위치에 return 식이 ㄷ르어가는 경우 사용하기 불편하다.
  - 이때는 무명 함수로 해결법을 찾을 수 있다.
  - example
  ```
  fun lookForAlice(people: List<Person>){
      people.forEach{
          if(it.name=="Alice") return@forEach        # lookForAlice 함수를 종료하는게 아닌, forEach를 종료시킨다.
      }
      println("Alice might be somewhere")            # 무조건 실행이 된다.
  }
  ```
  - example 2, 이름을 명시한경우(label)
  ```
  fun lookForAlice(people: List<Person>){
      people.forEach 레이블명@{
          if(it.name=="Alice") return@레이블명
      }
      println("Alice might be somewhere")            # 무조건 실행이 된다.
  }
  ```

#### 8.3.3 무명 함수: 기본적으로 로컬 return
  - example
  ```
  fun lookForAlice(people: List<Person>){
      people.forEach( fun(person){                                   # 람다 식 대신 무명함수를 사용한다.
                          if( person.name == "Alice" ) return        # return은 가장 가까운 함수를 가리키는데 이 위치에서 가장 가까운 함수는 무명 함수이다.
                          println("${person.name} is not Alice")
                      })
  }
  
  
  >>> lookForAlice(people)
  Bob is not Alice
  ```

## Annotation
  - @file: JvmName
  ```
  // Java
  package strings
  
  public class JoinKt{
      public static String joinToString(...){...}
  }
  
  // Kotlin
  // Kotlin 파일(확장자포함)을 Join.kt로 기재하였을 경우 위 코드와 완전히 동일하다.
  // 단, Kotlin 파일(확장자포함)명과 상이한 클래스 명으로 사용하고 싶을경우 "JvmName" Annotation을 package 구문 바로 앞에 사용한다.
  
  @file: JvmName("StringFunctions")
  package strings
  
  fun joinToString(...): String {...}
  }
  ```
  
  - @JvmOverloads
  - Java에서는 디폴트 파라미터 값이라는 개념이 없어서 Kotlin 함수를 Java에서 호출하는 경우에는 그 Kotlin 함수가 디폴트 파라미터 값을 제공하더라도 모든 인자를 명시해야 한다.
  - Java가 Kotlin 함수를 자주 호출해야 한다면 Java쪽에서 좀 더 편하게 Kotlin 함수를 호출하고 싶을 것이다.
  - 그럴 때 @JvmOverloads Annotation을 함수에 추가할 수 있다.
  - 해당 Annotation을 추가하면, Kotlin Compiler가 자동으로 맨 마지막 파라미터로부터 파라미터를 하나씩 생략한 오버로딩한 Java 메소드를 추가해준다.
  ```
  // Kotlin
  @JvmOverloads
  fun<T> joinToString (
      collection: Collection<T>,
      separator: String = ", ",
      prefix: String = "",
      postfix: String = ""
  ): String {...}

  // Java
  String joinToString(Collection<T> collection, String separator, String prefix, String postfix){...}
  String joinToString(Collection<T> collection, String separator, String prefix){...}
  String joinToString(Collection<T> collection, String separator){...}
  String joinToString(Collection<T> collection){...}
  ```
  
---


# Kotlin
  - Blog..

## 유용한 함수
  - apply
    수신객체의 프로퍼티를 수정 후 수신객체를 반환할 때

  - also
    수신객체의 프로퍼트 수정 없이 수신객체를 반환할 때

  - let
    지정된 값이 null이 아닌 경우에 코드를 실행하는 경우이며, 결과가 필요한 경우.
    단, 결과는 수신객체가 아닌 다른 객체
    ```
    val driversLicence: Licence? = getNullablePerson()?.let {
        // nullable personal객체를 nullable driversLicence 객체로 변경합니다.
        licenceService.getDriversLicence(it) 
    }
    ```
  
  - with
    지정된 값이 null이 아닌 경우에 코드를 실행하는 경우이며, 결과가 필요치 않은경우

  - run
    수신객체를 통해 다른 수신객체로 변환할 때 사용.
    지역변수의 범위를 제한할 수 있다.
    ```
    val inserted: Boolean = run {
        // person 과 personDao 의 범위를 제한 합니다.
        val person: Person = getPerson()
        val personDao: PersonDao = getPersonDao()
  
        // 수행 결과를 반환 합니다.
        personDao.insert(person)
    }
    ```
