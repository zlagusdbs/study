# Kubernetes

---

# According to
마르코 룩샤, 강인호,황주필,이원기,임찬식 옮김., 『쿠버네티스 인 액션』, 위키북스(2020)

# 1. 쿠버네티스 소개
## 1.3. 쿠버네티스 소개
### 1.3.2.넓은 시각으로 쿠버네티스 바라보기
- 쿠버네티스 핵심 이해
  - 시스템은 마스터 노드와 워커 노드로 구성된다.
  - 개발자가 애플리케이션 매니페스트를 마스터에 게시하면 쿠버네티스는 해당 애플리케이션을 워커 노드 클러스터에 배포한다.

### 1.3.3. 쿠버네티스 클러스터 아키텍처 이해
> 11장에서 더욱 상세하게 설명한다.

- 컨트롤 플레인(=마스터 노드): 클러스터를 제어하고 작동시킨다.
  - API 서버: 사용자, 컨트롤 플레인 구성 요소와 통신한다.
  - 스케줄러: 애플리케이션의 배포를 담당
  - 컨트롤러 매너저: 구성 요소 복제본, 워코 노드 추적, 노드 장애 처리 등과 같은 클러스터단의 기능을 수행
  - Etcd: 클러스터 구성을 지속적으로 저장하는 신뢰할 수 있는 분산 데이터 저장소
- 노드(=워커 노드)
  - Kubelet: API 서버와 통신하고 워커노드의 컨테이너를 관리
  - Kube-Proxy: 애플리케이션 구성 요소 간에 네트워크 트래픽을 로드밸런싱

# 2. 도커와 쿠버네티스 첫걸음
Docker
> [Docker.md](Docker.md) 참조

Kubernetes Cluster
> [Kubernetes.md](Kubernetes.md) 참조

# 3. 파드: 쿠버네티스에서 컨테이너 실행
## 3.1. 파드 소개
- 함께 배치된 컨테이너 그룹을 뜻하며, 쿠버네티스의 기본 빌딩 블록이다.
- 단, 하나의 파드에는 하나의 컨테이너만 포함하는 것이 일반적.

### 3.1.2. 파드 이해하기
- 파드의 모든 컨테이너는 동일한 네트워크 네임스페이스와 UTS 네임스페이스(=UNIX Timesharing System Namespace: 즉, 호스트 이름)안에서 실행되기 때문에, 모든 컨테이너는 같은 호스트 이름과 네트워크 인터페이스를 공유(즉, 동일한 IP와 동일한 포트 공간을 공유한다는 것)
- 단, 파일시스템에서는 사정이 다르다. 대부분의 컨테이너 파일 시스템은 컨테이너 이미지에서 나오기 때문에, 기본적으로 파일 시스템은 다른 컨테이너와 완전히 분리되어 쿠버네티스의 볼륨 개념을 이용해 파일 디력터리를 공유한다.

## 3.2. YAML 또는 JSON 디스크립터로 파드 생성
```console
[root@kim ~]# $ kubectl create -f kubia-manual.yaml

[root@kim ~]# $ kubectl get po
--------------------------------------
  - Options
      --show-labels: kubectl gt pods 명령은 레이블을 표시하지 않는 것이 기본값이라 해당 옵션을 이용해 볼 수 있다.
```

```yaml
# kubia-manual.yaml
apiVersion: v1
kind: Pod
metadata:
  name: kubia-manual-v2
  labels:
    creation_method: manual
    env: prod

spec:
  containers:
    - image: luksa/kubia
  dnsPolicy: ClusterFirst
  
status:
  conditions:
    - lastProbeTime: null
  containerStatuses:
    - containerId: docker://f027...
```
- apiVersion: 디스크립터는 쿠버네티스 API 버전 v1을 준수한다는 뜻
- metadata: 이름, 네임스페이스, 레이블 및 파드에 관한 기타 정보를 포함
- spec: 파드 컨테이너, 볼륨, 기타 데이터 등 파드 자체에 관한 실제 명세
- status: 파드 상태, 각 컨테이너 설명과 상태, 파드 내부 IP, 기타 기본 정보 등 현재 실행 중인 파드에 관한 현재 정보를 포함한다.

## 3.3. 레이블을 이용한 파드 구성
### 3.3.1. 레이블 소개
- 레이블은 파드 뿐만 아니라 모든 다른 쿠버네티스 리소스를 조직화 할 수 있는 단순하면서 강력한 쿠버네티스 기능
- 리소스에 첨부하는 키-값 쌍으로, 이 쌍은 레이블 셀럭터를 사용해 리소스를 선택할 때 활용된다.

