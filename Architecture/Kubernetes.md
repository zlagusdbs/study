# Kubernetes

---

# Kubernetes
- Kebernetes는 모든 Resource를 Object로 관리

## Installer
- kubeadm(실무 작업 시, 권장)
- minikube(학습 시, 권장)
  - 로컬에서 쿠버네티스를 테스트하고 애플리케이션을 개발하는 목적으로 단일 노드 클러스터를 설치하는 도구
- K8S in Docker for MAC/Windows
- kubespray
- kops
- EKS, GKE 등의 Managed Service
  
### kubeadm
- Kubernetes 저장소 추가
```console
[root@localhost ~]# curl -s https://packages.cloud.google.com/apt/doc/apt-doc-apt-key.gpg | apt-key add -
                  cat <<EOF > /etc/apt/sources.list.d/kubernetes.list
                  def http://apt.kubernetes.io/ kubernetes-xenial main
                  EOF
```
  
- kubeadm 설치
  - Docker 설치
  ```console
  [root@localhost ~]# wget -q0- get.docker.com | sh
  ```
    
  - Kubernetes 설치(최신버전)
  ```console
  [root@localhost ~]# apt-get install -y kubelet kubeadm kebectl kubernetes-cni
  ```
    
  - Kubernetes 설치(특정버전)
  ```console
  [root@localhost ~]# apt-get install -y kubelet=1.13.5-00 kubeadm kubectl kubernetes-cni
  ```
    
- Kubernetes Cluster Initialization
```console
[root@kubernetes-master ~]# kubeadm init --kubernetes-version 1.13.5
                            --apiserver-advertise-address 172.31.0.100 \
                            --pod-network-cidr=192.168.0.0/16
  --------------------------------------
  - Options
      --kubernetes-version : kubernetes의 특정버전을 설치(kubelet을 특정버전으로 설치 후, version을 맞출 때 사용)
      --apiserver-advertise-address : 다른 노드가 마스터에 접근할 수 있는 IP주소를 기재
                                    : 예> 다른 노드가 kube-master호스트에 접근할 수 있는 IP주소가 172.31.0.100
      --pod-network-cidr : kubernetes에서 사용할 컨테이너의 네트워크 대역
                         : 192.168.0.0/16은 calico.yaml의 기본 IP대역이다.(변경 시, 차후 calico.yaml내 대역을 변경해야 한다.)
  - Description
      - 
```

- kubernetes-master와 kubernetes-worker 들간의 결합
```console
[root@kubernetes-worker1 ~]# kubeadm join 172.31.0.100:6443 --token aaa.bbb.ccc~~~

[root@kubernetes-worker2 ~]# kubeadm join 172.31.0.100:6443 --token aaa.bbb.ccc~~~

[root@kubernetes-worker3 ~]# kubeadm join 172.31.0.100:6443 --token aaa.bbb.ccc~~~
  --------------------------------------
  - Command
      - kubernetes-workerN 각각에 대해서, 위의 명령어를 실행하여 붙여준다.
```

## Command
- kubeadm: kubernetes를 설치하거나, master에 worker를 조인할 때 사용.
- kubectl: master에서 worker로 일괄명령을 내릴 때
- kubernetes-cni: Kubernetes의 Container간 통신을 위해, 네트워크를 연결해주는 명령어
- kubelet: container의 생성, 삭제, master와 worker간의 통신 역할을 담당하는 Agent

## Cluster
![kubernetes Architecture](../Resource/Infra,%20Kubernetes,%20architecture.png)
  
### Namespace

### Label / Label Selector
- Label
  - POD뿐만 아니라, 다른 쿠버네티스 리소스를 조직화(Grouping)할 수 있다.
  - Key-Value Pair로 관리한다.
- Label Selector
  - 적용된 Label을 검색하여 선택할 수 있게 하는 모듈로써, 사용자는 kubectl의 명령어의 옵션을 이용하여 찾거나 어떠한 명령(작업)을 이행할 수 있다.
  ```console
  [root@kubernetes-master ~]# kebectl get pods -l sampleLabel=backend
  --------------------------------------
  - Command
      - Kubernetes에 등록된 모든 POD들을 검색하되, label이 sampleLabel=backend인 POD만 검색
  ```
    
