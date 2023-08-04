# Theory
- DDD(Domain Driven Design)
- OOP
  - SOLID
- Transaction
- Blocking vs Non-Blocking / Sync vs Async
- Cache Design Pattern

---
# DDD(Domain Driven Design)
최범균., 『도메인 주도 개발 시작하기, DDD 핵심 개념 정리부터 구현까지』, 한빛미디어(2022)

# 2. 아케틱처 개요
## 2.4 도메인 영역의 주요 구성요소
- 엔티티(Entity): 고유의 식별자를 갖는 객체로 자신의 라이프 사이클을 갖는다. 주문(Order), 회원(Member), 상품(Product)과 같이 도메인의 고유한 개념을 포현한다. 도메인 모델의 데이터를 포함하며 해당 데이터와 관련된 기능을 함께 제공한다.
- 밸류(Value): 고유의 식별자를 갖지 않는 객체로 주로 개념적으로 하나인 값을 표현할 때 사용한다. 배송지 주소를 표현하기 위한 주소(Address)나 구매 금액을 위한 금액(Money)와 같은 타입이 밸류 타입이다. 엔티티의 속성으로 사용할 뿐만 아니라 다른 밸류 타입의 속성으로도 사용할 수 있다.
- 애그리거트(Aggregate): 애그리거트는 연관된 엔티티와 밸류 객체를 개념적으로 하나로 묶은 것이다. 예를 들어 주문과 관련된 Order 엔티티, OrderLine 밸류, Ordere 밸류 객체를 '주문' 애그리거트로 묶을 수 있다.
- 리포지터리(Repository): 도메인 모델의 영속성을 처리한다. 예를 들어 DBMS 테이블에서 엔티티 객체를 로딩하거나 저장하는 기능을 제공한다.
- 도메인 서비스(Domain Service): 특정 엔티티에 속하지 않은 도메인 로직을 제공한다. '할인 금액 계산'은 상품, 쿠폰, 회원 등급, 구매 금액 등 다양한 조건을 이용해서 구현하게 되는데, 이렇게 도메인 로직이 여러 엔티티와 밸류를 필요로 하면 도메인 서비스에서 로직을 구현한다.

### 2.4.1 엔티티와 밸류
- 책 내용중 일부를 발췌한거지만, 도메인모델과 DB테이블엔티티는 같다고 생각이 되겠지만 정확히는 다르다. 필자도 처음엔 같다고 생각했다고 했다.
- 두 모델의 가장 큰 차이점은 도메인 모델의 엔티티는 데이터와 함께 도메인 기능을 함께 제공하는 점이다.
```
# 도메인 모델의 엔티티
public class Order {
    private OrderNo number;
    private Orderer orderer;
    ...

    // 기능을 제공
    public void changeShippingInfo(ShippingInfo newShippingInfo){
    }
}

# DB테이블의 엔티티
@Entity
public class Order{
    @Column(name = "order_no")
    private OrderNo number;

    @Column(name = "orderer")
    private Orderer orderer;

    ...

    // 기능을 제공하지 않음
}
```
- 다른 차이점으로는 도메인 모델의 엔티티는 두 개 이상의 데이터가 개념적으로 하나인 경우 밸류 타입을 이용해서 표현할 수 있다.(예, 위 예제의 Orderer를 밸류타입이라 하며, Orderer 밸류타입은 name과 email으로 구성되어있다.)

### 2.4.2 애그리거트(3장에서 자세히..)
- 도메인이 커질수록 개발한 도메인 모델도 커지면서 많은 엔티티와 밸류가 출현한다. 엔티티와 밸류 개수가 많아질수록 모델은 점점 더 복잡해져간다.
- 위 문제를 해결하기 위해 도메인 모델에서 전체구조를 이해하는데 도움이 되게 하는것이 바로 애그리거트이다.
- 각 도메인의 로직에 맞게 엔티티를 ROOT로 지정하여 관리를 할 수 있다.
```
public class Order{
    ...
    public void changeShippingInfo(ShippingInfo newInfo){
        // 배송지 변경 가능 여부 확인
        checkShippingInfoChangeable();
    }

    private void checkShippingInfoChangealbe(){
        // 배송지 정보를 변경할 수 있는지 여부를 확인하는 도메인 규칙 구현
    }
}
```

### 2.4.3 레파지토리
...

