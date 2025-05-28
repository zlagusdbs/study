# Theory
- Transaction
- 분산 Transaction
  - SAGA, 2PC

---

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
      - 사용자1이 값을 변경하였으나 Commit하지 않았을 경우, 사용자2는 새로이 변경된 값을 read할 수 있다.
        - 문제점
          - 사용자1의 transacation이 실패 했을 경우, 사용자2는 엉뚱한 값을 조회할 수 있다.
    - 2Lv, READ_COMMITED
      - 사용자1이 값을 변경하였으나 Commit하지 않았을 경우, 사용자2은 Undo log를 조회하여 변경 전 값을 read할 수 있다.
      - 문제점
        - 사용자2는 재조회 했을 때, 처음과 상이한 값이 조회된다.
    - 3Lv, REPEATABLE_READ(
      - [[Theory] 동시성.md](%5BTheory%5D%20%EB%8F%99%EC%8B%9C%EC%84%B1.md#동기화동시성-제어-기법))를 참고한다.
      - 문제점
        - PHANTOM READ: 다른 트랜잭션에서 수행한 변경 작업에 의해 레코드가 보였다가 안 보였다가 하는 현상
    - 4Lv, SERIALIZABLE
      - 거의 사용하지 않음..
   
  cf. 참고사이트: [https://nesoy.github.io/articles/2019-05/Database-Transaction-isolation](https://nesoy.github.io/articles/2019-05/Database-Transaction-isolation)

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

# 분산 Transaction
## 2PC(Tow-Phase Commit)
분산된 시스템 또는 데이터베이스 간에 트랜잭션의 원자성을 보장하기 위해 사용
크게 2 단계로 나눠지기 때문에 Two-Phase Commit 이라고 한다.

- 주요용어
  - Coordinator: 트랜잭션을 관리하는 역활. 일반적으로 중앙 시스템이 된다.
  - Participants: 트랜잭션에 참여하는 각 시스템.

- Phase
  - Prepare Phase(준비단계)
    - Coordinator는 Participants에 Commit할 준비가 되었는지를 묻는다.
      모든 Participants가 준비가 완료되면 Commit Phase를 실행하고, 준비가 되지 않으면 Rollback이 진행된다.
  - Commit Phase(커밋단계)

- 장점
  - 원자성을 보장한다.
  - 동기적 처리가 가능하다.

- 단점
  - 성능문제: 동기식 처리로 성능에 저하가 있을 수 있다.
  - Single Point of Failure: Coordinator가 실패하면, 트랜잭션이 중단되거나 복구할 수 없는 상태가 된다.
  - Blocking: Client가 Prepare Phase에서 문제가 생겨 응답을 받지 못할 경우, Blocing에 빠질 수 있다.  

## SAGA Pattern
- 각각의 서비스는 Tx를 처리할 때, 보상 트랙잭션의 정보도 알고 있어야 한다.

### 조율된 사가 패턴
- Aggregator 서비스를 두고, 하위 서비스들을 호출해 가면서 Tx를 진행한다.

### 중첩된 사가 패턴
- ACID 트랜잭션과 다르게 사가는 격리(isolation)가 없다.
- 그래서 중간 상태를 예상하고 다루도록 비즈니스 로직을 설계해야 한다.

- 회로차단기
  - Tx1을 진행할 때, Tx2를 진행 할 수 없도록 제한한다.

- 잠그기
  - Tx1을 진행할 때, 동일한 Tx1(double submit 등)의 요청이 올 경우, locking하여 제한한다.
  - 단, 데드락의 위험을 피할 수 없다.

- 인터럽트
  - 동작이 실행되는 것을 방해하도록 한다.
  - 예를 들어 주문 상태를 '실패'로 갱신하고, 다른 서비스에서 '실패' 상태를 확인하고 추가 진행을 못하도록 한다.
  - 단, 이것은 비즈니스 로직의 복잡도를 증가시킬 수 있다.