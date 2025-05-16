# JPA

---

# According to
김영한., 『자바 ORM 표준 JPA 프로그래밍』, AcornPub(2015)

# JPA 소개
## 패러다임의 불일치
### 상속
- JPA는 상속과 관련된 패러다임의 불일치 문제를 개발자 대신 해결해준다.
  - 객체 : 상속
  - 데이터베이스 : 슈퍼타입과 서브타입 관계를 이용하여 상속을 유사한 형태로 설계
```
# 객체
abstract clas Item{
  Long id;
  String name;
  int price;
}

class Album extends Item{
  String artist;
}

class Movie extends Item{
  String director;
  String actor;
}

class Book extends Item{
  String author;
  String isbn;
}
```

# JPA 시작
## 객체 매핑 시작 

## persistence.xml 설정
- JPA의 설정정보를 관리하는 설정파일.
- Persistence class를 사용하여 사용할 수 있게한다.

## 어플리케이션 개발
### 엔티티 매니저 설정(with 엔티티 매니저 팩토리)
```
persistence.xml -Persistence.createEntityManagerFactory()-> EntityManagerFactory -this.createEntityManager()-> EntityManager
```
- EntityManagerFactory
  - Thread Safety
- EntityManager
  - No Thread Safety

### 트랜잭션 관리
- EntityManager -this.getTransaction()-> EntityTransaction
```
EntityTransaction tx = em.getTransaction();
try{
  tx.begin();
  // TODO
  tx.commit();        // em.flush()가 호출된다.
}catch(Exception e){
  tx.rollback();
}
```
- QnA: Service의 트랜잭션과 EntityManager의 트랜잭션의 관계는 무언가가 있을까 ? 이게 궁금하다.

### 비즈니스 로직
- 별거 없음으로 패애쓰!

### JPQL
- SQL을 추상화한 객체지향 쿼리 언어로, JPQL에서는 데이터베이스의 정보를 전혀 알지 못한다(Table, Column 등)
- JPQL은 SQL로 변환하여 데이터베이스로 질의를 하는 역활을 한다.(JPA의 영속성 컨테스트등과 관계가 없다)
- JPQL은 SQL과 문법의 거의 유사하지만 분명한 차이가 존재한다.
  - SQL: 데이터베이스의 테이블을 대상으로 쿼리한다.
  - JPQL: 엔티티객체를 대상으로 쿼리한다. 쉽게 이야기해서 클래스와 필드를 대상으로 쿼리한다.
  ```
  # SQL
  select *  from member    -- 여기서 member는 데이터베이스의 member테이블을 의미한다.
  
  # JPQL
  select *  from member    -- 여기서 member는 application의 member entity class를 의미한다.
  ```
  
# 영속성 관리
## 엔티티 매너지 팩토리와 엔티티 매니저
```
persistence.xml -Persistence.createEntityManagerFactory()-> EntityManagerFactory -this.createEntityManager()-> EntityManager -use Connection-> DB접근
                                                         └> Connection Pool ------------------------------------> Connection ┘
```
- EntityManagerFactory
  - Thread Safety
- EntityManager
  - No Thread Safety
  
## 영속성 컨텍스트란?
- 직역: 엔티티를 영구 저장하는 환경
- 논리적 개념이다. 뭐.. spring boot의 request context, javascript의 excution context와 같은.. 뭐 좀 다르지만 비슷한 그런 느낌이다.
- 엔티티 매니저를 이용하여 생성, 접근할 수 있다.

## 엔티티의 생명주기
- 비영속: 영속성 컨텍스트와 전혀 관계가 없는 상태
- 영속: 영속성 컨텍스트에 저장된 상태
- 준영속: 영속성 컨텍스트에 저장되었다가 분리된 상태
- 삭제: 삭제된 상태
- 비영속과 준영속에 차이
  - 별거 없다. 똑같은데 비영속은 그냥 식별자 아이디(@Id가 없거나 있을 수 있고), 준영속은 영속성 컨텍스트에 존재하다가 안한거니 무조건 식별자 아이디(@Id)가 있다고 가정할 수 있는 차이 뿐.
