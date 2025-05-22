# Spring Boot
  - Spring Project creating
  - Spring Boot Config
    - profiles with maven3
  - Annotation
    - Request Mapping
      - @RequestParam, @ModelAttribute, @RequestBody, @RequestPart
    - Bean Dependency Injection
      - @Autowired/@Inject, @Qualifier/@Resource
- ApplicationContext
- Spring Bean
    - Bean life-cycle, Conditional Bean Registration, Bean Hooker(동적바인딩)
- Resolver
- Spring AOP
    - @Service, @Async
- Transactional
- Annotation
  - Spring Security
  - Thread
  - Validation
  - JUnit 5
    - Annotation
  - Spring Boot 2.4.x ↑
  - ExceptionHandler

---

# Spring Project creating
- Spring Initializr 사용방법(2가지)
  ~~~
  1. Spring 공식 홈페이지(spring.io)에서 제공하는 기능을 사용합니다.
    1-1. spring.io 접속
    1-2. projects(상단메뉴) > spring boot(조회된 메뉴) > Quick start(상세 탭) > Spring Initializr 이용
     
    2. IDE(Intelli-J, STS 등)에서 제공하는 기능을 사용합니다.
      2-1. 각 tools마다 사용법 상이.
  ~~~

- Spring Initializr Description
  ~~~
  - Project: Maven Project 또는 Gradle Project
    - 빌드, 베포 툴인 Maven과 Gradle 중 택
  - Language: Java, Kotlin, Groovy
  - Spring Boot: Spring Boot의 version
  - Project Metadata: group, artifact 등을 지정합니다.
    - 일반적으로 group은 project의 도메인 및 Default package 경로를 뜻하며, artifact는 프로젝트 명을 암시합니다.
  - Dependencies
    - 프로젝트의 의존성을 추가합니다. (간단히 소프트웨어의 플러그인 정도로 생각하면 됩니다.)

# Spring Boot Config
- 종류
    - spring.config.location
      Spring Boot 애플리케이션이 시작될 때 기본적으로 사용할 구성 파일의 위치를 지정합니다.
      이 속성을 설정하면, 지정한 경로에서 구성 파일을 로드하고 다른 경로에서 설정한 파일은 무시됩니다.
      예를 들어, spring.config.location=classpath:/custom-config/로 설정하면, 해당 경로에서만 설정 파일을 찾습니다.

    - spring.config.additional-location
      추가적인 설정 파일의 위치를 지정합니다.
      spring.config.location과 함께 사용되며, 기존의 기본 위치를 유지하면서 추가적으로 다른 파일을 로드합니다.
      예를 들어, spring.config.additional-location=classpath:/extra-config/로 설정하면, 기본 경로의 설정 파일을 로드한 뒤 추가 경로의 설정 파일도 함께 로드합니다.

    - spring.config.import
      다른 설정 파일을 가져오는 데 사용됩니다.
      주로 YAML 또는 프로퍼티 파일을 가져올 때 사용되며, 지정된 파일을 포함합니다.
      예를 들어, spring.config.import=optional:classpath:/external-config.yml와 같이 설정하면, 해당 파일을 조건부로 가져옵니다. 파일이 없으면 오류가 발생하지 않습니다.

- 개념
    - .properties
    - yaml
        - 파일명 또는 경로변경/추가
      ```console
      [user@localhost ~]# java -jar myproject.jar --spring.config.name=myproject.yaml
      --------------------------------------
        - Describe
          - 파일명 변경
          
          
      [user@localhost ~]# java -jar myproject.jar --spring.config.location=classpath:/myproject/{또는 파일명 변경 시, classpath:/myproject/myproject.yaml}
      --------------------------------------
        - Describe
          - 파일경로 변경
        - Result: 기존 4개 경로에서, Customizing된 경로 1개로 변경된다.
          - 기존 경로(4개)
            file:./config/
            file:./
            classpath:/config/
            classpath:/
          - Customizing되어 변경된 경로(1개)
            classpath:/myproject/
          
          
      [user@localhost ~]# java -jar myproject.jar --spring.config.additional-location=classpath:/custom-config/,file:./custom-config/
      --------------------------------------
        - Describe
          - 파일경로 추가
        - Result
          - file:./custom-config/
            classpath:custom-config/
            file:./config/
            file:./
            classpath:/config/
            classpath:/
      ```
    - 환경변수
    - command line args

    - 사용방법
  ```console
  [user@localhost ~]# java -jar -Dspring.profiles.active=dev board-0.0.1-SNAPSHOT.jar
    
  또는
    
  [user@localhost ~]# java -jar -Dspring-boot.run.profiles=dev board-0.0.1-SNAPSHOT.jar
  ```