### Annotation
- Label과 같이 key-value pair로 관리되지만, 식별 정보를 갖지 않으며(Object들을 묶지 못한다는 뜻), Selector도 없다.(검색은 된다. 단, Object가 선택되어 어떠한 작업을 이행 할 수 없는 상태라는 것이다.)
- 반면, Label과 차이점은 훨씬 더 많은 정보를 보유할 수 있다. 주로 프로그래밍에 주석처럼 많이 사용한다.
- 사용예시: Object를 만들 때, 만든사람의 이름, 작업내용 등을 기재
  
### Container

#### Image

#### Runtime Class

#### Environment Variable

### Workloads
#### POD
- Kubernetes의 관리단위
- POD는 Container들을 묶은 Resource로 포현되지만, 1:1의 관계를 권장한다.
  - Container는 단일 Process를 실행하는 것을 목적으로 한다. 단, Process가 Child-Process를 실행 할 수 있기 때문에 여러 Process를 묶는 단위로 표현된다.
  
- tip> 동일한 POD = 복제된 POD = Replica
```console
...
spec:
  template:
    # 여기서부터 파드 템플릿이다
    spec:
      containers:
      - name: hello
        image: busybox
        command: ['sh', '-c', 'echo "Hello, Kubernetes!" && sleep 3600']
      restartPolicy: OnFailure
    # 여기까지 파드 템플릿이다
```
  
#### Probe
##### liveness probe
- Container의 동작 여부를 확인.
- Probe가 패한 경우에 Container가 재시작 되길 원하는 경우 사용.
```console
...
spec:
  containers:
    livenessProbe:
    httpGet:
      path: /
      port: 8080
...
```

##### readiness probe
- Container가 요청을 처리할 준비가 되어는지 여부를 확인.
- Probe가 성공한 경우에만 POD에 트래픽 전송을 원하는 경우 사용.

##### startup probe
- Container의 Process 시작 여부를 확인.

#### Controller
##### Replication Controller
- POD가 항상 실행되도록 보장해주는 Resource.
- 조정 Loop
  1. 시작
  2. Label Selector와 매치되는 파드를 찾음
  3. 매치되는 POD수와 의도하는 파드 수 비교
  4. POD의 추가 또는 삭제 이행
  5. (1)로 이동
  
* tip> replica(=복제본)
  
##### ReplicaSet
- 차세대 Replication Controller
- 일반적으로는 직접 ReplicaSet을 구성하지 않으며, Deployment Resource를 생성할 때, 자동으로 생성되게 한다.
- Replication Controller와 차이점은 POD Selector를 지니고 있다는 점.
  - Label이 없거나, Label Value 아닌 Label Key를 갖는 POD들을 매칭시킬 수 있다는 뜻.
  
##### Deployment

##### StatefulSet

##### DaemonSet
- 모든 노드 또는 특정 노드들에 대해 정확히 하나의 복제된POD(Replica)만 존재할 수 있도록 관리하는 Object
- 노드의 수만큼 POD를 만들고 각 노드에 배포
- ex> 시스템 수준의 작업을 수행하는 인프라 관련 POD들의 경우가 있다. 
```console
apiVersion: apps/v1beta2
...
kind: DaemonSet
spec:
  selector:
    matchLabels:
      app: 
  template:
    metadata:
      labels:
    spec:
      nodeSelector:
        라벨명: 라벨값
      containers:
      - name: main
      image: 
...
```

### NetWorking
- Addon : 특정 프로그램의 기능을 보강하기 위해 추가된 프로그램
- Network Addon : 네트워크연결을 보안하기 위한 프로그램
- Kubernetes tools의 특장점만을 정리해 놓은 site
    - https://kubedex.com/kubernetes-network-plugins/
- 종류
    - flannel
    - weaveNet
    - calico

- install with calico
```console
[root@kubernetes-master ~]# kubectl apply -f https://docs.projectcalico.org/v3.8/manifests/calico.yaml
--------------------------------------
- Command
    - 
```

- install check
```console
[root@kubernetes-master ~]# kubectl get pods --namespace kube-system
--------------------------------------
- Command
    - Kubernetes 핵심 컴포넌트들의 실행 목록을 확인

[root@kubernetes-master ~]# kubectl get nodes
--------------------------------------
- Command
    - Kubernetes에 등록된 모든 node를 확인
```