!!!!!그림을 참조하면 이해가 쉽긴한데..패애쓰!!!!!
```
...

Member member = new Member();
member.setName("kim")             // 비영속

em.persist(member)                // 영속
em.detach(member);                // 준영속: 영속성 컨텍스트에 member가 빠진상태
// em.clear();                    // 이렇게 해도 준영속: 영속성 컨텍스트에 관리하는 모든게 없는 상태
// em.close();                    // 이렇게 해도 준영속: 아예 영속성 컨텍스트가 없는 상태

// em.merge(member);              // 준영속을 다시 영속으로 만든다.

em.remove();                      // 삭제
```

## 영속성 컨텍스트의 특징
- 영속성 컨텍스트는 엔티티를 식별자 값(@Id)으로 구분함으로, 반드시 식별자 값이 있어야 한다.
- 아직 JPA영역에 머문 상태로, 실제 DB를 call한건 아니다. 데이터베이스에 강제로 적용할 수 있는데 이걸 플러시(flush)라고 한다.
  - flush는 commit()할 때 호출이 된다.
  - 영속성 컨텍스트는 식별자 값(@Id), 엔티티(@Entity)와 더불어 스탭샷을 관리하는데, flush할 때 스냅샷과 데이터를 비교하여 다를 시 update문을 날려준다. 이걸 dirty checking이라 한다.
- 아래의 매커니즘을 가능토록 한다.
  - 1차 캐시
  - 동일성 보장
  - 트랙잭션을 지원하는 쓰기 지연
  ```
  # member1, member2, member3이 같이 저장되며, rollback시 모두 롤백된다.
  begin();
  
  save(member1);
  save(member2);
  save(member3);
  
  commit();                         // em.flush()가 호출된다.
  ```
  - 변경 감지(=dirty checking)
    - 변경감지는 영속성 컨텍스트가 관리하는 영속 상태의 엔티티에만 적용된다.
    - @DynamicInsert, @DynamicUpdate
      - Member class에 3개의 field(name, age, email)이 있다고 가정하자. 이때 email만 변경해도 쿼리는 update member  set name=?, age=?, email? where id=? 로 질의된다.
      - 변경된 column에 대해서만 insert, update가 나가도록 동적쿼리를 만들게 한다. 컬럼이 30개 이상일 때는 이게 더 빠르다고 한다.
  - 지연 로딩

## 플러시
- 영속성 컨텍스트의 변경 내용을 데이터베이스에 반영한다.
- 순서
  - em.flush() 직접호출 또는 commit() 시 자동호출 또는 JPQL 쿼리 실행 시 flush된 후 JPQL이 실행된다.
    ```
    # JPQL 실행전 flush 되는 이유
    em.persist(member1)     // 영속성 상태이지만 데이터베이스에 저장하지 않은 상태
    
    JPQL 사용!                // member1은 영속성 상태이지만 데이터베이스에는 저장되지 않았기에 없다. 하지만 JPQL은 바로 SQL로 변환하여 데이터베이스로 조회를 질의한다 했다. 이때 데이터가 없음으로 안된다.
    ```
  - 변경 감지가 동작해서 영속성 컨텍스트에 있는 모든 엔티티를 스냅샷과 비교해서 수정된 엔티티를 찾는다. 수정된 엔티티는 수정 쿼리를 만들어 쓰기 지연 SQL저장소에 등록한다.
  - 쓰기 지연 SQL 저장소의 쿼리를 데이터베이스에 전송한다.

## 준영속
- 비영속과 준영속에 차이
  - 별거 없다. 똑같은데 비영속은 그냥 식별자 아이디(@Id가 없거나 있을 수 있고), 준영속은 영속성 컨텍스트에 존재하다가 안한거니 무조건 식별자 아이디(@Id)가 있다고 가정할 수 있는 차이 뿐.

# 엔티티 매핑
// 일단 코드로 좀 보자.. 적을게 없다.. 코드로코드로!

# 프록시와 연관관계 관리
## 프록시
- 즉시로딩(Eager): Entity를 조회할 때 연관된 Entity도 함께 조회한다.
- 지연로딩(Lazy): 연관된 Entity를 실제 사용할 때 조회한다.