## 3.6 파드에 어노테이션 달기
- 어노테이션은 레이블과 마찬가지로 키-값 쌍으로 거의 비슷하지만, 식별 정보를 갖지 않는다는 차이점을 보인다.
- 레이블은 오브젝트를 묶는데 사용할 수 있지만, 어노테이션은 그렇게 할 수 없다.
- 레이블은 레이블 셀렉터를 통해서 오브젝트를 선택하는 것이 가능하지만 어노테이션은 어노테이션 셀렉터와 같은 것은 없기 때문이다.

- 파드나 다른 API 오브젝트에 설명을 추가해 두어, 다른 사람이 개별 오브젝트에 관한 정보를 신속하게 찾아 볼 수 있게 하는 용도로 사용.
```console
[root@kim ~]# $ kubectl annotate pod kubia-manual mycompanycom/someannotation="foo bar"
      
[root@kim ~]# $ kubectl describe pod kubia-manual
...
metadata:
  annotations: mycompanycom/someannotation="foo bar"
...

```

## 3.7. 네임스페이스를 사용한 리소스 그룹화
- C의 NameSpace, Java의 Package 개념이라..패쓰..

## 3.8. 파드 중지와 제거
- 파드이름, 레이블 셀렉터, 네임스페이스 등으로 파드를 중지하거나 삭제하는 방법을 기재했다.
- 이것은 공식문서 또는 구글링 등으로 그때그때 찾아서 실행하자.. 일단 내가 직접 작업할 일은 없을거 같아 패쓰.

# 4. 레플리케이션과 그 밖의 컨트롤러: 관리되는 파드 배포
## 4.1. 파드를 안정적으로 유지하기
### 4.1.1. 라이브니스 프로브 소개
- 라이브니스 프로브는 파드의 스펙에 지정할 수 있다.
- 쿠버네티스는 라이브니스 프로브를 통해 컨테이너가 살아 있는지 확인할 수 있다.
- 쿠버네티스는 주기적으로 프로브를 실행하고 프로브가 실패할 경우 컨테이너를 다시 시작한다.

> 5장에서 레디니스 프로브를 배울 것이다. 두 가지를 혼돈하지 않도록 주의하자. 이 둘은 쓰임새가 다르다.

```yaml
# kubia-liveness.yaml
apiVersion: v1
kind: Pod
metadata:
  name: kubia-liveness

spec:
  containers:
    - image: luksa/kubia-unhealty  # 문제를 포함한 이미지
      name: kubia
      livenessProbe:  # liveness probe 설정
        httpGet:
          path: /healty
          port: 8080
```

## 4.2. 레플리케이션컨트롤러 소개
- 레플리케이션 컨트롤러는 파드가 항상 실행되도록 보장한다.
- 즉, 어떤 이유에서든 파드가 사라지면, 이를 감지해 새로운 파드를 교체생성한다.

### 4.2.1. 레플리케이션컨트롤러의 동작
- 컨트롤러 조정 루프 소개
  - 정확한 수의 파드가 항상 레이블 셀렉터와 일치하는지 확인(반복하여 실행)
- 레플리케이션컨트롤러의 세 가지 요소
  - 파드 셀렉터: 레이블 셀럭테와 같이 파드를 구별 할 수 있는 키-값을 지정
  - 레플리카: 실행할 파드의 의도하는 수
  - 파드 템플릿: 새로운 파드 레플리카를 만들 때 사용

```yaml
# kubia-rc.yaml
apiVersion: v1
kind: ReplicationController
metadata:
  name: kubia

spec:
  selector:     # 파드셀렉터
    app: kubia
  replias: 3    # 레플리카

template:       # 파드 템플릿
  metadata:
    lables:
      app: kubia
  spec:
    containers:
      - name: kubia
        image: luksa/kubia
        ...
```

- 레플리케이션컨트롤러가 생성한 파드라도 레플리케이션컨트롤러와 묶이지 않고, 단지 레플레키이션컨트롤러는 레이블 셀렉터와 일치하는 파드만을 관리한다는 뜻.

> 이하 레플리케이션컨트롤러가 관리하는 파드에 레이블을 추가하거나, 관리되는 파드의 레이블 변경 등을 기재.

