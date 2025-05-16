# AWS

---

# Install
- 4가지 방법: docker, linux, macOS, windows

## Reference
- [https://docs.aws.amazon.com/ko_kr/cli/latest/userguide/install-cliv2.html](https://docs.aws.amazon.com/ko_kr/cli/latest/userguide/install-cliv2.html)

# Compute
- Amazon EC2(Elastic Compute Cloud)
- Amazon Lambda
- Amazon ECS(EC2 Container Service)
- Amazon EB(Elastic Beanstalk)
- Amazon Lightsail
- Amazon Batch
- Amazon CloudWatch
- Cloud 환경에 Resource를 Monitoring, Triggering 할 수 있다.
- ELB(Elastic Load Balancing)
- Auto Scaling
  - 내결함성 향상 : (Instance에 Host가 없어지는(장애) 경우, 총 인스턴스의 갯수를 지정해 놓고 그 갯수 이하로 instance가 줄어든다면 자동으로 늘려줄 수 있다.
  - 시작구성 : Auto Scaling에서만 사용하는 탬플릿 
  - 시작탬플릿 : Auto Scaling 또는 그 외 사용가능한 탬플릿, 시작구성에 비해 versioning이 가능함.

## 배치전략
### 클러스터 배치 전략
- 단일 가용 영역(AZ) 내에 있는 인스턴스의 논리적 그룹.
- 동일한 리전의 피어링된 VPC에 걸쳐 적용될 수 있다.
- 동일한 클러스터 배치 그룹의 인스턴스는 TCP/IP 트래픽에 더 높은 흐름당 처리량 제한을 제공하며 네트워크의 동일한 높응 양방향 대역폭 세그먼트에 배치

### 파티션 배치 전략
- 어플리케이션에 대한 상관 관계가 있는 하드웨어 장애 가능성을 줄이는데 도움이된다.
- AWS EC2는 각 그룹을 파티션이라고 하는 논리 세그먼트로 나누며, 이를 배치 그룹이라 명하고, 배치 그룹 내 각 파티션에 자체 랙 세트가 있는지 확인한다.
- 위의 랙은 자체 네트워크 및 전원이 있으며, 배치 그룹 내 두 파티션이 동일한 랙을 공유하지 않으므로 어플리케이션 내 하드웨어 장애의 영향을 격리할 수 있다.

### 분산형 배치 전략
- 각각 고유한 랙에 배치된 인스턴스 그룹이며, 랙 마다 자체 네트워크 및 전원이 있다.
- 서로 떨어져 있어야 하는 중요 인스턴스의 수가 적은 어플리케이션에는 분산형 배치 그룹이 권장되나, 분산형 배치 그룹에서 인스턴스를 시작하면 인스턴스가 동일한 랙을 공유할 때 장애가 동시에 발생할 수 있는 위험이 줄어든다.
- 분선형 배치 그룹은 별개의 랙에 대한 엑세스를 제공하기 때문에 시간에 따라 인스턴스를 시작하거나 인스턴스 유형을 혼합할 때 적합한다.
- 분산형 배치 그룹은 동일한 리전의 여러 가용역역에 적용될 수 있다.(단, 그룹당 가용 영역별로 최대 7개의 실행 중인 인스턴스를 가질 수 있다.)

# Networking
- Amazon VPC(Virtual Private Cloud)
- Amazon Route 53
- Amazon ELB(Elastic Load Balancing)
- Amazon DC(Direct Connect)

## Amazon VPC(Virtual Private Cloud)
- organization: 계정이 여러개라도 통합계정처럼 사용가능
- VPC를 만들면 default 라우팅이 함께 만들어진다.
  - default 라우팅은 아래와 같이 되어있기때문에 모든 통신이되고, NACL(Network Access Controll List)로 접근하는 방법밖에 차단할 수 있는 방법이 없다.   
  |목적지        |        대상 |
  |---------------------------|
  |vpnip/cidr   |      local  |
- subnet을 만들면, default 라우팅이 기본적으로 적용된다.
  
- 퍼블릭 서브넷
  - 인터넷에서 먼저 접근이 가능
- 프라이빗 서브넷
  - 인터넷에서 먼저 접근이 불가
  
- VPC간에 연결을 위해 Trasinc Gageway를 사용한다.
  
- vpc end point
  - instance와 AWS Resource(S3, DanamoDB 등)과 통신 시, internet을 통하지 않고 통신할 수 있게 하는 것.
  - 두 가지 유형의 앤드포인트
    - interface endpoint
      - VPC밖에 있는 Resource들을 VPC안에 있는 것 처럼
    - gateway endpoint

## Amazon Route 53
- 서로 다른 VPC나 서로 다른 region에 대한 통신을 구현할 때 사용
- DNS 서비스를 지칭
- 알고리즘
  - 라운드 로빈
    - 레코드 수만큼 로드밸런싱(2개의 서버의 가중치 기반 라운드로빈을 5:5로 주었다고 생각하면됨.)
  - 가중치 기반 라운드 로빈
    - 어떤 주소로 어떤 비율로 줄꺼냐
  - 지연 시간 기반 라우팅
  - 상태 확인 및 DNS 장애 조치
  - 지리 위치 라우팅
    - 위도경도를 보고 가장 근접한 server로 라우팅
  - 트래픽 바이어스를 통한 지리 근접 라우팅
  - 다중 값 응답

## Amazon ELB(Elastic Load Balancing)
- TLS(SSL) 가속기 역활까지 한다.
- 상태확인이 가능하다.
- 종류
  - ALB : 7계층 Load Balancer
    - 외부에서 내부로 트래픽 분산을 하는 용도로 사용
  - NLB : 4계층 Load Balancer
    - 내부에서 내부로 트래픽 분산을 하는 용도로 사용
  - CLB : VPC 이전에 EC2-Classic 네트워크라고 있었는데, 그 당시에 같이 사용하던 ELB

## Edge Location
- 단순하게 어플리케이션에 접근해서 컨텐츠를 받을 때는 사내망, 통신사망, 여러 인터넷(라우트, 게이트웨이)을 통해 resource에 접근한다.
- Edge Location은 AWS 자체 네트워크만 routing하여 여러개의 네트워크 홉을 거치는 일이 없게 함으로 굉장히 빠르게 컨텐츠를 요청/응답할 수 있다.
- Edge Location을 사용하는 AWS는 아래와 같다.
    - WAF
    - Route53
    - Shield
    - Global Accelerator
    - CloudFront

# Storage
- AWS S3
- AWS Glacier
- AWS EBS(Elastic Block Store) [=SAN]
- AWS EFS(Elastic File System)/AWS FSx [=NAS]
- AWS Storage Gateway
- AWS Import/Export
- AWS CloudFront
  
## AWS S3(Simple Shared Storage)
- 인터넷용 스토리지
- 온라인, HTTP Method 기반 Access
- 종류
  - Amazon S3 standard
  - Amazon S3 standard - Infrequent Access
  - Amazon S3 One Zone-Infrequent Access
  ```
  (요청이 많은 경우 유리)(가용성 ↑)
  - Amazon S3 standard
  - Amazon S3 standard - Infrequent Access
  - Amazon S3 One Zone-Infrequent Access
  (요청이 적을 경우 유리)(가용성 ↓)
  ```
- 물리적 저장단위
  - Bucket
- 비용
  - 데이터 량
  - 요청에 대한 비용(HTTP Method)
  - 데이터 전송비용
- Versioning
  - 성능 저하 없이 실수로 덮어쓰거나 삭제하는 것을 방지
  - 모든 업로드에 대해 새 버전을 생성합니다.
  - 요금: 버전관리를 위한 요금은 측정되지 않으나, 버전관리로 인한 객체(주로 파일)들이 쌓이면서 요금이 과금될 수 있다.

## AWS Glacier
- 저비용, 장기 저장 백업 서비스
- 장기 아카이빙 저장 서비스로써, 오랜 기간 자주 엑세스 하지 않는 서비스에 적합하다.
- 데이터 사용 시 복원이 비싸다.
  
## AWS EBS(Elastic Block Store))
- 내가 만든 인스턴스 한대의 전용으로 사용하는 Storage
- 데이터 저장공간(Volume)에 대한 요금을 측정하고, 실제로 저장된 데이터의 양으로 요금이 산정되지 않는다.
- 주로 장기간 사용하지 않을 경우 back-up본을 만들어 저장을 시켜놓는다.
- 인스턴스 하나당 EBS volume 하나를 두는걸 권고한다.

## AWS EFS(Elastic File System) 
- EFS : Linux 전용(NTFS File System)
- FSx : Windows 전용
  
- EC2 인스턴스를 위한 파일 시스템 인터페이스 및 파일 시스템 시맨틱 환경 제공
- 주요속성
  - 완전관리형
  - 파일 시스템 엑세스 시맨틱
    - 일반적인 파일 시스템과 동일하며, 읽기 후 쓰기 일관성, 파일 잠금, 계층적 디렉터리 구조, 파일 조작 명령, 세분화된 파일 명칭 부여, 파일 중간의 특정 블록에 쓰기 등 가능
  - 파일 시스템 인터페이스
    - 표준 OS API와 호환성이 유지되는 파일 시스템 인터페이스 제공.
    - 표준 OS API를 사용하는 Application이라면 EFS를 통해 기존의 파일 작업을 문제없이 처리 가능
  - 공유 파일 시스템
  - 민첩성 및 확장성
  - 고성능
  - 고가용성 및 고신뢰성
  
## AWS CloudFront
- AWS의 Global CDN(Content Delivery Networrk) Service
- SSL 지원, 접속지역 제한, Private Contents 설정 등 다양한 Service 제공

# DataBase
## 관계형 데이터베이스
  - Amazon RDS : 관리형 데이터베이스 서비스
    - 모니터링을 통해서 Instance Type의 변경이 필요한 정도를 제외하곤 거진 AWS에서 관리를 해준다.
    - 최근에는 Storage가 부족하면 Auto Scaling까지도 가능하다.
  - Amazon Aurora : Amazon에서 개발한 Database(MySQL과 PostgreSQL과 호환이 가능하며, 어떤DB와 호환용으로 만들지 선택해야한다.)
    - 선택된 리전에 서로 다른 3곳의 가용영역에 2개씩 총 6개가 만들어진다.
      - 읽기전용, 장애대응용 DB가 있다.
## 비관계형 데이터베이스
  - Amazon DynamoDB : 관리형 비관계형 데이터베이스
    - 계정 또는 리전이 달라지면, 동일한 Table Name 이더라도 다른 Table로 인식된다.
    - Global Table은 위의 상황에 대비해 어느 계정 어느 리전으로 접근해도 같은 Table로 이루어 질 수 있게 동기화된다.
    - 읽기, 쓰기 용량을 신경써야한다.(100ms 단위로 처리되지만, 초당 몇번 처리하게 할 것인지 제한을 걸 수 있다.)
    - 접근제어
      - DB자체를 관리자가 직접 컨트롤 하는게 아니기 때문에, IAM으로 서비스의 접근을 제한한다.
  - Amazon Redshift : 
  - Amazon ElastiCache : 관계형 데이터베이스 앞단에 성능을 높히기 위하여 사용(샤딩 등)
  - Amazon Neptune : 그래프 데이터를 저장하는데 최적화

# Analytic
- Amazon Athena
- Amazon EMR
- Amazon Elasticsearch
- Amazon CloudSearch
- Amazon Data Pipeline
- Amazon Kinesis
  - Amazon Kinesis Data Streams
  - Amazon Kinesis Data FireHose
  - Amazon Kinesis Data Analytics
- Amazon QuickSight

## Amazon Kinesis
### Amazon Kinesis Data Streams
- 특화된 분석 목적에 맞춰 스트리밍 데이터에 대한 실시간 분석 서비스를 제공하며 웹사이트 클릭스트림, 신용카드 사용 등 금융거래, 소셜미디어 피드, IT 로그, 위치 추적 이벤트 등 수십만 가지의 데이터 소스로부터 유입되는 테라바이트 급 데이터를 저장 및 처리할 수 있다.

### Amazon Kinesis Data FireHose
- 데이터 저장소와 분석 도구에 스트리밍 데이터를 로딩하기 위한 가장 간단한 방법을 제공하며, 스트리밍 데이터를 수집, 변환해 Amazon S3, Redshift, Elasticsearch, Splunk 등에 로딩할 수 있다.

### Amazon Kinesis Data Analytics
- 실시간성의 스트리밍 데이터를 처리 및 분석하기 위한 가장 간단한 방법이며, 표준 SQL 방식을 사용하므로 별도의 분석용 프로그래밍 언어를 학습할 필요가 없다.
- Analytics는 사용자를 대신해 SQL 쿼리 처리를 위한 지속적인 데이터 입출력 업무를 담당하며, 결과값이 나오면 지정한 대상에 전송한다.

## Amazon QuickSight
- 비즈니스 분석 서비스로 데이터 시각화, 애드 훅 분석 기능을 제공하고 인사이트를 추출 할 수 있도록 하는 완전 관리형 서비스

# Messaging
- Amazon SNS(Simple Notification Service)
- Amazon SES(Simple Email Service)
- Amazon SQS(Simple Queue Service)
  - 1개 메시지당 256KB 밖에 전달 할 수 없다. 이때는 S3에 데이터를 올려 두고, S3의 링크를 전달 해 주는 방법으로 해결할 수 있다.

# Migration
- AWS Discovery Service
- AWS Database Migration Service
- AWS Snowball
- AWS Server Migration Service

## AWS Discovery Service
- On-premise Data Center에서 실행되는 Application을 자동으로 파악하고 관련 Dependency 요소, 성능 프로필을 맵핑하기 위한 서비스

# AI
- VISION
- SPEECH
- Textract
  - 아직 한글이 지원되지 않는다.(2020. 11. 26. 기준)
- Comprehend
  - 텍스트에서 통찰력 확보 및 관계 파악(자연언어 처리기)
- SEARCH
- CHATBOTS
- PERSONALIZATION
  - 개인화 및 추천서비스
  - 세션 기반 실시간 추천을 제공
    - 사용자의 Action을 실시간으로 수집하여 추천을 제공할 수 있다.
  - 개인화 알림 제공
  - Re-Ranking 제공
- FORECASTING
  - 세계 최대 전자상거래를 지원하는 기술
  - 시계열 예측
    - 시간에 따라 값들을 예측하는 것
  - 필요한 데이터만 정의하는게 제일 어렵다.
- FRAUD
- DEVELOPMENT
- CONTA- NT CENTERS
- Amazon Rekognition
  - 이미지 및 비디오를 통해 정보를 추출하기 위해 머신러닝 적용

# ML
- Amazon SageMaker
- 머신 러닝 프로세스 리뷰
  ```console
  1. Business Problem을 ML Problem으로 전환한다.
  ```
- Auto ML
  - AutoGluon
  - AutoPilot

* 사전지식
  - Input -function(x)-> Output
    - Input : feature(s)
    - function(x) : 알고리즘
    - function(x)의 값을 구하는 과정 : 학습
    - function(x)의 값(즉 수식) : 모듈
    - Output : prediction
      
  - AI : 명시적 프로그래밍 없이도 실제 세계를 감지, 학습, 추론, 행동, 적응
    - ex> 로봇
  - ML : 학습 알고리즘을 사용해 데이터로부터 모델을 만드는 계산 방법
    - ex> 지도, 비지도, 준지도, 강화 학습
  - DL : 연속적으로 복잡한 정보를 학습하는 여러 층의 뉴론으로 구성된 뉴럴 네트워크 알고리즘
    - ex> 알파고

* Terms
  cf> tabular (테이블)행/열로 구성된 Data형태
  cf> Regression : 수치

# Account/User
- 계정(Account)
- 사용자(User)
- 정책
  - AWS 서비스에 대한 엑세스를 제어
  - OS, Application에 대한 엑세스 제어를 하지 못함
  - 거부 > 허용 순으로 확인된다.
- 역할
  - 자격증명을 발급해주는데, 유효기간이 있는 자격증명을 발급해줄 때 사용.
  - 자격증명과 정책을 연결하여서 사용자에게 부여한다.
  
- 추천: 아무런 권한이 없는 계정을 하나 만들고, 역활전환을 한 후에 cli연동을 진행한다.

## AWS CloudTrail
- AWS CloudTrail은 계정의 거버넌스, 규정 준수, 운영 및 위험 감사를 활성화하도록 도와주는 서비스입니다. 사용자, 역할 또는 AWS 서비스가 수행하는 작업들은 CloudTrail에 이벤트로 기록됩니다. 이벤트에는 AWS Management 콘솔, AWS Command Line Interface, AWS 및 SDKs에서 수행된 작업이 포함됩니다.

# AWS-CLI
## Summary
- AWS Command Line Interface(AWS CLI)는 명령줄 셸의 명령을 사용하여 AWS 서비스와 상호 작용할 수 있는 오픈 소스 도구입니다. 최소한의 구성으로 AWS CLI를 사용하면 원하는 터미널 프로그램에 있는 명령 프롬프트에서 브라우저 기반 AWS Management 콘솔에서 제공하는 것과 동일한 기능을 구현하는 명령을 실행할 수 있습니다.
- Version
    - version 2.x
    - version 1.x

## Reference
- [https://docs.aws.amazon.com/cli/index.html](https://docs.aws.amazon.com/cli/index.html)

# Calc
  * AWS Calc 참고사이트: [calculator.aws](calculator.aws)

  * IP Calc 참고사이트: [http://jodies.de/ipcalc](http://jodies.de/ipcalc)

# Certification
- https://aws.amazon.com/ko/certification

- http://bit.ly/aws-study-resource
- http://bit.ly/sacertguide
- https://www.examtopics.com/exams/amazon
    - https://www.examtopics.com/exams/amazon/aws-certified-solutions-architect-associate-saa-c02/
    - 위의 문제만 잘 이해해도 자격증은 취득할 수 있다.