## 프록시
### 프록시의 기초
- JPA가 데이터베이스를 접근하지 않고, 실제 엔티티 객체도 생성하지 않도록 한다. 대신에 데이테베이스 접근을 위임한 프록시 객체를 반환하게 한다.
```
Member member = em.getReference(Member.class, "member1");         // Member Entity를 접근할 수 있는 프록시 객체를 반환한다.

###
```

### 프록시와 식별자

## 즉시로딩과 지연로딩
- 즉시로딩(Eager): Entity를 조회할 때 연관된 Entity도 함께 조회한다.
- 지연로딩(Lazy): 연관된 Entity를 실제 사용할 때 조회한다.

### 즉시로딩
- XXXToOne 연관관계에서의 Default
- JOIN을 이용하여 성능을 최적화한다.

### 지연로딩
- XXXToMany 연관관계에서의 Default

## 연속성 전이: CASCADE
- 특정 Entity를 영속 상태로 만들 때 연관된 Entity도 함께 영속 상태로 만들고 싶으면, 영속성 전이 기능을 사용한다.
- JPA는 CASCADE옵션으로 영속성 전이를 제공한다.
- 쉽게 말해서 영속성 전이를 사용하면 부모 Entity를 저장할 때 자식 Entity도 함께 저장할 수 있다.
```
# CASCADE Option
ALL       // 모두 적용
PERSIST   // 영속할 때 전이
MERGE     // 병합할 때 전이
REMOVE    // 삭제할 때 전이: 부모 Entity가 삭제되면 자식 Entity도 모두 삭제된다.
REFRESH   // refresh할 때 전이
DETACH    // 준영속할 때 전이
```

## 고아 객체: opphanRemoval
- 부모 Entity와 연관관계가 끊어진 자식 Entity를 자동으로 삭제하는 기능을 제공하는데 이것을 고아객체 제거라 한다.
- 부모 Entity의 컬렉션에서 자식 Entity의 참조만 제거하면 자식 Entity가 자동으로 삭제된다.
```
# Entity
@Entity
public class Parent{
  @Id
  @GeneratedValue
  private Long id;
  
  @OneToMany(mappedBy = "parent", orphanRemoval=true)
  private List<Child> children = new ArrayList<Child>();
  
  ...
}

# Client
Parent parent1 = em.find(Parent.class, id);
parent1.getChildren().remove(0);    // 자식 Entity의 삭제를 진행할 수 있다.

# SQL
delete  from child  where id=?      // 자식 Entity의 삭제가 진행된다.
```

# 객체지향 쿼리 언어
## 객체지향 쿼리 소개
- JPQL
- Criteria
- QueryDSL
- Native SQL
- JDBC 직접사용.(MyBatis같은 SQL 매퍼 프레임워크)
  - JDBC나 MyBatis를 JPA와 함께 사용하면 영속성 컨텍스트를 적절한 시점에 강제로 flush해야 한다. 이런 이슈를 해결하는 방법은 JPA를 위회해서 SQL을 실행하기 직전에 영속성 컨텍스트를 수동으로 flush한 뒤 데이터베이스와 영속성 컨텍스트를 동기화하고 사용하면 된다.

## JPQL(Java Persistence Query Language)
- JVM이 Java Language를 OS에 의존하지 않게 한것과 같은 맥락.
- Entity객체를 조회하는 객체지향 쿼리다. 데이터베이스에 의존적이지 않다.
- 난!!!!! QueryDSL만 사용해서.. 이번에는 패애쓰!!!!!

## Criteria
- JPQL을 편하게 작성하도록 도와주는 API, Builder Class 모음
- 난!!!!! QueryDSL만 사용해서.. 이번에는 패애쓰!!!!!

## QueryDSL
- JPQL을 편하게 작성하도록 도와주는 Builder Class모음. 비표준 오픈소스 프레임워크

## Native SQL
- JPA에서 JPQL대신 직접 SQL을 사용할 수 있다.
- 아래의 경우만 사용한다.
  - 특정 데이터베이스만 지원하는 함수, 문법, SQL Query Hint(단, QueryDSL이 주 개발 프레임워크 일 때, 함수는 뺀다.)
  - 인라인 뷰(from 절의 Sub Query), Union, Intersect를 사용하는 경우
  - Store Procedure를 사용하는 경우