## 4.3. 레플리케이션컨트롤러 대신 레플리카셋 사용하기
### 4.3.1. 레플리카셋과 레플리케이션컨트롤러 비교
- 레플리케이션컨트롤러: 반드시 레이블 셀렉터를 통해 파드를 매칭
- 레플리카셋: 레이블이 없는 파드나 레이블 값과 상관없이 특정 레이블의 키를 갖는 파드를 매칭할 수 있음

> 레플리카셋은 레플리케이션컨트롤러의 동작은 동일하지만, 좀 더 풍부한 표현식이 가능하다는 장점이 있다.

```yaml
# kubia-replicaset.yaml
apiVersion: apps/v1beta2  # 레플리카셋은 v1 API에 속하지 않고, API 그룹 apps, 버전 v1beta2에 속하기 때문에 변경이 필요.
kind: ReplicaSet
metadata:
  name: kubia

spec:
  selector:       # 파드셀렉터
    matchLables:  # 레플리케이션컨트롤러와 유사한 간단한 matchLabels 셀렉터를 사용한다.
      app: kubia
  replias: 3      # 레플리카

template:         # 파드 템플릿
  metadata:
    lables:
      app: kubia
  spec:
    containers:
      - name: kubia
        image: luksa/kubia
        ...
```

## 4.4. 데몬셋을 사용해 각 노드에서 정확히 한 개의 파드 실행하기
- 레플리카셋은 무작위로 워커노드에 파드를 생성(즉, 첫번째 워커노드에 2개, 두번째 워커노드에 1개, 세번째 워커노드에 0개 이런식)하지만
  데몬셋은 반드시 하나의 노드에 하나의 파드를 생성한다.(즉, 첫번째 워커노드에 1개, 두번째 워커노드에 1개, 세번째 워커노드에 1개)
- 레플리카셋은 클러스터 전체에서 무작위로 파드를 분산시키지만, 데몬셋은 각 노드에서 하나의 파드 복제본만 실행한다.

## 4.5. 완료 가능한 단일 태스크를 수행하는 파드 실행
### 4.5.1. 잡 리소스 소개
- 잡 리소스를 통해, 파드의 컨테이너 내부에서 실행 중인 프로세스가 성공적으로 완료되면 컨테이너를 다시 시작하지 않는 파드를 실행할 수 있다.

> 이것은 현재 재직중인 회사(지마켓)에서도 사용하고 있음으로 패쓰..

# 5. 서비스: 클라이언트가 파드를 검색하고 통신을 가능하게 함
## 5.2. 클러스터 외부에 있는 서비스 연결
### 5.2.1. 서비스 엔드포인트 소개
- 서비스는 파드에 직접 연결되지 않는다. 대신 엔드포인트 리소스가 그 사이에 있다.
  - 서비스의 파드 셀렉터는 엔드포인트 목록을 만드는데 사용된다.
```console
[root@kim ~]# $ kubectl describe svc kubia
Name: kubia
Namespace: default
Labels: <none>
Selector: app=kubia                                           # 서비스의 파드 셀렉터는 엔드포인트 목록을 만드는데 사용된다.
...
Endpoints: 10.108.1.4:8080,10.108.2.5:8080,10.108.2.6:8080    # 서비스의 엔드포인트를 나타내는 파드 IP와 Port 목록
```

### 5.2.2. 서비스 엔드포인트 수동구성

```yaml
# external-service.yaml
apiVersion: v1
kind: Service
metadata:
  name: external-service    # 엔드포인트 오브젝트 이름와 일치해야 한다.(바로 다음에 오는 yaml)

spec:                       # spec 하위 항목에 selector는 정의하지 않은것을 봐야한다.
  ports:
    - port: 80
```

```yaml
# external-service-endpoint.yaml
apiVersion: v1
kind: Service
metadata:
  name: external-service    # 서비스 오브젝트 이름와 일치해야 한다.(바로 다음에 오는 yaml)

subsets:
  - addresses:
      - ip: 1.1.1.1
      - ip: 2.2.2.2
      ports:
        - port: 80
```

## 5.3. 외부 클라이언트에 서비스 노출
- 쿠버네티스 클러스터의 외부에서 클라이언트가 파드로 직접 요청하는 경우를 뜻한다.

> 사내에서 같은 내부망을 사용하지만, Namespace가 다르거나 다른 모놀리식 시스템에서 쿠버네티스 클러스터로 요청을 보내고자 할 때 사용한다.

