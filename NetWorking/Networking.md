# NetWorking
- Port Forwarding CLI
- OSI 7 Layer, TCP/IP
- SSL(Secure Sockets Layer)/TLS(Transport Layer Security)
  - SSL
  - TLS
  - mTLS
- HTTP / HTTPS
  - Requests
  - Security

---

# Port Forwarding CLI
## Windows
```bash
# 목록확인
netsh interface portproxy show v4tov4

# 목록추가
netsh interface portproxy add v4tov4 listenport=8022 listenaddress=127.0.0.1 connectport=22 connectaddress=192.168.100.1

# 목록삭제
netsh interface portproxy delete v4tov4 listenport=8022 listenaddress=127.0.0.1
```


---

# OSI 7 Layer, TCP/IP
- [국제표준] OSI 7 Layer
  - 국제표준화기구(ISO)에서 네트워크 통신에서 일어나는 과정을 7단계로 나누어 정의한 모델

- [산업표준] TCP/IP
  - OSI 7 Layer의 4Layer(전송계층)를 TCP로 사용하고, 3Layer(네트워크계층)를 IP로 고정시킨 뒤, 복잡한 7계층을 4계층으로 함축시켜 놓은 모델


---

# SSL(Secure Sockets Layer)/TLS(Transport Layer Security)
데이터를 암호화하고 안전하게 전송하기 위해 사용되는 보안 프로토콜

## SSL
- SSL 2.0
- SSL 3.0

## TLS
- TLS 1.0(RFC 2246)
- TLS 1.1(RFC 4346)
- TLS 1.2(RFC 5246)
- TLS 1.3(RFC 8446)

### TLS 1.2(RFC 5246)
```text
Client                          Server
--------------------------------------------------
ClientHello        ---------->
                                ServerHello
                                Certificate
                                ServerKeyExchange
                   <----------  ServerHelloDone
ClientKeyExchange
ChangeCipherSpec
Finished           ---------->
                                ChangeCipherSpec
                                Finished
                   <----------  [ApplicationData]
ApplicationData    <--------->  ApplicationData
```

### TLS 1.3(RFC 8446)
```text
Client                          Server
--------------------------------------------------
ClientHello
{+KeyShare}        ---------->
                                ServerHello
                                {+KeyShare}
                                EncryptedExtensions
                                Certificate
                                CertificateVerify
                                Finished
                   <----------  [ApplicationData]
Finished
[ApplicationData]  ---------->
ApplicationData    <--------->  ApplicationData
```

- 개선사항
  - Hand-Shark 과정에서의 간소화
    - 1 RTT(Round Trip Time: 데이터를 상대방에게 보내고 응답받는데 걸리는 시간) 감소
  - 암호화 강화
  - 중개자 역할 감소
  - 무결성 보호 강화
  - 기타 기능 추가

