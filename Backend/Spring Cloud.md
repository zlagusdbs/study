# Spring Cloud
- resillience4j
  - reference
- Spring Sleuth

---

# Resilience4j
![circutibreaker](../Resource/Prog,%20Spring,%20Cloud,%20Resilience4j-circutibreaker.png)  

## reference
[spring-cloud Supported Implementations](https://docs.spring.io/spring-cloud-commons/docs/current/reference/html/#introduction)  
[spring-cloud-circuitbreaker learn](https://spring.io/projects/spring-cloud-circuitbreaker#learn)  

[resilience4j circuitbreaker](https://resilience4j.readme.io/docs/circuitbreaker)  
[resilience4j getting-started](https://resilience4j.readme.io/docs/getting-started)  
[resilience4j create-and-configure-a-circuitbreaker](https://resilience4j.readme.io/docs/circuitbreaker#create-and-configure-a-circuitbreaker)  
[Resilience4j/contents/](https://godekdls.github.io/Resilience4j/contents/)

# Spring Sleuth
분산 시스템 또는 MSA Architecture에서 어플리케이션의 트랜잭션 추적을 쉽게 할 수 있도록 돕는 분산 추적 라이브러리이다.
분산 추적을 위해 트랜잭션을 식별하는 ID를 자동으로 생성하고 이를 전달한다.
HTTP 요청, Message Queue, Database 등과 같은 여러 서비스 간의 통신을 추적할 수 있다.

```groovy
// build.gradle
dependencies {
  implementation 'org.springframework.cloud:spring-cloud-starter-sleuth'
}
```

```java
@RestController
public class SimpleSpringSleuth {
    private static final Logger logger = LoggerFactory.getLogger(MyController.class);

    @GetMapping("/simple")
    public String prcoess() {
        logger.info("처리 시작");
        
        // TODO
        
        logger.info("처리 완료");
        return "success";
    }
}

/**
 * Logging Console
 *   하기 logging에 traceId와 spanId가 자동으로 삽입된 것을 확인할 수 있다.
 */
// yyyy-MM-dd hh24:mm:ss.SSS  INFO 12345 --- [nio-8080-exec-1] c.e.m.SimpleSpringSleuth : [traceId:abc123, spanId:def456] 처리 시작
// yyyy-MM-dd hh24:mm:ss.SSS  INFO 12345 --- [nio-8080-exec-1] c.e.m.SimpleSpringSleuth : [traceId:abc123, spanId:def456] 처리 완료
```
- Spring Sleuth는 내부적으로 SLF4J와 MDC를 사용하여, 로그에 TraceID, SpanID를 자동으로 추가한다.

## Transaction Tracing
고유한 TraceID와 SpanID로 식별하여 Transaction을 추적한다.
이 정보는 Log와 함께 기록되며, 이를 통해 분산 시스템 또는 MSA Architecture를 거쳐 요청이 어떻게 흐르는지 알 수 있다.

- TraceID: 하나의 요청을 추적하는 고유 식별자
- SpanID: 개별 서비스에서 처리하는 작업을 추적하는 고유 식별자(즉, 하나의 요청이 여러개의 SpanID로 나뉠 수 있다.)
- Parent SpanID: 현재 SpanID의 referer

## Integration Logging
Zipkin UI, Jaeger UI 같은 분산 추적 시스템과 연결될 수 있다.