## 객체지향 쿼리 심화
### 벌크연산(Bulk)
- em.executeInsert(), em.executeUpdate() 메소드를 사용한다.(단, executeInsert는 비표준이다.)

# 웹 어플리케이션과 영속성 관리
## 트랜잭션 범위의 영속성 컨텍스트
- Spring Container는 트랜잭션 범위의 영속성 컨텍스트 전략을 기본으로 사용.
- 즉, 트랜잭션을 시작할 때 영속성 컨텍스트를 생성하고 트랜잭션이 끝날 때 영속성 컨텍스트를 종료한다는 뜻.
- 만약 예외가 발생하면 트랙잭션을 롤백하고 종료하는데 이때는 flush를 호출하지 않는다.
- 같은 Entity Manager를 사용해도 트랜잭션에 따라 접근하는 영속성 컨텍스는 다르다. 즉, Thread Safety하다는 뜻이다.

## 준영속 상태와 지연로딩
- 뭐 별내용이 없네..!!!!!

## OSIV(Open Session In View)
- JPA의 영속성 영역은 Spring의 Transaction에 융합?! 된다. 보통 Spring은 Service Layer에 Transaction을 사용하는데, 문제는 View(JSP등)에서 지연로딩을 사용하는 경우다.
- Service Layer의 Transaction가 끝남에 따라 JPA의 영속성도 끝나기 때문에, 지연로딩을 사용할 수 없는 문제인데, OSIV를 활성화하면 View에서 렌더링하는 시점까지 영속성을 유지할 수 있다.
- 단, 성능이 구려서 나는 사용하지 않는다. 꼭 비활성화하고 사용하도록 하자.

## 너무 엄격한 계층

# 트랜잭션과 락, 2차 캐시
## 트랜잭션과 락
- 사전지식
  - 트랜잭션의 ACID
    - 원자성(Atomicity): 트랜잭션 내에서 실행하는 작업들은 마치 하나의 작업인 것처럼 모두 성공하든가 모두 실패해야 한다.
    - 일관성(Consistency): 모든 트랜잭션은 일관성 있는 데이터베이스 상태를 유지해야 한다. 예를 들어 데이터베이스에서 정한 무결성 제약 조건을 항상 만족해야 한다.
    - 격리성(Isolation): 동시에 실행되는 트랜잭션들이 서로에게 영향을 미치지 않도록 격리한다. 예를 들어 동시에 같은 데이터를 수정하지 못하도록 해야 한다. 격리성은 동시성과 관련된 성능 이슈로 인해 격리 수준을 선택할 수 있다.
      - READ UNCOMMITED(커밋되지 않은 읽기)
      - READ COMMITED(커밋된 읽기)
      - REPEATABLE READ(반복 가능한 읽기)
      - SERIALIZABLE(직렬화 가능)
    - 지속성(Durability): 트랜잭션을 성공적으로 끝내면 그 결과가 항상 기록되어야 한다. 중간에 시스템에 문제가 발생해도 데이터베이스 로그 등을 이용해서 성공한 트랜잭션을 복구해야 한다.
- 낙관적 락
  - 트랜잭션 대부분은 충돌이 발생하지 않는다고 낙관적으로 가정하는 방법
- 비관적 락
  - 트랜잭션의 충돌이 발생한다고 가정하고 우선 락을 걸고 보는 방법
- JPA의 락
  - 'READ COMMITTED 트랜잭션 격리 수준 + 낙관적 버전'으로 관리한다.

