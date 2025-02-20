# Theory
- OOP
  - SOLID
- Partitioning, Sharding
- Transaction
- Blocking vs Non-Blocking / Sync vs Async
- Cache Design Pattern

---


# OOP
## SOLID 원칙
  - SRP(Single Responsiblity Principle: 단일 책임 원칙) : 소프트웨어의 설계 부품(클래스, 메소드 등)은 하나의 책임(기능)만을 가져야 한다.
  - OPC(Open-Closed Principle: 개방-폐쇄 원칙) : 수정에는 열려있되, 기존소스는 폐쇄적(수정을 하여도 기존소스를 수정하지 않아야 한다는 뜻)이어야 한다.
  - LSP(Liskov Substitution Principle: 리스코프 치환 원칙) : 부모 클래스와 자식 클래스 사이에 일관성이 있어야 한다.(부모 클래스의 인스터스이던 자식 클래스의 인스턴스이던 아무거나 써도 문제가 없어야 함.)
      - 단, 정의하는 범위에 따라 원칙을 지킬 수도, 지키지 않을 수도 있다.
      - |           | 둘레 | 넓이 | 각 |
        |-----------|-----|------|---|
        | 삼각형    |  O   |  O   | O |
        | 사각형    |  O   |  O   | O |
        | 원        |  O   |  O   | X |
  - ISP(Interface Segregation Principle: 인터페이스 분리 원칙) : 하나의 인터페이스 보다는 용도에 맞는 여러개의 인터페이스를 설계한다.
  - DIP(Dependency Inversion Principle: 의존성 역전 원칙) : 의존성을 주입할 때는, 제어의 역전이 존재해야 한다.
      - Player class가 존재하며, file의 형태마다 play하는 용도가 다르다.
      ```
      public class Player{
          public Player(Resource resource){
              this.resource = resource;
          }
  
          private Resource resource;
  
          public play(){
              System.out.println(this.resource.toString()+"를 실행합니다.");
          }
      }
  
      public interface Resource{}
      public class MP3 implement Resource{}
      public class Movie implement Resource{}
  
      public class Main{
          public static void main(String[] args){
              Player player = null;
              player = new Player( new MP3() );	// Player의 생성자를 호출 할 때, Parameter로 MP3(Resource의 자식class인 MP3)의 인스턴스를 넣음
              player = new Player( new Movie() );	// Player의 생성자를 호출 할 때, Parameter로 Movie(Resource의 자식class인 Movie)의 인스턴스를 넣음
              player.play();
          }
      }
      ```


# Partitioning, Sharding
## Strategy
- Key Based
- Range Based
- Directory Based


# Transaction
  - Atomicity(원자성): 트랜잭션은 하나의 원자처럼 취급되어야 한다.
	                     즉 부분적으로 실행되어, 특정 부분만 반영되고 나머지는 반영되지 않으면 안된다는 뜻.
	                     예> 돈을 송금할 때, 송금하는 쪽은 성공하고 받는 쪽이 실패했다고 끝내면 안된다.
  - Consistency(일관성) : 트랜잭션이 실행을 성공적으로 완료하면 언제나 일관성 있는 Scheme 상태로 유지하는 것을 의미한다.
	                     예> 돈 100원을 송금할 때, 돈은 int형이여야 하지만 프로그램상 실수로 문자열 자료형으로 보냈을 경우, DB에 문자열 100이 저장되기 때문에 data의 일관성이 깨지기 때문에 트랜잭션이 취소되어야 한다.
  - Isolation(독립성)   : 트랜잭션을 수행 시 다른 트랜잭션의 연산 작업이 끼어들지 못하도록 독립되어 있다는 것을 보장한다.
	                       이것은 트랜잭션 밖에 있는 어떤 연산도 중간 단계의 데이터를 볼 수 없음을 의미한다.
	                     예> 법인카드의 잔여금액인 100원을 Read하여 총 3번 연산을 한다. 각 연산은 100원씩 증가를 시킨다.
	                         100 -> 200 -> 300 -> 400
	                         만약 300원째 계산을 하고 있을 때, 다른 사람이 잔여금액을 확인한다고 해도, 트랜잭션은 독립적으로 움직이기 때문에 100원으로 보인다.

    - Level
	    - 0Lv, DEFAULT
		  - 1Lv, READ_UNCOMMITED
		  - 2Lv, READ_COMMITED
		  - 3Lv, REPEATABLE_READ
		  - 4Lv, SERIALIZABLE
      
      - 참고사이트: [https://nesoy.github.io/articles/2019-05/Database-Transaction-isolation](https://nesoy.github.io/articles/2019-05/Database-Transaction-isolation)

    - Propagation
	    - REQUIRED : 부모 트랜잭션 내에서 실행하며 부모 트랜잭션이 없을 경우 새로운 트랜잭션을 생성
	    - REQUIRES_NEW : 부모 트랜잭션을 무시하고 무조건 새로운 트랜잭션이 생성
	    - SUPPORT : 부모 트랜잭션 내에서 실행하며 부모 트랜잭션이 없을 경우 nontransactionally로 실행
	    - MANDATORY : 부모 트랜잭션 내에서 실행되며 부모 트랜잭션이 없을 경우 예외가 발생
	    - NOT_SUPPORT : nontransactionally로 실행하며 부모 트랜잭션 내에서 실행될 경우 일시 정지
	    - NEVER : nontransactionally로 실행되며 부모 트랜잭션이 존재한다면 예외가 발생
	    - NESTED : 해당 메서드가 부모 트랜잭션에서 진행될 경우 별개로 커밋되거나 롤백될 수 있음. 둘러싼 트랜잭션이 없을 경우 REQUIRED와 동일하게 작동

  - Durability(지속성)  : 성공적으로 수행된 트랜잭션은 영원히 반영되어야 함을 의미하며, 시스템 문제, DB 일관성 체크 등을 하더라도 유지되어야 함을 의미한다.
				                  전형적으로 모든 트랜잭션은 로그로 남고 시스템 장애 발생 전 상태로 되돌릴 수 있다.
				                  트랜잭션은 로그에 모든 것이 저장된 후에만 commit 상태로 간주될 수 있다.


# Blocking vs Non-Blocking / Sync vs Async
  - Blocking, Non-Blocking: 제어권의 유무가 관점포인트
  - Synchronous, Asynchronnous: 결과값의 의존이 관점포인트
  
  ![blocking non-blocking / asynchronous asynchronous](../resource/Prog,%20Theory,%20blocking%20non-blocking,%20sync%20async%201.PNG)
  
    - Blocking
      - 제어권을 되돌려받는데 막힌다.
    - Non-Blocking
      - 제어권을 되돌려 받는데 자유롭다.
    - Synchronous
      - 그림으로는 기다리는 것 처럼 보이지만, client는 기다리던가 다른일을 해도 상관없다.
      - 결과값을 받으면 바로 처리하기를 원한다.
    - Asynchronous: 결과값에 의존하지 않는다.
      - 그림으로는 다른일을 하는것 처럼 보이지만, client는 기다리던가 다른일을 해도 상관없다.
      - 결과값을 받아도 언젠간 처리를 하면 된다.

![blocking non-blocking / asynchronous asynchronous](../resource/Prog,%20Theory,%20blocking%20non-blocking,%20sync%20async%202.PNG)


# Cache Design Pattern
- Cache-Aside: Cache를 분리. 읽기 요청이 많은 경우에 적합
- Read-Through: Cache를 통해서 읽기
- Write-Through: Cache를 통해서 쓰기
- Write-Around: DB에만 쓰기
- Write-Behind: Cache만 저장
- Refresh Ahead: CAche를 미리 