#### Service
- 여러개의 Deployment를 하나의 완벽한 애플리케이션으로 연동할 수 있는 방법을 가능토록 한 Resource
- 즉, Deployment를 발견하고 Deployment들의 내부에 있는 POD들에 내부적으로 접근할 수 있도록 하는 Resource

##### 종류
- ClusterIP
    - Kubernetes 내부에서만 POD들에 접근할 때 사용

- NodePort
    - 외부에서 사용가능하지만, 모든 node의 특정 Port를 개방해 서비스에 접근하는 방식
    - Docker Swarm Mode에서 Container를 외부에 노출하는 방식과 같다고 보면된다.(운영에 적합하지 않음.)

- LoadBalencer
    - LoadBalencer를 동적으로 생성하는 기능을 제공하는 환경(AWS, GCP 등 Cloud환경)에서만 사용가능.

#### Service Topology

#### End-Point Slice

#### Service 및 POD의 DNS

#### Ingress Controller

#### Ingress
- 사전적: 외부에서 내부로 향하는 것을 지칭
- K8S: 외부 요청을 어떻게 처리할 것인지 네트워크 7계층 레벨에서 정의하는 오브젝트

##### 기능
- 외부 요청의 라우팅: 특정 경로로 들어온 요청을 어떠한 서비스로 전달할지 정의하는 라우팅 규칙을 설정할 수 있음
- 가상 호스트 기반의 요청 처리: 같은 IP에 대해 다른 도메인 이름으로 요청이 도착했을 때, 어떻게 처리할 것인지 정의
- SSL/TLS 보안 연결 처리: 여러 개의 서비스로 요청을 라우팅할 때, 보안 연결을 위한 인증서를 적용
- Ingress를 사용하지 않는 경우, Service를 통한 방법이 있는데, Service를 Deployment 수만큼 생성해야 한다. 이 자체는 Igress를 써도 동일하지만
  Service 각각에 설정을 하는 것을 Ingress를 통하여 통합적으로 관리할 수 있다.

##### 구조
- Ingress: 요청을 처리하는 규칙을 정의하는 선언적 오브젝트
  ```console
  [root@kubernetes-master ~]# kubectl get ingress
  --------------------------------------
  - Command
      - Kubernetes에 등록된 모든 Ingress를 확인

  [root@kubernetes-master ~]# kubectl apply -f ingress-example.yaml
  --------------------------------------
  - Command
      - 사전에 'ingress-example.yaml'을 생성 후 명령어 실행 시, 해당 정책을 반영한 ingress가 생성된다.
  ```

- Ingress Controller Server: 실제 외부 요청을 받아들이며, Ingress 규칙을 로드해 사용.
    - NGinX, Kong 등 존재.
  ```console
  [root@kubernetes-master ~]# kubectl apply -f \
  https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/mandatory.yaml
  --------------------------------------
  - Command
      - Ingres Controller를 설치
  - Options
      -f : NginX Ingress Controller는 Kubernetes에서 공식적으로 개발되고 있기 때문에, 설치를 위한 YAML 파일을 공식 깃허브 저장소에 직접 내려받을 수 있다.
  ```

### Storage
Persistent Volume / Persistent Volume Claim
- Local Volume
    - hostPath: Host와 Volume을 공유
    - emptyDir: POD의 Container들 간에 Volume을 공유
- Network Volume
    - On-Premise: NFS, iSCSI, GlusterFS, Ceph 와 같은 볼륨들이 존재
    - Cloud: EBS(Elastic Block Store), GCP(GcePersistentDisk) 와 같은 볼륨들이 존재
- PV / PVC
    - POD가 Volume의 세부적인 사항을 몰라도 볼륨을 사용할 수 있도록 추상화해주는 역활을 담당.
    - 즉, POD를 생성하는 YAML입장에서 네트워크 볼륨이 NFS인지, AWS의 EBS인지 상관없이 볼륨을 사용할 수 있도록 하는 것이 핵심 아이디어.
      -> Volume의 YAML을 다른 곳에 배포할 때, Network Volume의 특정 볼륨을 선정해서 썻다면, 해당 YAML은 Network Volume의 특정 볼륨만 사용가능하다.

### Configuration

### Security

### Scheduling / Eviction

### Job

### Garbage Collection