## 2차 캐싱
- 그냥 application에서 관리하는 cache.. ehcache같은거..
- echcache를 먼저 확인 한 뒤에 데이터가 없으면 데이터베이스로 조회한다는 뭐 그런거지..
```
# Config(XML 또는 YML)
<bean id="entityManagerFactory" class="org.springframework.orm.jpa.LocalContainerEntityManagerFactoryBean">
  <property name="sharedCacheMode" value="ENABLE_SELECTIVE"/>
  // ALL: 
  // NONE: cache를 사용하지 않음
  // ENABLE_SELECTIVE: Cacheable(true)로 설정된 Entity만 Cache사용
  // DISABLE_SELECTIVE: 모든 Entity를 cache하는데 Cacheable(false)로 명시된 Entity는 Cache하지 않음
  // UNSPECIFIED: JPA 구현체가 정의한 설정을 따른다.
</bean>

# Settings(캐시 조회, 저장 방식 설정)
em.setProperty("javax.persistence.cache.retrieveMode", CacheRetrieveMode.BYPASS);
// javax.persistence.cache.retrieveMode: 캐시 조회 모드 프로퍼티 이름
// javax.persistence.cache.storeMode: 캐시 보관 모드 프로퍼티 이름
// javax.persistence.cache.CacheRetrieveMode: 캐시 조회 모드 설정 옵션
// javax.persistence.cache.CacheStoreMode: 캐시 보관 모드 설정 옵션

// 조회모드 일 시
// CacheRetrieveMode.USE: 캐시에서 조회한다.
// CacheRetrieveMode.BYPASS: 캐시를 무시하고 데이터베이스에 직접 접근한다.

// 보관모드 일 시
// CacheRetrieveMode.USE: 조회한 데이터를 Cache에 저장한다. 조회한 데이터가 이미 Cache에 있으면 Cache데이터를 최신 상태로 갱신하지는 않는다. 트랜잭션을 커밋하면 등록 수정한 Entity도 Cache에 저장한다.
// CacheRetrieveMode.BYPASS: Cache를 무시하고 데이터베이스에 직접 저장한다.
// CacheRetrieveMode.REFRESH: USE 전략에 추가로 데이터베이스에서 조회한 Entity를 최신 상태로 다시 caching한다.

# Entity
@Cacheable
@Entity
public class Member{
  @Id
  @GeneratedValue
  private Long id;
  
  ...
}
```

---


# Annotation
@PersistenceUnit: Entity Manager Factory를 주입받는다.

@PersistenceContext: Entity Manager를 주입받는다.

@Version: Entity의 version을 관리하다(Transaction내에서 이중 저장의 문제를 커버)

---


# Relationship
  - Object-Relational Mapping (객체 관계 매핑)
    - 객체지향(Java)과 관계형(RDBMS)과의 패러다임 불일치를 해결(매핑)하는 기술로, 본 문서는 Hibernate를 기준으로 작성.
    
  - JPA의 동작과정
    - [ [ Java Application ]  <-JPA->  [ JDBC API ] ]  <->  [ Database ]
    - Application과 JDBC 사이에 위치하여, 객체지향형과 관계형에 대한 불일치 패러다임을 해소.
    
