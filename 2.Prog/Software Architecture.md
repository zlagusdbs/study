# Theory
- DDD(Domain Driven Design)
- Hexagonal Architecture


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

# Hexagonal Architecture
- Hexagonal Architecture
    ![Hexagonal Architecture](../resource/Prog,%20Software%20Architecture,%20Hexagonal%20Architecture.PNG)

- 내가 정의한 Pacakge
  ```
  member
    ├─ infrastructure
    │  └─ adaptor
    │      ├─ in
    │      │   ├─ web
    │      │   │   └─ member
    │      │   │       └─ MemberController
    │      │   ├─ model
    │      │   │   └─ member
    │      │   │       └─ MemberRequest
    │      │   │       └─ MemberResponse
    │      │   ├─ aop
    │      │   │   └─ ExceptionHandler
    │      │   └─ filter
    │      │       └─ OuathFilter
    │      └─ out
    │          └─ persistence
    │              ├─ member
    │              │   └─ MemberAdapter implements MemberPort
    │              │   └─ <interface>MemberRepository
    │              │   └─ MemberEntity
    │              │   └─ MemberEntityMapper  // to MemberDomain
    │              └─ benefit
    │                  └─ BenefitAdapter implements BenefitPort
    │                  └─ <interface>BenefitRepository
    │                  └─ BenefitEntity
    │                  └─ BenefitEntityMapper  // to BenefitDomain
    ├─ application
    │  ├─ port
    │  │  ├─ in    // Primary Port
    │  │  │  └─ <interface>MemberUseCase
    │  │  └─ out   // Secondary Port
    │  │     └─ <interface>MemberPort
    │  │     └─ <interface>BenefitPort
    │  └─ service
    │       └─ MemberService implements MemberUseCase	// has a Transactional(Agreegate Service)
    ├─ domain  // application 영역에서는 model으로만 대화를 합니다. 여기서 DDD를 적용할 수 있다.
    │  └─ MemberDomain
    │  └─ BenefitDomain
    └─ core
        └─ configurer
  ```
  - Issue
    - enum, exception 등은 core 에 넣는게 나을까 ? 용도에 맞게 쓰는게 나을까 ?
      - 여기서 용도란.. web 관련된 exception은 infrastructure.adaptor.in.web.exception 하위에 만들고, data를 load와 관련된 exception은 infrastructure.adaptor.out.persistence.exception 하위에 만드는.. 그런거..

- Reference  
  [dzone은 어디냐 ? 일단 얘들의 관점](https://dzone.com/articles/hello-hexagonal-architecture-1)  
  [Netfilx의 hexagonal 관점](https://netflixtechblog.com/ready-for-changes-with-hexagonal-architecture-b315ec967749)  
  [괜찮은 github](https://github.com/thombergs/buckpal.git)  
