# 동시성에 대한 고촬
- 동시성
- Blocking, Non-Blocking / Synchronous, ASynchronous

---

# 동시성
여러 쓰레드가 동시에 실행될 수 있는 환경

## cf. Process VS Thread
- Process
  - 실행중인 프로그램
- Thread
  - Process를 실행하는 실행단위

![슬라이드1.PNG](../Resource/Backend%2C%20%EC%BB%B4%ED%93%A8%ED%84%B0%20%EA%B5%AC%EC%A1%B0/%EC%8A%AC%EB%9D%BC%EC%9D%B4%EB%93%9C1.PNG)

## 동기화(동시성 제어) 기법
여러 쓰레드가 공유지원에 접근할 때 발생할 수 있는 충돌을 방지하는 기법

- 비관적 Lock(Perssimistic Lock)
  - Mutex: 단일 Thread로 접근을 허용할 수 있게 한다.
    - synchronized(Java: 자동 lock/unlock)
    - ReentrantLock(Java: 수동 lock/unlock): synchronized의 문제점을 보완한 형태
        - timeout 등
    - ReentrantReadWriteLock
      읽기작업과 쓰기작업에 대해 다른 종류의 Lock을 제공.(2PL은 쓰기 내에 순차적 접근에 대한 논의)
      읽기작업은 여러 쓰레드가 동시에 실행할 수 있도록 하며, 쓰기작업은 한 번에 하나의 쓰레드만 접근하도록 제한.
    
      Write 작업이 적고, Read 작업이 많은 경우에 유리하다.
      ```java
      public class SimpleReentrantReadWriteLock {
        private final ReentrantReadWriteLock lock = new ReentrantReadWriteLock();
        private final ReentrantReadWriteLock.ReadLock readLock = lock.readLock();
        private final ReentrantReadWriteLock.WriteLock writeLock = lock.writeLock();
      
        public void save(...) {
          writeLock.lock();
          try {
            // TODO
          } finally {
            writeLock.unlock();
          }
        }
      
        // 모든 Request(여러 쓰레드)에 대해 동시에 읽을 수 있다.
        // 단, write lock이 걸려있을 때, wait 상태로 동작한다.(즉, write lock에 종속적)
        public Object find(...) {
          readLock.lock();
          try {
            // TODO: return
          } finally{
            readLock.unlock();
          }
        }
      }
      ```
  - Semaphore: 복수 Thread로 접근을 허용할 수 있게 한다.(단, 제한된 개수만큼만 접근 가능)
    - Semaphore(Java: 수동 lock/unlock)
  - SpinLock
    - loop를 시도하여 lock을 취득
    - CPU의 비용을 많이 사용하기 때문에, 짧은 임계구간에만 사용.
  - 2PL(Two-Phase Locking)
    - 트랜잭션이 데이터베이스에서 동시 실행될 때 데이터의 일관성과 **순차적 일관성(ReentrantReadWriteLock은 읽기와 쓰기에 대한 접근을 논의)**을 보장하기 위해 사용된다.
      주로 [Database](../DataStore/Database.md)의 동시성을 제어하는데 사용한다.
    - 동작방식
      - 확장단계(Growing Phase): 트랜잭션이 필요한 자원에 Lock을 요청/획득 할 수 있다.
        - S-Lock(Shared Lock 또는 Read Lock)
        - X-Lock(eXclusive Lock 또는 Write Lock)
      - 수축단계(Shrinking Phase): 트랜잭션이 커밋되거나 롤백되면, 자원에 대한 Lock을 해제한다. 단, 한번 해제하면 그 후로 더이상 자원에 Lock을 요청/획들 할 수 없다.
      ```text
      
      ```
    
    cf> [2PC](%5BTheory%5D%20Transaction.md#2pctwp-phase-commit)와는 사뭇 다른 개념이다.
- 낙관적 Lock(Optimistic Lock)
  - CAS(Compared-And-Swap)
    - Lock-Free Algorithm을 구현한 기술로 '값 비교 후 원자적 갱신'을 실현한다.
    - Java(lock-free 알고리즘 적용) 등 시스템 프로그래밍에서 주로 사용.
  - MVCC(Multi Version Concurrency Control)
    - 보통 DB서버(특히 PostgreSQL, Oracle, MySQL InnoDB 등)에서 사용되는 옵션으로 서버는 트랜잭션마다 트랜잭션 ID를 부여하여 트랜잭션 ID보다 작은 트랜잭션 번호에서 변경한 것만 읽게 한다.  
      Undo 공간에 백업해두고 실제 레코드 값을 변경한다.  
      백업된 데이터는 불필요하다고 판단하는 시점에 주기적으로 삭제한다.  
      Undo에 백업된 레코드가 많아지면 서버의 처리 성능이 떨어질 수 있다.
- Transaction(with ACID)
- Event-Driven Concurrency
  - Queue 기반
    - Redis
    - Kafka

## 동시성제어 알고리즘
- lock-free
  - lock없이 원자적 연산으로 동시성 제어하며, 반드시 하나의 쓰레드는 작업을 진행한다.
  - 단, 일부는 무한 루프를 돌 수도 있음으로 모든 쓰레드가 항상 전진한다는 보장은 없다. 
- wait-free
  - 모든 쓰레드는 유한한 시간에 반드시 작업을 종료한다.
- fine-grained locking(finer-grained locking)
  - Fine-Grained Locking은 경합을 줄이고 병렬성을 높이기 위해 전체 자원 대신 부분 자원마다 락을 건다.
    - Ex. 연결 리스트에서 각 노드마다 락을 건다.
- Striped Locking
  - ConcurrentHashMap(Java 7 이하) 내부적으로 Segment 배열 기반에 락 사용.
- Stamped Lock
  - Java 8 에서 도입된 개념으로, '낙관적 읽기 -> 실패' 시, 일반 lock획득으로 fallback
  - 단, 복잡한 API와 낙관적 락 실패 시 처리 비용이슈로 Concureent-CollectionFramework는 기존의 락 구조(CAS)를 사용한다.
  ```java
  public static void StampedLockExample(){
    StampedLock lock = new StampedLock();
    long stamp = lock.tryOptimisticRead();
    if (!lock.validate(stamp)) {
      stamp = lock.readLock();
      try {
        // 읽기 작업
      } finally {
        lock.unlockRead(stamp);
      }
    }
  }
  ```
- BLocking Queue

### cf. 임계영역
공유되는 자원, 즉 동시접근하려고 하는 자원에서 문제가 발생하지 않게 독점을 보장해줘야 하는 영역

# Blocking vs Non-Blocking / Sync vs Async
Blocking vs Non-Blocking / Sync vs Async
- Blocking, Non-Blocking: 제어권의 유무가 관점포인트
  - Blocking
      - 제어권을 되돌려받는데 막힌다.
  - Non-Blocking
      - 제어권을 되돌려 받는데 자유롭다.
- Synchronous, Asynchronnous: 결과값의 의존이 관점포인트
  - Synchronous
      - 그림2으로는 기다리는 것 처럼 보이지만, client는 기다리던가 다른일을 해도 상관없다.
      - 결과값을 받으면 바로 처리하기를 원한다.
  - Asynchronous: 결과값에 의존하지 않는다.
      - 그림2으로는 다른일을 하는것 처럼 보이지만, client는 기다리던가 다른일을 해도 상관없다.
      - 결과값을 받아도 언젠간 처리를 하면 된다.
  
![BLocking, Non-Blocking / Synchronous, Asynchronnous](../Resource/Backend%2C%20%EB%8F%99%EC%8B%9C%EC%84%B1/%EC%8A%AC%EB%9D%BC%EC%9D%B4%EB%93%9C1.PNG)

![BLocking, Non-Blocking / Synchronous, Asynchronnous](../Resource/Backend%2C%20%EB%8F%99%EC%8B%9C%EC%84%B1/%EC%8A%AC%EB%9D%BC%EC%9D%B4%EB%93%9C2.PNG)