- 참고사이트: [https://www.latera.kr/reference/java/2019-09-29-spring-boot-config-externalize/](https://www.latera.kr/reference/java/2019-09-29-spring-boot-config-externalize/)

## profiles with maven3
- You can provide commandline argument like this:
  ```console
  mvn spring-boot:run -Dspring-boot.run.arguments="--spring.profiles.active=dev"
  ```
- You can provide JVM argument like this:
  ```console
  mvn spring-boot:run -Dspring-boot.run.jvmArguments="-Dspring.profiles.active=dev"
  ```
- java -jar
  ```console
  java -Dspring.profiles.active=dev -jar app.jar (Note order)
  
  or
  
  java -jar app.jar --spring.profiles.active=dev (Note order)
  ```
  
# Annotation
## Request Mapping
|               |Content-Type                                            |Binding                  |
|---------------|--------------------------------------------------------|-------------------------|
|@RequestParam  |QueryString                                             |Converter, PropertyEditor|
|@ModelAttribute|QueryString <br>application/json <br>multipart/form-data|Constructor/Setter       |
|@RequestBody   |application/json                                        |HttpMessageConverter     |
|@RequestPart   |application/json+@RequestBody                           |HttpMessageConverter     |

- Jackson Lib는 HttpMessageConverter를 확장한 lib이기 때문에, @ReqeustParam, @ModelAttribute는 @JsonProperty등이 적용되지 않는다.
- ExtendedServletRequestDataBinder

## Bean Dependency Injection
- 타입기반
  - @Inject, @Autowired
- 이름기반
  - @Resource, @Qualifier

|        | 선언               | 주입                    |
|--------|-------------------|------------------------|
| JDK    | @Name, @Resource  | @Inject, @Resource     |
| Spring | @Bean, @Component | @Autowired, @Qualifier |

# ApplicationContext
BeanFactory(Spring Container의 최상위 인터페이스)의 Sub Class으로 Spring Container라고 한다.

## 상속받는 인터페이스 목록
- EnvironmentCapable
- ListableBeanFactory
- HierarchicalBeanFactory
- MessageSource
- ApplicationEventPublisher: 이벤트 정보 처리
- ResourcePatternResolver: 설정 정보 처리

## ApplicationContext의 역활
- Bean의 생성과 소멸주기 관리
- 의존성 주입 관리
- 프로퍼티 설정 및 환경관리
- 리소스 관리

## Reference
[공식문서 ApplicationContext](https://docs.spring.io/spring-framework/docs/current/javadoc-api/org/springframework/context/ApplicationContext.html)

# Spring Bean
BeanDefinition 인터페이스를 구현한 구현체들이 Bean을 정의한다.

- BeanDefinition
  - 빈의 속성이라 불리우며, Bean의 정보가 들어있다.
  - beanClassName, scope, 초기화시점, AutowireCandidate(다른 빈 객체에 Autowired되는지 여부), primary(상위 타입이 같은 구현체들 사이에서 의존 주입시 우선순위를 갖는지 여부) 등

- BeanDefinition의 구현체
  - GenericBeanDefinition: XML, Java Config 등으로 Bean을 정의
  - AnnotatedGenericBeanDefinition: 애노테이션 기반으로 구성된 빈 정의
  - RootBeanDefinition: 부모 정의가 없는 독립적인 빈 정의
  - 등등..

## Bean life-cycle
```text
Spring Container 생성 -> Spring Bean 생성 -> 의존관계 주입 -> 초기화 콜백 메소드 호출 -> 사용 -> 소멸 전 콜백 메소드 호출 -> 스프링 종료
```

- Spring Bean 생성
  - 생성할 BeanDefinition 정의
  - BeanDefinition을 BeanDefinitionRegistry에 저장(Bean의 메타 정보만 저장한다는 뜻)
  - BeanDefinition을 바탕으로 Bean을 인스턴스화
  - Bean Instance를 SingletonBeanRegistry에 저장(Bean을 실제로 인스턴스화 하여, 객체를 저장하다는 뜻)

- 초기화 콜백 메소드 호출
  - InitializingBean Interface
  ```java
  public class Sample implements InitializingBean {
    @Override
    public void afterPropertiesSet() throws Exception{
      // TODO
    }
  }
  ```
  - @PostConstruct Annotation

- 소멸 전 콜백 메소드 호출
  - DisposableBean Interface
  ```java
  public class Sample implements DisposableBeaen {
    @Override
    public void destroy() throws Exception{
      // TODO
    }
  }
  ```
  - @PreDestory Annotation

## Conditional Bean Registration(조건부 빈 등록)
### 사용자 정의 조건부 빈 등록
- Conditional
  ```console
  public class PropertyCondition implements Condition {
      @Override
      public boolean matches(ConditionContext context, AnnotatedTypeMetadata metadata) {
          return context.getEnvironment().getProperty("propertyName") != null;
          // optionally check the property value
      }
  }
  
  @Configuration
  public class MyAppConfig {
      @Bean
      @Conditional(PropertyCondition.class)
      public MyBean myBean() {
        return new MyBean();
      }
  }
  
  @Configuration
  public class MyAppConfig {
      @Bean
      @Conditional({PropertyCondition.class, SomeOtherCondition.class})
      public MyBean myBean() {
        return new MyBean();
      }
  }
  ```

### Class Conditional
- @ConditionalOnClass
- @ConditionalOnMissingClass
  ```console
  @Bean
  @ConditionalOnWebApplication
  @ConditionalOnClass(OObjectDatabaseTx.class)
  @ConditionalOnMissingBean(OrientWebConfigurer.class)
  public OrientWebConfigurer orientWebConfigurer() {
      return new OrientWebConfigurer();
  }
  ```

### Bean Conditional
- @ConditionalOnBean
- @ConditionalOnMissingBean

### Property Conditional
- @ConditionalOnProperty
  ```console
  @ConditionalOnProperty(value='somebean.enabled', matchIfMissing = true, havingValue="yes")
  @Bean 
  public SomeBean someBean(){
  }
  ```

### Resource Conditional
- @ConditionalOnResource
  ```console
  @ConditionalOnResource(resources = "classpath:init-db.sql") 
  ```

### WebApplication Conditional
- @@ConditionalOnWebApplication
- @ConditionalOnNotWebApplication
  ```console
  @Configuration
  @ConditionalOnWebApplication
  public class MyWebMvcAutoConfiguration {...}
  ```

### Expression Conditional
- @ConditionalOnExpression
  ```console
  @ConditionalOnExpression("${rest.security.enabled}==false")
  ```

## Bean Hooker(동적바인딩)
### ImportSelector
Annotation Attribute 에 따라 다른 설정 클래스를 사용할 때.  
사용할 클래스 이름을 응답하는 방식.
```java
@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.TYPE)
@Import(EnableApplicationListenerSelector.class)
public @interface EnableApplicationListener {
    ListenerType type() default ListenerType.AAA;
}

public class EnableApplicationListenerSelector implements ImportSelector {
  @Override
  public String[] selectImports(AnnotationMetadata importingClassMetadata) {
    Map<String, Object> attributesMap = importingClassMetadata.getAnnotationAttributes(EnableApplicationListener.class.getName(), false);
    AnnotationAttributes attributes = AnnotationAttributes.fromMap(attributesMap);
    ListenerType type = attributes.<ListenerType>getEnum("type");
    if (type==ListenerType.AAA) {
      return new String[]{AAA.class.getName()};
    } else if(type==ListenerType.BBB) {
      return new String[]{BBB.class.getName()};
    }
    return new String[0];
  }
}

@Configuration
@EnableApplicationListener(type = ListnerType.AAA)
public class  Application{
  ...
}

@Component
public class UseComponent {
  private Listner listner;
    
  public UseComponent(Listener listner){
      this.listner = listner;   // AAA Listener DI
  }
}
```

### ImportBeanDefinitionRegistrar
Annotation Attribute 에 따라 다른 설정 클래스를 사용할 때.
직접 빈을 등록하는 방식.
```java
@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.TYPE)
@Import(ApplicationListenerBeanDefinitionRegistrar.class)
public @interface EnableApplicationListener {
  boolean enable() default truu;
}

public class ApplicationListenerBeanDefinitionRegistrar implements ImportBeanDefinitionRegistrar { 
  @Override
  public void registerBeanDefinitions(AnnotationMetadata importingClassMetadata, BeanDefinitionRegistry registry) {
    Map<String, Object> attributes = importingClassMetadata.getAnnotationAttributes(EnableApplicationListener.class.getName());
    boolean enabled = (boolean) attributes.getOrDefault("enable", true);
    if (enabled) {
      RootBeanDefinition beanDefinition = new RootBeanDefinition(ApplicationListener.class);
      registry.registerBeanDefinition("applicationListener", beanDefinition);
    }
  }
}
```

### BeanDefinitionRegistryPostProcessor
- Bean 정의 등록/수정
- 컨테이너 초기화 시작 전

### BeanFactoryPostProcessor
- Bean 정의를 재정의 또는 속성추가 목적
- Bean 인스턴스화 전에 실행

### BeanPostProcessor
- Bean 인스턴스를 재정의 목적
- Bean 인스턴스화 직후 실행

- 참고사이트: [https://thecodinglog.github.io/spring/2019/01/29/dynamic-spring-bean-registration.html](https://thecodinglog.github.io/spring/2019/01/29/dynamic-spring-bean-registration.html)

# Resolver
어떤 "요청"이나 "정보"를 해석해서 적절한 형태로 변환하거나 결정해주는 컴포넌트  

- Resolver 종류
  - ViewResolver: Controller가 응답한 뷰 이름(String)을 실제 View로 매핑하여 실제 View를 반환
  - HandlerMethodArgumentResolver: Controller의 파라미터를 해석해서 알맞은 객체로 주입
  - HandlerExceptionResolver
    - ResponseEntityExceptionHandler Interface
    - @ExceptionHandler Annotation
  - ResourceResolver
  - 등등

# Spring AOP
## AOP의 개본개념
- 요소
  - Aspect: 횡단 관심사를 모듈환 한 것(보통 설정클래스가 된다. ex> XXXAspect)
  - Adivce: 언제/어떤 코드를 실행할지 정의(Annotation으로 정의한다. ex> Before, After, Around 등)
  - Join Point: Adivce가 적용될 수 있는 지점(ex. 메소드 실행)
  - Pointcut: Advice가 적용될 Join Point를 선정하는 표현식(Advice Annotation의 exeution() 메소드 안에 기재한다.)
  - Weaving: Advice를 실제 대상 객체에 적용하는 과정
  - Proxy: 대성 객체를 감싸서 AOP 기능을 부여한 객체

- AOP 작동방식
  - JDK Dynamic Proxy **(Spring 3.2 이하버전)**
    - 대상 객체가 인터페이스를 구현하고 있을 때 사용
    - OOP Design Pattern의 Proxy Pattern 과 동일
    - 사용자의 요청으로 최종적으로 생선된 Proxy의 메소드를 통해 호출할 때 내부적으로 invoke에 대한 검증과정이 이루어진다.
    ```java
    public Object invoke(Object proxy, Method proxyMethod, Object[] args) throws Throwable {
      Method targetMethod = null;
      // 주입된 타깃 객체에 대한 검증 코드
      if (!cachedMethodMap.containsKey(proxyMethod)) {
        targetMethod = target.getClass().getMethod(proxyMethod.getName(), proxyMethod.getParameterTypes());
        cachedMethodMap.put(proxyMethod, targetMethod);
      } else {
        targetMethod = cachedMethodMap.get(proxyMethod);
      }
    
      // 타깃의 메소드 실행
      Ojbect retVal = targetMethod.invoke(target, args);
      return retVal;
    }
    ```
  - CGLIB Proxy(Code Generator Library Proxy) **(Spring 3.2 이상버전)**
    - 인터페이스가 없거나, 클래스 기반으로 프록시를 만들고자 할 때 사용
    - 클래스의 바이트코드를 조작하여 Proxy 객체를 생성해주는 라이브러리

## @Service
- @Component를 내부적으로 포함한다. 즉, 컴포넌트 스캔의 대상이다.
- Transaction은 하나의 비즈니스 로직 단위를 묶기 위함으로, 그 관점이 같은 @Service에 정의한다.  
  - ref> [Spring Boot.md](Spring%20Boot.md#transactional)

## @Async
Spring AOP에 의해 Proxy Pattern으로 동작한다.

- 실행방법
  - @EnableAsync 선언
    - @Async 사용 선언
  - TaskExecutor 정의
    - TaskExecutor를 정의하지 않으면, SimpleAsyncTaskExecutor가 기본적으로 사용되며, 이는 요청마다 새로운 Thread를 만듦으로 성능에 지장을 준다.
    - TaskExecutor Bean을 정의할 때, Bean의 이름을 정의하여, 주입하자. 여러개의 경우 빈을 찾을 수 없게 되고, 그러면 또 다시 SimpleAsyncTaskExecutor가 기본적으로 사용되기 때문이다. 
    - 정의방법
      - AsyncConfigurer Interface
      - @Bean 으로 생성

# Transactional
@Transactional은 Proxy 기반 AOP로 구현해야 한다.
이로 인해 클래스 외부에서 호출해야만 트랜잭션이 적용된다.

## 성능최적화
- readOnly 속성
    - @Transactional Annotation의 readOnly 속성을 "true"값을주면, Database는 해당 Transaction에 Lock을 걸지 않고, 데이터를 바로 읽어들여온다.  
      이로 인해 Database의 lock 경합을 줄일 수 있다.
    - 다만, Oracle은 MVCC 기반으로 lock-free이다. 즉, 성능에 직접적인 영향을 주지 않을 수 도 있음을 명시하자.
    - JPA의 경우 Dirty Checking에 의해 확실한 성능이슈를 볼 수 있다.
        - 영속성에만 남아 있는 데이터. 즉, Commit 되지 않은 데이터를 조회할 때, JPA는 강제로 flush를 실행하여 Commit을 실행하고 데이터를 조회한다. 이를 방지하기 위해 readOnly=true를 사용하기도 한다.

[참고: [Theory] Transaction.md](%5BTheory%5D%20Transaction.md)

# Spring Security

# Thread
## Java 표준 라이브러리
- Executors.newFixedThreadPool(n): 고정 크기의 쓰레드 풀
- Executors.newCachedThreadPool(): 필요한 만큼 쓰레드를 만들고, 사용하지 않으면 제거
- Executors.newStrigThreadExecutor(): 하나의 스레드만 사용하는 풀
- Executors.newScheduledThreadPool(n): 일정 시간마다 또는 주기적으로 작업 수행
- ThreadPoolExecutor(Java 5+): 쓰레드 대기를 위하여 BlockingQueue를 사용.

## Spring 표준
- ThreadPoolTaskExecutor: Spring 에서 비동기 작업(ex. @Async)에 사용되는 쓰레드 풀
```java
public static void executor() {
  ThreadPoolTaskExecutor executor = new ThreadPoolTaskExecutor();
  executor.setCorePoolSize(5);
  executor.setMaxPoolSize(10);
  executor.setQueueCapacity(25);
  executor.initialize();
}
```

# Validation
- 참고싸이트: [https://kapentaz.github.io/spring/Spring-Boo-Bean-Validation-%EC%A0%9C%EB%8C%80%EB%A1%9C-%EC%95%8C%EA%B3%A0-%EC%93%B0%EC%9E%90/#](https://kapentaz.github.io/spring/Spring-Boo-Bean-Validation-%EC%A0%9C%EB%8C%80%EB%A1%9C-%EC%95%8C%EA%B3%A0-%EC%93%B0%EC%9E%90/#)
  
- 참고싸이트: [https://meetup.toast.com/posts/223](https://meetup.toast.com/posts/223)

# JUnit 5
- JUnit Platform: Test를 실행해주는 런처, TestEngine API를 제공한다.
- Jupiter: JUnit 5를 지원하는 TestEngine API의 구현체
- Vintage: JUnit 4, 3을 지원하는 TestEngine API의 구현체

## Test 방법
### SpringBoot
- @SpringBootTest

### Controller
Controller만 스캔해서 빈으로 등록하고, 다른 빈은 자동 등록하지 않아 빠른 테스트가 가능하도록 한다.

- @WebMvcTest
  - JUnit 5 테스트에서 Spring Context와 의존성 주입 기능을 연결한다.(@Autowired, @MockBean 등)
  ```java
  @WebMvcTest(SampleController.class)
  class SampleControllerTest {
      @Autowired
      private MockMvc mockMvc;
  
      @MockBean
      private SampleServiceImpl sampleServiceImpl;  // SampleController에 Inject 되어있는 멤버변수
  
      @Test
      void test() throws Exception {
        // given
        Customer customer = Customer.builder().id(10L).build();
        
        // when
        when(sampleServiceImpl.getCustomer(any())).thenReturn(customer);
        
        // then
        mockMvc.perform(post("/api/customer/{id}", 10L)
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(jsonBody))
                .andExpect(status().isOk());
      }
  }
  ```

### Service
- @ExtendWith: JUnit에서 확장 기능을 등록한다.
  - SpringExtension: JUnit 5 테스트에서 Spring Context와 의존성 주입 기능을 연결한다.(@Autowired, @MockBean, @ContextConfiguration)  
                     세부적으로 SpringExtension은 테스트 실행 시에 TestContext를 초기화하고 관리하며, ApplicationContext의 Bean들을 모두 포함할 수 있게 된다.
    - @ContextConfiguration: 해당 Annotation에 기재된 Bean들을 ApplicationContext 등록할 수 있도록 유도한다.(이후 SpringExtension에 의해 TestContext로 포함되어진다.)
  - MockitoExtension: Mockito의 Mocking Framework의 의존성 주입 기능을 연결한다.(@InjectMocks, @Mock)
  - TimeoutExtension: Test Method 실행 시간 제한 설정
  - ParameterResolver: Test Method Paramter 자동 주입
  - TestWatcher: Test 결과 이벤트 후킹 및 로깅
  - 사용자 정의(Custom Extension)
  ```java
  @ExtendWith(SpringExtension.class)
  @ContextConfiguration(classes = {SampleComponent.class})
  class SampleTest {
    @Autowired
    @Qulifier("sample-component")
    private SampleComponent sampleComponent;
  }
  
  @ExtendWith(MockitoExtension.class)
  class SampleTest {
    @InjectMocks
    private SampleService sampleService;
    
    @Mock
    private SampleRepository sampleRepository;
  }
  
  // 같이 사용할 수 있다.
  @ExtendWith({SpringExtension.class, MockitoExtension.class})
  class MyTest {
    // ...
  }
  ```

### Repository
- 조금 귀찮타.. DatabaseTestConfigurer도 설정해야 되고.. 이것은 나중에 기재하자..

## 단언 라이브러리: Assertion Library(=테스트 보조 라이브러리: Testing Utility Library)
단독 테스트 프레임워크는 아니지만, JUnit과 같은 테스트 프레임워크과 함께 사용하여 테스트를 더 풍부하게 만들어주는 도구

### Hamcrest(JUnit 4)

### AssertJ(JUnit 5)
Hamcrest 보다 더 유연한 문법을 제공하며, Fluent API 스타일로 되어 Chaining으로 다양한 조건을 자연스럽게 이어서 쓸 수 있다.

- 단언의 종류
  - assertThat
  ```java
  // Equals
  assertThat(actual).isEqualTo(expected);
  
  // start/end With
  assertThat("Kim Hyunyun").startsWith("Kim").endsWith("Hyunyun");
  
  // catchThrowable
  Throwable thrown = catchThrowable(() -> {
    throw new IllegalArgumentException("Invalid input");
  });
  
  assertThat(thrown).isInstanceOf(IllegalArgumentException.class).hasMessageContaining("Invalid");
  ```
  
  - assertThatThrownBy
  ```java
  // catchThrowable 보다 간결하게 작성할 경우 사용
  assertThatThrownBy(() -> { throw new IllegalStateException("Boom"); })
    .isInstanceOf(IllegalStateException.class)
    .hasMessage("Boom");
  ```
  
  - entry
  ```java

  ```

## Annotation
  ```console
  @Disabled
      -> 테스트를 하고 싶지 않은 클래스나 메서드에 붙이는 어노테이션

  @DisplayName("IDE나 빌드툴에서 알아 볼 수 있도록")
      -> 어떤 테스트인지 쉽게 표현할 수 있도록 해주는 어노테이션

  @RepeatedTest( value = 10, name = " {displayName} 중 {currentRepetition} of {totalRepetitions}")
      -> 반복적으로 사용할 때 사용

  @ParameterizedTest
  @CsvSource(value = {"ACE,ACE:12", "ACE,ACE,ACE:13"}, delimiter = ':' )
      -> 테스트에 여러 다른 매개변수를 대입해가며 반복실행할 때 사용하는 어노테이션
  void calculateCardSumWhenAceIsTwo( final String input, final int expected ){
    final String[] inputs = input.split(",");
    for( final String number : inputs ) {
        final CardNumber cardNumber = CardNumber.valueOf(number);
	dealer.receiveOneCard( new Card(cardNumber, CardType.CLOVER) );
    }

    assertThat( dealer.calculateScore()).isEqualTo( expected );
  }

  @Nested
      -> 테스트 클래스 안에서 내부 클래스를 정의해 테스트를 계층화 할 때 사용

  * Assertions
    * example
      @Test
      void exceptionThrow(){
          Exception e = assertThrows(Exception.class, ()-> new Test(-10));
          assertDoesNotThrow( ()-> System.out.println("Do Something"));
      }

  * assertTimeout
    * Assumption
      * example
        void some_test(){
            assumingThat("DEV".equals(System.getenv("ENV")), () -> {
                assertEquals("A", "B");		// 단정문이 실행되지 않음
            });
            assertEquals("A", "A");			// 단정문이 실행됨
        }
  ```

# Spring Boot 2.4.x
- 참고싸이트: [https://spring.io/blog/2020/11/12/spring-boot-2-4-0-available-now](https://spring.io/blog/2020/11/12/spring-boot-2-4-0-available-now)

## Properties
- Kubernetes의 volume mounts를 지원하기 워해, Properties 설정하는 법이 변경되었다.(사실 무슨 뜻인지 모르겠다..)
- 많은 특징들이 있는데, 실수할 수 있을만한 내용만 기재하며, 이하 공식문서를 참고하자.
- yml문서 내에서 "---"으로 profile을 나눌 수 있었는데, properties문서 내에서도 "#---"으로 profile을 나누는게 가능해졌다.
- The Problem with ConfigFileApplicationListener
    - include는 특정 profile이 적용된 곳에서 사용할 수 없다. 즉, on-profile 과 include 가 공존할 수 없다는 뜻.
    - 이유는.. 아래 싸이트의 링크를 접속 후, "The Problem with ConfigFileApplicationListener" 으로 검색하면 알 수 있다.
    - 참고싸이트: [https://spring.io/blog/2020/08/14/config-file-processing-in-spring-boot-2-4](https://spring.io/blog/2020/08/14/config-file-processing-in-spring-boot-2-4)
- How to use ?
  ```
  mvn clean compile spring-boot:run -Dspring-boot.run.profile={spring.profiles.group의 key값}
  
  # application.yml
  spring:
    config:
      import: classpath:/example-config.yml
    profiles:
      group:
        default: local, logback, example		# 여기서 "example"은 example-config.yml의 'spring.config.activate.on-profile' 값
        local: local, logback
        dev: dev, logback
        prd: prd
      # include: example				# 여기서 "example"은 example-config.yml의 'spring.config.activate.on-profile' 값
      						# include는 사용하는 문서(여기서는 'application.yml')내에 바로 포함할 때 사용한다.
							# 즉, 해당 문서에서 사용할 경우 default, local, dev, prd모든 proilfe에 example이 포함된다.
	
	
  # application-local.yml
  
  
  # application-dev.yml
  
  
  # application-prd.yml
  
  
  # application-logback.yml
  spring:
    output:
      ansi:
        enabled: always

  logging:
    pattern:
      console: "%d{yyyy-MM-dd HH:mm:ss.SSS} [%thread] %-36logger{36} %clr([%-5level]) : %msg%n"
    level:
      root: info
      org.springframework: info
      com.example.demo: debug
      
      
  # example-config.yml
  # 더이상 반드시, application-{profile}.yml의 형태로 기입하지 않아도 된다.
  # 단, 'spring.config.activate.on-profile'으로 profile명을 기재해야 한다.
  spring:
    config:
      activate:
        on-profile: example
  ```