### 5.3.1. 노드포트 서비스 사용
### 5.3.2. 외부 로드밸런서로 서비스 노출

## 5.4. 인그레스 리소스로 서비스 외부 노출
> 완전한 외부에서 쿠버네티스 클러스터 시스템을 사용하고자 할 때 사용한다.

## 5.5. 파드가 연결을 수락할 준비가 됐을 때 신호 보내기
### 5.5.1. 레디니스 프로브 소개
- 라이브니스 프로브는 실패 시, 파드를 재시작하지만, 레디니스 프로브는 실패 시, 엔드포인트 오브젝트에서 제거될 뿐이다.
- 즉, 네트워크에 집중한다는 의미.

## 5.6. 헤드리스 서비스로 개별 파드 찾기
- 일반적으로는 클라이언트가 DNS로 조회하면 clusterIP를 반환한다.
- 하지만 서비스에 대한 DNS 조회를 수행했을 때, 헤드리스 서비스를 이용하여 클러스터 IP대신 개별 파드의 IP들을 반환하도록 할 수 있다.

### 5.6.1. 헤드리스 서비스 생성
Service의 spec 항목에 clusterIP 필드를 None으로 설정하면 서비스가 헤드리스 상태가 된다.
```yaml
# kubia-svc-headless.yaml
apiVersion: v1
kind: Service
metadata:
  name: kubia-headless

spec:
  clusterIP: None       # Service의 spec에 clusterIP 필드를 None으로 설정하면 서비스가 헤드리스 상태가 된다.
  ports:
    - port: 80
``` 

### 5.6.2. DNS로 파드 찾기
headless Service의 경우 pod들의 IP들을 반환한다. 즉, headless Service가 아닌 경우 clusterIP를 반환한다.
```console
[root@kim ~]# $ kubectl exec dnsutils nslookup kubia-headless
...
Name: kubia-headless.default.svc.cluster.local
Address: 10.108.1.4
Name: kubia-headless.default.svc.cluster.local
Address: 10.108.2.5
```

# 6. 볼륨: 컨테이너에 디스크 스토리지 연결
- emptyDir: 일시적인 데이터를 저장하는 데 사용되는 간단한 빈 디렉터리
- hostPath: 워커 노드의 파일시스템을 파드의 디렉터리로 마운트하는 데 사용한다.
- gitRepo: 깃 리포지터리의 콘텐츠를 체크아웃해 초기화한 볼륨
- nfs: NFS 공유를 파드에 마운트한다.
- PV(persistent volume) / PVC(persistent volume claim)
  - PV: 관리자가 크기와 지원 가능한 접근 모드를 설정한 영역
  - PVC: 사용자가 사용할 최소 크기와 필요한 접근 모드를 설정한 영역으로, 이 정보를 바탕으로 PV에 바인딩을 요청한다.

> 이후 PV와 PVC 설정하는 방법과, 동적할당등에 대한 설명

# 7. 컨피그맵과 시크릿: 애플리케이션 설정

## 7.4. 컨피그맵으로 설정 분리
쿠버네티스의 설정 옵션을 컨피그맵이라 부르는 별도 오브젝트로 분리하여 사용한다.

> 컨피그맵에 대한 추가 소개와 설정등을 기재한다.

## 7.5. 시크릿으로 민감한 데이터를 컨테이너에 전달
쿠버네티스의 보안이 유지돼야 하는 설정(자격증명, 개인 암호화 키 등)을 보관하고 배포하기 위하여 사용한다.

> 시크릿에 대한 추가 소개와 설정등을 기재한다.

# 8. 애플레키엣녀에서 파드 메타데이터와 그 외의 리소스에 액세스하기

# 9. 디플로이먼트: 선언적 애플리케이션 업데이트

# 10. 스테이트풀셋: 복제된 스테이트풀 애플리케이션 배포하기

# 11. 쿠버네티스 내부 이해
![kubernetes Architecture](../Resource/Infra,%20Kubernetes,%20architecture.png)

---

이하 DevOps 관리자 영역으로 하기 영역은 학습하지 않는다.

# 12. 쿠버네티스 API 서버 보안

# 13. 클러스터 노드와 네트워크 보안

# 14. 파드의 컴퓨팅 리소스 관리

# 15. 파드와 클러스터 노드의 오토스케일링

# 16. 고급 스케쥴링

# 17. 애플리케이션 개발을 위한 모범 사례

# 18. 쿠버네티스의 확장
