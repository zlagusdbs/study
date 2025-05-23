# Theory
- OAuth 2.0

---

# OAuth 2.0
## 구성요소
- Resource Owner: 사용자(ex> 실제 회원)
- Application: 사용자의 데이터를 요청하는 Client(ex> 쇼핑, 도서, ENT, TOUR 시스템)
- Authorization Server: AccessToken을 발급하는 서버
- Resource Server: 요청정보를 제공하는 서버

## Grant Types
![슬라이드1.PNG](../Resource/Backend%2C%20OAuth/%EC%8A%AC%EB%9D%BC%EC%9D%B4%EB%93%9C1.PNG)

- Authorization Code Grant
  - 사용자가 로그인 후 인가 코드를 클라이언트에게 제공하고, 클라이언트는 이를 인증 서버에 전달하여 AccessToken을 받는다.
  - 서버 to 서버에 적합
  - **PKCE(Proof Key for Code Exchange)**
    - AccessToken 등 인증코드의 Hooking을 방지하기 위한 방법이다.
    - client는 Authorization Server에 인증 요청시, 임의의 값을 만들어 함께보낸다.  
      이때 Authorization Server는 임의의 값을 Server내에 저장하여, 후에 응답할 AccessToken등과 매핑한다.

- Implicit Grant
  - Client(=Browser) to 서버에 적합

- Resource Owner Password Credential Grant
  - 같은 회사가 아닐 시 사용금지.(타사의 회원정보를 요청하는 것과 같다)

- Client Credentials Grant
  - 서버 인증을 통해 Client가 관리하도록 한 Authorization Server 또는 Resource Server에 AccessToken을 요청

## Experience
- Authorization Code Grant 채택
- Authorization Server와 Resource Server를 통합(with Spring Boot Framework)
  - Authorization Server는 Spring Security로 구현하며, Resource Server는 일반 Layered Architecture의 API
- PKCE(Proof Key for Code Exchange)
  - UUID를 생성(with PK+timestamp) 
- Logging 백업을 위해 MySQL의 Archive Engine을 설정하여 저장
  - log를 볼일이 거의 없기 때문에 판단.