- 등록절차
  - server 작업는 진행해야 한다.([Java - keytool](../Backend/Java.md#keytool) 를 참고)
  ```shell
  # KeyStore 생성
  keytool -genkeypair \
    -alias my-server \
    -keyalg RSA \
    -keysize 2048 \
    -keystore myserver-keystore.p12 \
    -storetype PKCS12 \
    -validity 365 \
    -dname "CN=myserver.com" \
    -storepass password \
    -keypass password

  # 인증서 추출
  keytool -exportcert \
    -alias my-server \
    -keystore myserver-keystore.p12 \
    -rfc -file myserver-cert.pem \
    -storepass password
  ```

  - 단, Spring Boot 등 Server를 사용할 경우 Server 내 설정도 필요하다.
    - Server
    ```yaml
    # application{-xxx}.yml
    server:
      ssl:
        enable: true
        protocol: TLSv1.3
        key-store: classpath:myserver-keystore.p12
        key-store-password: ${KEYSTORE_PASSWORD}  # Vault 사용 권장
        key-store-type: PKCS12
    ```
    - Client
    ```java
    SSLContext sslContext = SSLContext.getInstance("TLSv1.3");
    sslContext.init(null, null, null);  // 기본 TrustManager 사용
    
    HttpsURLConnection conn = (HttpsURLConnection) new URL("https://your-server.com/api/hello").openConnection();
    conn.setSSLSocketFactory(sslContext.getSocketFactory());
    conn.connect();
    ```
    
## mTLS(Mutual TLS)
Client와 Server가 서로를 인증하는 TLS 통신방식

- 등록절차
  - client/server 모두 같은 작업을 진행해야 한다.([Java - keytool](../Backend/Java.md#keytool) 를 참고)
  ```shell
  # KeyStore 생성
  keytool -genkeypair \
    -alias my-server \
    -keyalg RSA \
    -keysize 2048 \
    -keystore myserver-keystore.p12 \
    -storetype PKCS12 \
    -validity 365 \
    -dname "CN=myserver.com" \
    -storepass password \
    -keypass password

  # 인증서 추출
  keytool -exportcert \
    -alias my-server \
    -keystore myserver-keystore.p12 \
    -rfc -file myserver-cert.pem \
    -storepass password

  # TrustStore에 상대 인증서 등록
  keytool -importcert \
    -alias peer-server \
    -file peerserver-cert.pem \
    -keystore truststore.jks \
    -storepass password \
    -noprompt
  ```

  - 단, Spring Boot 등 Server를 사용할 경우 Server 내 설정도 필요하다.
    - Server
    ```yaml
    # application{-xxx}.yml
    server:
      port: 8443
      ssl:
        enabled: true
        protocol: TLSv1.3
        key-store: classpath:myserver-keystore.p12
        key-store-password: password
        key-store-type: PKCS12
        trust-store: classpath:truststore.jks
        trust-store-password: password
        client-auth: need  # <-- mTLS의 핵심 설정
    ```
    - Client
    ```java
    SSLContext sslContext = SSLContextBuilder.create()
      .loadKeyMaterial(new File("client-keystore.p12"), "password".toCharArray(), "password".toCharArray())
      .loadTrustMaterial(new File("truststore.jks"), "password".toCharArray())
      .build();

      CloseableHttpClient client = HttpClients.custom()
      .setSSLContext(sslContext)
      .build();

      HttpGet request = new HttpGet("https://peer-server.com/api/hello");
    CloseableHttpResponse response = client.execute(request);
    ```
    
---

# HTTP/HTTPS
- HTTP
- HTTPS: HTTP + [TLS](Networking.md#tls)

## Requests
- Simple Request
  - request의 'origin'과, response의 'Access-Control-Allow-Origin' 항목으로 구성
- PreFlight Request
  - "OPTIONS" Http Method를 통하여, 다른 도메인의 리소스로 HTTP 요청을 보내 실제 요청이 전송하기에 안전한지 확인하는 Request
- Credential Request

|       Request      |     Http Method               |        Agent            |
|--------------------|-------------------------------|-------------------------|
|Simple Request      |GET, POST, HEAD                |Accept                   |
|                    |                               |Accept-Language          |
|                    |                               |Content-Language         |
|                    |                               |Content-Type: application/x-www-form-urlencoded, multipart/form-data, text/plain        |
|                    |                               |DPR                      |
|                    |                               |Downlink                 |
|                    |                               |Save-Data                |
|                    |                               |Viewport-Width           |
|                    |                               |Width                    |
|PreFlight Request   |!Simple Request Mtth Method    |!Simple Request Agent    |
|Credential Request  |                               |                         |

### Simple Request
- a.kim.com 에서 b.kim.com 도메인의 컨텐츠를 호출하길 원할 경우
- Request의 Http Method와 Agent 가 '## Requests'에 기재된 내역으로 Send될 경우
  - 요청
  ```console
  GET /resources/public-data/ HTTP/1.1
  Host: b.kim.com
  User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:71.0) Gecko/20100101 Firefox/71.0
  Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8
  Accept-Language: en-us,en;q=0.5
  Accept-Encoding: gzip,deflate
  Connection: keep-alive
  Origin: https://a.kim.com
  ```

  - 응답
  ```console
  HTTP/1.1 200 OK
  Date: Mon, 01 Dec 2008 00:23:53 GMT
  Server: Apache/2
  Access-Control-Allow-Origin: *
  Keep-Alive: timeout=2, max=100
  Connection: Keep-Alive
  Transfer-Encoding: chunked
  Content-Type: application/xml
  
  […XML Data…]
  ```

### PreFlight Request
- ???
  - PreFlight 요청
  ```console
  OPTIONS /resources/post-here/ HTTP/1.1
  Host: b.kim.com
  User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:71.0) Gecko/20100101 Firefox/71.0
  Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8
  Accept-Language: en-us,en;q=0.5
  Accept-Encoding: gzip,deflate
  Connection: keep-alive
  Origin: http://a.kim.com
  Access-Control-Request-Method: POST
  Access-Control-Request-Headers: X-PINGOTHER, Content-Type
  ```

  - PreFlight 응답
  ```console
  HTTP/1.1 200 OK
  Date: Mon, 01 Dec 2008 00:23:53 GMT
  Server: Apache/2
  Access-Control-Allow-Origin: *
  Keep-Alive: timeout=2, max=100
  Connection: Keep-Alive
  Transfer-Encoding: chunked
  Content-Type: application/xml
  
  […XML Data…]
  ```

  - 실제 요청
  ```console
  POST /resources/post-here/ HTTP/1.1
  Host: b.kim.com
  User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:71.0) Gecko/20100101 Firefox/71.0
  Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8
  Accept-Language: en-us,en;q=0.5
  Accept-Encoding: gzip,deflate
  Connection: keep-alive
  X-PINGOTHER: pingpong
  Content-Type: text/xml; charset=UTF-8
  Referer: https://a.kim.com/examples/preflightInvocation.html
  Content-Length: 55
  Origin: https://a.kim.com
  Pragma: no-cache
  Cache-Control: no-cache
  
  <person><name>Arun</name></person>
  ```

  - 실제 응답
  ```console
  HTTP/1.1 200 OK
  Date: Mon, 01 Dec 2008 01:15:40 GMT
  Server: Apache/2
  Access-Control-Allow-Origin: https://a.kim.com
  Vary: Accept-Encoding, Origin
  Content-Encoding: gzip
  Content-Length: 235
  Keep-Alive: timeout=2, max=99
  Connection: Keep-Alive
  Content-Type: text/plain
  
  [Some GZIP'd payload]
  ```

### Credential Request

## Security
- XSS(Cross Site Scripting)
  - xss는 주입식 공격이다. 공격자가 악의적인 스크립트를 신뢰할 수 있는 웹사이트에 삽입하는 방법의 공격이며 총 3가지 유형이 있다.
    -Stored XSS: 보호되지 않고 검수되지 않은 사용자 입력으로 인한 취약점(데이터 베이스에 직접 저장되어 다른 사용자에게 표시됨)
    -Reflected XSS: 웹 페이지에서 직접 사용되는 URL의 비보안에 의해 발생하는 취약점
    -DOM based XSS: 웹페이지에서 직접 사용되는 URL의 비보안에 의해 발생한 취약점이라는 점에서 reflected XSS와 비슷하지만 DOM based XSS는 서버측으로 이동하지 않는다.
  > 공격방법: form data 등에 Source Code가 들어가서 Server에서 eval되는 경우
  > 
  > 방어방법: XSS Filter(Lucy Filter by Naver)를 적용하여 방어

- CORS(Cross-Origin Resource Sharing)
  - CORS는 2012년 이후에 출시된 거의 모든 브라우저 버전에 탑재된 보안 기능이다.
  - CORS가 도메인 website.com 에서 사용 가능한 서버에서 구성되면 리소스는 AJAX를 통해 동일한 도메인에서 제공되는 주소에서 시작되어야 한다.
  > 공격방법: a.kim.com 도메인에서 b.kim.com 도메인으로 Resource등을 막 빼넨다.
  > 
  > 방어방법: PreFlight Request를 사용하며, Response Header에 'Access-Control-Allow-Origin'에 허용할 내용을 기재한다.

- CSRF(Cross Site Request Forgery)
  - CSRF는 악의적인 웹사이트, 전자 메일, 블로그, 인스턴트 메시지 또는 프로그램으로 인해 사용자의 웹 브라우저가 사용자가 인증 된 다른 신뢰할 수 있는 사이트에서 원치 않는 작업을 수행 할 때 발생하는 공격 유형이다.
    이 취약점은 브라우저가 세션 쿠키, IP주소 또는 각 요청과 유사한 인증 리소스를 자동으로 보내는 경우에 발생 할 수 있다.
  > 공격방법: 공격자가 페이스북 로그인창 처럼 만들어서, 로그인 페이지를 고객에게 제공한뒤, 페이스북 Server로 요청을 날려서 해킹을 시도하는 경우
  > 
  > 방어방법: 페이스북은 로그인 페이지에 SecurityKey를 심어서, request할 때 심어둔 SecurityKey를 수신한다. 그 뒤 수신된 SecurityKey에 문제가 없는지 확인 후 이하 작업을 진행한다.