## Tech
### 복합키
  - @EmbededId
    ~~~
    ~~~
    
  - @IdClass
    - Identifying Relationship
      - 참고사이트: [https://woowabros.github.io/experience/2019/01/04/composit-key-jpa.html](https://woowabros.github.io/experience/2019/01/04/composit-key-jpa.html)
      
    - None Identifying Relationship
    ~~~
    @Entity
    @Table(name = "tb_mem_user")
    public class User extends BaseEntity {
        @Id
        @GeneratedValue(
                strategy = GenerationType.AUTO
        )
        @Column(name = "user_id", nullable = false)
        private Long userId;
    
    
        public Long getUserId() {
            return userId;
        }
    
        public User setUserId(Long userId) {
            this.userId = userId;
            return this;
        }
    }
    
    
    @Entity
    @Table(name = "tb_rom_room")
    public class Room extends BaseEntity {
        @Id
        @Column(name = "room_id", nullable = false)
        private String roomId;
    
    
        public String getRoomId() {
            return roomId;
        }
    
        public Room setRoomId(String roomId) {
            this.roomId = roomId;
            return this;
        }
    }
    
    
    public class UserRoomComposite implements Serializable {
        public UserRoomComposite(){
        }
    
        public UserRoomComposite(Long userId, String roomId){
            this.user = userId;
            this.room = roomId;
        }
    
    
          private Long user;    // UserRole Class에 정의된 User ReferenceVariable과 동일한 이름을 사용.
                                // @IdClass는 ReferenceVariable Name으로 UserRole Class에 정의된 ReferenceVariable를 Serche한다.
          private String room;  // UserRole Class에 정의된 Role ReferenceVariable과 동일한 이름을 사용.
                                // @IdClass는 ReferenceVariable Name으로 UserRole Class에 정의된 ReferenceVariable를 Serche한다.
    
    
        public Long getUser() {
            return user;
        }
    
        public UserRoomComposite setUser(Long user) {
            this.user = user;
            return this;
        }
    
        public String getRoom() {
            return room;
        }
    
        public UserRoomComposite setRoom(String room) {
            this.room = room;
            return this;
        }
    
    
        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (o == null || getClass() != o.getClass()) return false;
            UserRoomComposite userRoomComposite = (UserRoomComposite) o;
            return Objects.equals(this.user, userRoomComposite.getUser()) &&
                    Objects.equals(this.room, userRoomComposite.getRoom());
        }
    
        @Override
        public int hashCode() {
            return Objects.hash(this.user, this.room);
        }
    
    
        @Override
        public String toString() {
            return "UserRoomComposite{" +
                    "user=" + user +
                    ", room='" + room + '\'' +
                    '}';
        }
    }
    
    
    @Entity
    @Table(name = "tm_mem_user_room")
    @IdClass(value = UserRoomComposite.class)
    public class UserRoom extends BaseEntity {
        @Id
        @ManyToOne
        @JoinColumn(name = "user_id")
        private User user;
    
        @Id
        @ManyToOne
        @JoinColumn(name = "room_id")
        private Room room;
    
    //    @OneToMany(mappedBy = "userRoom")
    //    private List<SprinklingToken> sprinklingTokenList = new ArrayList<>();
    
    
        public User getUser() {
            return user;
        }
    
        public UserRoom setUser(User user) {
            this.user = user;
            return this;
        }
    
        public Room getRoom() {
            return room;
        }
    
        public UserRoom setRoom(Room room) {
            this.room = room;
            return this;
        }
    }
    ~~~
### 단방향/양방향 Mapping
  - 단방향 Mapping
    ~~~
    ~~~
    
  - 양방향 Mapping
    ~~~
    @Entity
    @Table( name = "TB_COM_USER" )
    public class User{
      @Id
      @Column( name = "USER_NO" )
      private Long userNo;
    }
    
    @Entity
    @Table( name = "TB_COM_ROLE" )
    public class Role{
      @Id
      @Column( name = "ROLE_CD" )
      private String roleCd;
    }
    
    @Entity
    @Table( name = "TB_USER_ROLE" )
    @IdClass( UserRoleCompositeKey.class )
    public class UserRole{
      @Id
      @ManyToOne
      @JoinColumn( name = "USER_NO", referencedColumnName = "USER_NO" )  // UserRole Table에 'USER_NO" 컬럼생성(name 속성)
                                                                         // User Table(referenceVariable의 Class Type 참조)의 'USER_NO' 컬럼참조(referencedColumnName 속성)
      private User user;
      
      @Id
      @ManyToOne
      @JoinColumn( name = "ROLE_CD", referencedColumnName = "ROLE_CD" )  // UserRole Table에 'ROLE_CD" 컬럼생성(name 속성)
                                                                         // Role Table(referenceVariable의 Class Type 참조)의 'ROLE_CD' 컬럼참조(referencedColumnName 속성)
      private Role role;
    }
    
    public class UserRoleCompositeKey implements Serializable{
      public UserRoleCompositeKey(){
      }
      
      public UserRoleCompositeKey( Long userNo, String roleCd ){
        this.user = userNo;
        this.role = roleCd;
      }
      
      private Long user;
      private String role;
    }
    
    - JoinColumn
      - name : 외래키로 정의 할, 자신의 테이블의 컬럼명(Column Name) 설정
      - referencedColumnName : 외래키로 참조할, 대상 테이블의 컬럼명 설정
      - foreignKey(DDL): 외래 키 제약조건명 설정(테이블을 생성조건에만 사용가능)
      - unique : @Column의 속성과 동일
      - nullable : @Column의 속성과 동일
      - insertable : @Column의 속성과 동일
      - updatable : @Column의 속성과 동일
      - columnDefinition : @Column의 속성과 동일
      - table : @Column의 속성과 동일
    ~~~