## 2.6 인프라스트럭처(Infrastructure) 개요
- 도메인 객체의 영속성 처리, 트랜잭션, SMTP Client, REST Client 등 다른 영역에서 필요로 하는 프레임워크, 구현 기술, 보조 기능을 지원한다.
- DIP에서 언급한 것처럼 도메인 영역과 응용 영역에서 인프라스트럭처의 기능을 직접 사용하는 것보다 이 두 영역에 정의한 인터페이스를 인프라스트럭쳐 영역에서 구현하는 것이 시스템을 더 유연하고 테스트하기 쉽게 만든다.
- 단, 무조건 인프라스트럭처에 대한 의존을 없앨 필요는 없다. 예를 들어 스프링을 사용할 경우 응용 서비스는 트랜잭션 처리를 위해 스프링이 제공하는 @Transactional을 사용하는 것이 편리하다. 또한 영속성 처리를 위해 JPA를 사용할 경우 @Entity나 @Table과 같은 JPA전용 애너테이션을 도메인 모델 클래스에 사용하는 것이 XML매핑 설정을 이용하는 것보다 편리하다.

# 3. 애그리거트
## 3.2.3 트랜잭션 범위(by 에그리거트)
- 트랜잭션 범위는 작을수록 좋다. 이것은 내 개인적인 생각과 다른점이다. 나는.. 하나의 트랜잭션에서 여러 애그리거트를 관리하면서 rollback을 대비했으나.. 책에서는 단위를 작게 하는게 좋타고 한다.. 그 이유는 .. 바로 아래ㅋㅋ
- 한 트랜잭션이 한 개 테이블을 수정하는 것과 세 개의 테이블을 수정하는 것을 비교하면 성능에서 차이가 발생한다.
- 한 개 테이블을 수정하면 트랙잭션 충돌을 막기 위해 잠그는 대상이 한 개 테이블의 한 행으로 한정되지만, 세 개의 테이블을 수정하면 잠금 대상이 더 많아진다. 잠금 대상이 많아진다는 것은 그만큼 동시에 처리할 수 있는 트랜잭션 개수가 줄어든다는 것을 의마하고 이것은 전체적인 성능을 떨어뜨린다.
- 결론!! 한 트랙잭션에서는 한 개의 애그리거트만 수정해야 한다.
- 부득이하게 두 개 이상의 애그리거트를 수정해야 한다면, 애그리거트에서 다른 애그리거트를 직접 수정하지 말고 응용 서비스에서 두 애그리거트를 수정하도록 구현한다.
- 단, 반드시 그러는게 아니라 아래 3가지 경우는 두 개 이상의 애그리거트를 변경하는 것을 고려할 수 있단다.
  - 팀 표준 : 팀이나 조직의 표준에 따라 사용자 유스케이스와 관련된 응용 서비스의 기능을 한 트랙잭션으로 실행하는 경우가 있다.
  - 기술 제약: 기술적으로 이벤트 방식을 도입할 수 없는 경우 한 트랙잭션에서 다수의 애그리거트를 수정해서 일관성을 처리해야 한다. 나는.. 기술적 이슈보단 데이터의 일관성 때문에 두개 이상을 수정하는게 나을거 같았어!!
  - UI 구현의 편리: 운영자의 편리함을 위해 주문 목록 화면에서 여러 주문의 상태를 한 번에 변경하고 싶을 것이여. 이때는 쌉가능

# 4. 리포지터리와 모델 구현
## 4.4 애그리거트 로딩 전략
- 애그리거트는 개념적으로 하나여야 한다. 애그리거트가 완전해야 이유는 두 가지 정도로 생각해 볼 수 있다. 하지만 루트 엔티티를 로딩하는 시점에 앤그리거트에 속한 객체를 모두 로딩해야 하는 것은 아님을 생각하자.
  - 상태를 변경하는 기능을 실행할 때 애그리거트 상태가 완전해야 하기 때문
  - 표현 영역에서 애그리거트의 상태 정보를 보여줄 때 필요하기 때문
    - 별도의 조회 전용 기능과 모델을 구현하는 방식을 사용하는 것이 더 유리하기 때문에 애그리거트의 완전한 로딩과 관련된 문제는 상태 변경과 더 관련이 있다.
- 위의 두번째 이유에 부가 설명으로 상태 변경 기능을 실행하기 위해 조회 시점에 즉시 로딩을 이용해서 애그리거트를 완전한 상태로 로딩할 필요는 없다. 말이 왔다갔다 한다잉 ㅋㅋㅋ

# 5. 스프링 데이터 JPA를 이용한 조회 기능

# 6. 응용 서비스와 표현 영역

# 7. 도메인 서비스


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
