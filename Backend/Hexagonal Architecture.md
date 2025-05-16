# Hexagonal Architecture
- Hexagonal Architecture  
  ![Hexagonal Architecture](../Resource/Prog,%20Software%20Architecture,%20Hexagonal%20Architecture.PNG)

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
