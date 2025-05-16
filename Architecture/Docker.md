# Docker
- Docker
- Docker Swarm
- Docker Compose

---

# Docker
- Hypervisor
  - 기존의 가상화 기술로써 가상머신으로 구분하여 운영체제를 관리하기 때문에, Kernel, OS lv의 lib 등 불필요한 기능을 많이 내포하기 때문에 성능에 이슈가 존재한다.
- Docker
  - Hypervisor의 성능이슈 해결(새로운 OS에 대한 lib, env등을 생략할 수 있음)
  - Linux 자체기능인 chroot, cgroup, namespace 등을 사용하여, 표면적으로 독립된 가상화된 공간을 만들어 관리 할 수 있게 하는 기술(Client, Server(≒Engine))
    - chroot: root directory인 '/'를 변경하는 명령어
    - cgroup: Linux Kernel에서 CPU, Memory, DISK, Network 등의 자원을 할당하는 가상화 공간을 제공하는 명령어
    - namespace: Process tree, 사용자계정, file system, ipc 등을 묶어 HOST와 완벽하게 격리시킨 공간
- Container
  - 표면적으로는 OS자체를 가상화하였으나, 내부적으로는 OS자체를 가상화하지 않은형태(Linux자체 기능인 chroot, namespace, cgroup을 사용하여 프로세스 단위의 격리 환경을 만들어 놓은 곳)이기 때문에 Container라 지칭

## Quickstart
### Windows
- Docker는 Linux의 자체기능(chroot, cgroup, namespacce 등)을 활용한 기술이다.
- Windows에서는 바로 사용할 수 없음으로 winodws를 linux처럼 사용할 수 있도록 하는 WSL을 설치해야 한다.

#### WSL(Windows Subsystem for Linux)
- WSL(Windows Subsystem for Linux) Install
```bash
# cf. 설치를 시작하기 앞서, windows 기능 확인을 해야 할 수 있다.
#     제어판 > 프로그램 및 기능 > Windows 기능 켜기/끄기 > Hyper-V, Linux용 Windows 하위 시스템 check
# 1. WSL Install
## WSL을 실행하고, Linux를 설치하는데 필요한 기능을 사용하도록 설정.
C:\Users\anonymous> wsl --install
 
## WSL는 WSL1, WSL2가 있는데, WSL2를 사용한다.
C:\Users\anonymous> wsl --set-default-version 2
WSL 2와의 주요 차이점에 대한 자세한 내용은 https://aka.ms/wsl2를 참조하세요
 
# 2. Linux Install
## 설치 가능한 목록을 확인할 수 있다. (개인 취향에 맞는 Linux를 설치하면 된다. 본문에서는 Ubuntu를 설치)
C:\Users\anonymous> wsl --list --online
다음은 설치할 수 있는 유효한 배포 목록입니다.
'wsl --install -d <배포>'를 사용하여 설치하세요.
 
NAME                            FRIENDLY NAME
Ubuntu                          Ubuntu
Debian                          Debian GNU/Linux
kali-linux                      Kali Linux Rolling
Ubuntu-18.04                    Ubuntu 18.04 LTS
Ubuntu-20.04                    Ubuntu 20.04 LTS
Ubuntu-22.04                    Ubuntu 22.04 LTS
Ubuntu-24.04                    Ubuntu 24.04 LTS
OracleLinux_7_9                 Oracle Linux 7.9
OracleLinux_8_7                 Oracle Linux 8.7
OracleLinux_9_1                 Oracle Linux 9.1
openSUSE-Leap-15.6              openSUSE Leap 15.6
SUSE-Linux-Enterprise-15-SP5    SUSE Linux Enterprise 15 SP5
SUSE-Linux-Enterprise-15-SP6    SUSE Linux Enterprise 15 SP6
openSUSE-Tumbleweed             openSUSE Tumbleweed
 
## Ubuntu-24.04 Install
C:\Users\anonymous> wsl --install -d Ubuntu-24.04
 
## 설치된 Linux 배포판을 나열하고 각각 설정된 WSL 버전을 확인할 수 있다.
### wsl 최신버전으로 업데이트(bash 환경에서 systemctl을 사용할 수 있도록 지원한다.)
C:\Users\anonymous> wsl --update
C:\Users\anonymous> wsl -list -verbose
 
# 3. Bash Shell 설정
## windows prompt에서 bash 환경으로 진입
C:\Users\anonymous> bash
Welcome to Ubuntu 24.04.1 LTS (GNU/Linux 4.4.0-19041-Microsoft x86_64)
 
 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/pro
 
 System information as of Tue Jan  7 15:30:19 KST 2025
 
  System load:    0.52      Processes:             8
  Usage of /home: unknown   Users logged in:       0
  Memory usage:   44%       IPv4 address for eth0: 192.168.21.134
  Swap usage:     0%
 
This message is shown once a day. To disable it please create the
/root/.hushlogin file.
 
## bash sell 동작 확인
hyunyukim@D-045522-00:~$ whoami
root
 
 
---
 
# WSL 배포판 삭제
C:\Users\anonymous> wsl --unregister Ubuntu-24.04
```

#### Docker Install
```bash
# windows prompt에서 bash 환경으로 변경
C:\Users\anonymous> bash
 
hyunyukim@D-045522-00:~$ sudo apt-get update
hyunyukim@D-045522-00:~$ sudo apt-get install ca-certificates curl
hyunyukim@D-045522-00:~$ sudo install -m 0755 -d /etc/apt/keyrings
hyunyukim@D-045522-00:~$ sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
hyunyukim@D-045522-00:~$ sudo chmod a+r /etc/apt/keyrings/docker.asc
hyunyukim@D-045522-00:~$ echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
```

#### Install the Docker Packages
```bash
hyunyukim@D-045522-00:~$ sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
hyunyukim@D-045522-00:~$ docker run hello-world
Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
c1ec31eb5944: Pull complete
Digest: sha256:5b3cc85e16e3058003c13b7821318369dad01dac3dbb877aac3c28182255c724
Status: Downloaded newer image for hello-world:latest
 
Hello from Docker!
This message shows that your installation appears to be working correctly.
 
To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (amd64)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.
 
To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash
 
Share images, automate workflows, and more with a free Docker ID:
 https://hub.docker.com/
 
For more examples and ideas, visit:
 https://docs.docker.com/get-started/
 
# docker가 실행되어있지 않을 수 있다. 이때 docker를 실행하면 된다.
hyunyukim@D-045522-00:~$ sudo systemctl status docker
hyunyukim@D-045522-00:~$ sudo systemctl start docker
```

### Mac
Mac에서 Linux를 실행하려면 전체 Linux OS가 가상화되어 실행되어야 한다.  
Windows에서는 WSL을 이용하여 docker를 그대로 설치하여 제약없이(eg. wsl이 결국 브릿지를 거치기 때문에 vpn등 사용시 mtu 조절이 필요할 수 있는 제약이 있음)사용 가능하다.  
하지만 Mac은 Linux 스택을 그대로 사용할 수 없기때문에 VM을 반드시 띄운 후 사용하거나, Mac에서 Linux를 실행하기 위해 전체 운영 체제를 실행하는 VM for Mac 대신, 필요한 애플리케이션과 라이브러리만 격리하여 실행한다.  

> Linux VM for Mac(lima 등)
>> Linux 전체를 실행

> Containerd for Mac(colima 등)
>> 필요한 어플리케이션과 라이브러리만 격리하여 실행

Docker Desktop 대체제  
- lima
- colima
- Rancher Desktop
- Podman
- Minukube + Hyperkit

#### docker colima
```bash
hyunyukim@LM-046570-00 ~ % brew install docker docker-compose
hyunyukim@LM-046570-00 ~ % brew install colima

hyunyukim@LM-046570-00 ~ % colima start

hyunyukim@LM-046570-00 ~ % docker network create {네트워크이름}
hyunyukim@LM-046570-00 ~ % docker run --name {어플리케이션_별칭} --net {네트워크이름} -p 9200:9200 -d -it {이미지경로}

hyunyukim@LM-046570-00 ~ % docker exec -it -u root {어플리케이션_별칭} /bin/bash


---

# colima start 시, qemu uninstall error
hyunyukim@LM-046570-00 ~ % colima start
FATA[0000] error in config: cannot use vmType: 'qemu', error: qemu-img not found, run 'brew install qemu' to install

hyunyukim@LM-046570-00 ~ % brew install qemu

# brew install qemu error
hyunyukim@LM-046570-00 ~ % brew install qemu
Error: You are using macOS 12.
...

Error: A newer Command Line Tools release is available.
...

If that doesnt show you any updates, run:
  sudo rm -rf /Library/Developer/CommandLineTools
  sudo xcode-select --install

Alternatively, manually download them from:
  https://developer.apple.com/download/all/.
You should download the Command Line Tools for Xcode 14.2.

hyunyukim@LM-046570-00 ~ % sudo rm -rf /Library/Developer/CommandLineTools
hyunyukim@LM-046570-00 ~ % sudo xcode-select --install

## 만약 위의 명령어로도 안된다면, MacOS upgrade를 해야 한다.
## 난 MacOS 12 버전을 사용하는데 되지 않았고, upgrade 이후 15버전이 되어서야 가능했다.

# FATA[0070] error starting vm: error at 'creating and starting': exit status 1
이것은.. 혹시 터미널을 여러개 띄우면서 발생할 수 있으니.. 터미널을 모두 종료후에 하나만 재실행해서 다시 테스트해보자.
```

## Guide
### Docker [ 관리단위 : Container ]
- Docker 위치 확인
```console
# which docker
```

- Docker 실행위치 확인
```console
# ps aux | grep docker
```

- Docker Version 확인
```console
# docker -v
Dokcer version xx, build xxx
```

### Docker Image [ {저장소이름}/이미지이름:이미지버전 ]
- Docker Container를 만들기 위한 정보로써, OS 및 Application의 정보를 하나의 정보로 묶어서 관리되는 파일을 뜻한다.

### Docker HUB
- Docker Image의 원격저장소(≒ Git HUB)
  
### Docker Container
- 변천사: chroot으로 격리된 공간사용 -> LXC(LinuX Container) 도입 -> Docker 도입
  - chroot: directory만 구분하여 격리된 공간사용.
            설정이 매우 복잡.
  - LXC: group, namespace등을 활용하여, 일종의 Container(OS자체를 가상화하지 않기 때문에 Container라고 명명)
         실제 서비스를 운영하기에는 기능이 부족하였고, 추가하기도 까다로움
  - Docker: LXC를 보안하여 만든 것.
    
  - 하나의 Docker Container에는 하나의 Process만 구동시키는 것을 권장
    - ex> 'Docker Container for Web-Server' , 'Docker Container for database' 이렇게 2개의 Docker Container를 구동
    
### Docker Volume
- Docker Container의 데이터를 영속적(Persistent)데이터로 활용 
- Docker Volume은 3가지 방법을 지원한다.
  - Host Sharing
  - Host -> Volume Docker Container -> Docker Container
  - Docker Volume [권장]
    - Docker 자체적으로 관리하는 Volume을 사용
      
### Docker Network
- Docker Network Architecture
  - ![Database Server Setting](../Resource/Infra,%20Docker,%20docker%20network.png)
- Docker Network Driver
  - Bridge
  - Host
  - None
  - Container
  - Overlay
- 3th-party Network Driver(≒PlugIn)
  - weave
  - flannel
  - openvswitch

### Dockerfile
- Docker의 Build를 실행 시, 설정정보를 기재하는 파일
  
- 일반적인 Docker Image만드는 절차
  - [기본 OS Docker Image 다운] -> [Docker Container화] -> [Application 설치 및 셋팅] -> [Docker Container를 Docker Image로 변경]
- 위의 절차를 하나의 파일로 기재하여, 자동으로 Docker Image를 만드는 행위를 Docker Build라고 하며, 이때 사용하는 File을 Dockerfile이라 한다.

#### ENTRYPOINT, CMD
- ENTRYPOINT: 지정한 명령을 수행하도록 지정
- CMD: Container를 실행할 때 인자값을 주게 되면 Dockerfile에 지정된 CMD값을 대신하여 지정한 인자값으로 변경하여 실행

### Command Line Interface
- Docker Engine
```console
[root@localhost ~]# docker -v
--------------------------------------
- Command
  - docker -v
- Description
  - Docker Engine의 버전을 확인


[root@localhost ~]# docker inspect web-server
--------------------------------------
- Command
  - docker inspect [CONTAINER, IMAGE ...]
- Option
  --type: 조회 정보를 명시
- Description
    - Docker가 관리하는 Container, Images, Volume 등 Docker의 모든 구성 단위를 조회
- Example
  - # docker inspect --type image
```

- Docker Image
```console
[root@localhost ~]# docker images
--------------------------------------
- Command
  - docker images
- Description
  - Local Docker Engine에 존재하는 Docker Images 조회


[root@localhost ~]# docker pull centos:7
--------------------------------------
- Command
  - docker pull IMAGE
- Description
  - Docker HUB에서 해당 Docker Image를 Download


[root@localhost ~]# docker rmi web-server
--------------------------------------
- Command
  - docker rmi IMAGE
-f : (Force) 강제삭제
  Docker Container로 사용중인 Docker Image를 -f 옵션으로 삭제했다면, 이름만 none으로 변경된 것(이런 Docker Image를 Dangling Image라고 부름)이며 삭제되지는 않는다.
- Description
  - Docker Image를 삭제하나, Container가 종료되고 나서 실행하여야 한다.


[root@localhost ~]# docker image prune
--------------------------------------
- Command
  - docker image prune
- Description
  - dangling image들을 한번에 삭제한다.


[root@localhost ~]# docker commit \
                    -a "zlagusdbs" \
                    -m "my first commit" \
                    web-server \
                    web-server:first
--------------------------------------
- Command
  - docker commit [OPTIONS] CONTAINER [REPOSITORY[:TAG]]
- Option
  -a : (Author) 작성자를 나타내는 메타데이터를 이미지에 포함
  -m : (Message) Commit Message를 뜻하며, 이미지에 포함될 부가설명이 된다
- Description
  - web-server라는 Docker Container를 web-server:first라는 이름의 이미지로 생성


[root@localhost ~]# docker save -o centos.tar centos:7
--------------------------------------
- Command
  - docker save [OPTION] FILE_NAME IMAGE
- Option
  -o : (Output)extract 할 파일명을 입력
- Description
  - Docker Container의 커맨드, 이미지 이름, 태그 등 이미지의 모든 메타 데이터를 포함하여 하나의 파일로 추출


[root@localhost ~]# docker load -i centos.tar
--------------------------------------
- Command
  - docker load [OPTION] FILE_NAME
- Option
  -i : (Input)load 할 파일명을 입력
- Description
  - Docker Container의 커맨드, 이미지 이름, 태그 등 이미지의 모든 메타 데이터를 포함하여 하나의 파일로 추출
```

- Docker Container
```console
[root@localhost ~]# docker ps
--------------------------------------
- Command
  - docker ps
- Optaion
  -a : All Docker container 조회
  -q : Only Docker Container ID만 조회
- Description
  - 옵션을 기재하지 않을 시, 실행중인 Docker Container를 조회


[root@localhost ~]# docker create -i -t --name web-server centos:7
--------------------------------------
- Command
  - docker create IMAGE
- Option
  -i : 
  -t : 
  --name : Docker Container의 이름을 지정
- Description
  - IMAGE를 이용하여 Docker Container 생성
  - [docker pull:Docker Image가 없을 때] -> [docker create]


[root@localhost ~]# docker start web-server
--------------------------------------
- Command
  - docker start CONTAINER
- Description
  - CONTAINER를 실행


[root@localhost ~]# docker restart web-server
--------------------------------------
- Command
  - docker restart CONTAINER
- Description
  - CONTAINER를 재실행


[root@localhost ~]# docker run -i -t centos:7
--------------------------------------
- Command
  - docker run [Option] IMAGE
- Option
  -i : 
  -t : 
  -p : Port forwarding을 위한 옵션이며, [SourcePort:DesticationPort] 또는 [SourceIP:SourcePort:DestinationPort]로 기재
    ex> docker run -i -t -p 10.222.52.114:80:8080
        HOST IP인 '10.222.52.114'의 '80' Port로 진입 시, Docker Container의 '8080'Port로 Port forwarding을 진행.
  -d : '-i -t' Option이 attach 가능한 상태로 진입하도록 한다면, '-d'옵션은 Detached Mod(=백그라운드)로 진입
  -e : Docker Container 내부에서 사용하게 될 Enviroment(환경변수)를 설정
  -v :
    1. Host Sharing
      - Host의 Directory를 Docker Container의 특정 Directory로 공유받는다(≒Volume Sharing)                       //[@Docker Volume]
        ex> docker run --name volume_docker_container -v /home/database:/var/lib/mysql                       //[호스트 공유 디렉토리]:[도커 컨테이너의 디렉토리]
    2. Docker Volume Sharing
      - Docker Volume을 사용한다.
        ex> docker run --name database-server -v docker_volume:/root/                                        //[Docker Vaolume의 이름]:[Docker Container의 공유 디렉토리]
  --volumes-from: '-v'옵션을 사용하는 Docker Container의 '-v'옵션 값에 해당하는 Directory를 공유받는다                  //[@Docker Volume]
    ex> docker run --name database-server --volumes-from volume_docker_container                   //[@Docker Volume]
        Host의 '/home/database'의 Directory를 volume_docker_container가 공유받고 있기 때문에, 공유받는 TargetDirectory를 동일한 경로로 다시 공유 받는다.  
  -link[deprecated] : 다른 Docker Container를 Alias를 지정한다.
    cf> A Docker Container에서 B Docker Container로 접근하는 방법 중 NAT로 받은 IP를 사용하는 방법이 있는데, Docker Egine은 Docker Container를 시작할 때마다 내부IP를 순차적으로 재할당한다.(DHCP개념).
        매번 변경되는 DockerContainer의 IP를 관리하지 않고, 다른 Docker Container의 이름을 Alias로 지정하여 관리한다.(Docker Container Name또한 변경에 가능성이 있기에, 직접쓰지 않는다.)
    ex> docker run --name web-server -link database-server:db-srv
        db-srv라는 이름으로 database-server Docker Container에 접근할 수 있다.
    cf> deprecated 옵션이며, Docker Bridge를 사용을 권장한다.
- Description
  - 'centos:7'라는 Docker Image가 Local Docker Engine에 존재하지 않을 경우, Docker HUB에서 Docker Image를 Download받아 설치 후 Docker Container로 진입
  - [docker pull:Docker Image가 없을 때] -> [docker create] -> [docker start] -> [docker attach]
- Example
  - mysql# docker run --name mysql-demo -e MYSQL_ROOT_PASSWORD=Pa22Word -d -p 3306:3306 mysql:latest


[root@localhost ~]# docker exec web-server ls
[root@localhost ~]# docker exec -it web-server /bin/bash
[root@localhost ~]# docker exec -itu 0 web-server /bin/bash
--------------------------------------
- Command
  - docker exec [OPTIONS] CONTAINER COMMAND [ARG…]
  - docker exec -it CONTAINER 또는 CONTAINER_ID /bin/bash
  - docker exec -itu 0 CONTAINER 또는 CONTAINER_ID /bin/bash
- Description
  - 실행중인 CONTAINER에 진입
  - 컨테이터 외부에서 명령을 실행시키기 위한 것

  - CONTAINER 내부에 들어가지 않고, 실행중인 CONTAINER에 명령을 실행
  - CONTAINER 내부에 들어가서(표준 입출력을 컨테이너에 붙여서) 직접 명령 할 수 있게하는 명령어로도 사용할 수 있다.
  - CONTAINER 내부에 root user로 진입
  

[root@localhost ~]# docker attach web-server
--------------------------------------
- Command
  - docker attach CONTAINER
- Description
  - 실행중인 CONTAINER에 진입
  - 단, docker run 시 /bin/bash 옵션을 주지 않았다면, docker attach를 실행하여도 /bin/bash로 세션이 맺어지지않는다(docker run 에 의존적)
  - 그래서 난 그냥 docker exec -it 옵션으로 실행하는걸 선호한다.


[root@container ~]# exit
또는
Ctrl + D
또는
Ctrl + P, Q
--------------------------------------
- Command
  - exit
- Description
  - Ctrl + D: Docker Container를 종료하고, quit
  - Ctrl + P, Q: Docker Container를 종료하지 않고, quit


[root@container ~]# docker rm web-server
--------------------------------------
- Command
- Description
  - Docker Container를 삭제
```

- Docker Volume
```console
[root@localhost ~]# docker volume ls
--------------------------------------
- Command
  - docker volume ls
- Description
  - Docker Volume 조회


[root@localhost ~]# docker volume create  --name docker_volume
--------------------------------------
- Command
  - docker volume create
- Option
  --name : 
- Description
  - Docker Volume 생성
```

- Docker Network
```console
[root@container ~]:/# docker network ls
--------------------------------------
- Command
  - docker network ls
- Description
  - Network 목록 조회
```

# Docker Swarm
- 여러 대의 도커 서버를 하나의 클러스터로 만들어 Docker Container를 생성하는 여러 기능을 제공.
- Swarm Class과 Swarm Mode로 나뉨
  - Swarm Class(Legacy)
    - Swarm Class은 여러 대의 서버를 하나의 지점에 사용하도록 단일 접근점을 제공하는것에 초점을 맞춤
    - Docker Version 1.6 이후 사용
    - 분산 코디네이션과 에이전트 등이 별도로 실행돼야 한다.
  - Swarm Mode
    - Swarm Mode는 MSA Container를 다루기 위한 클러스터링에 초점을 맞춤
    - Docker Version 1.12 이후 사용
    - 분산 코디네이션과 에이전트 등이 엔진에 내장돼어있다.
    
  cf> 분산 코디네이션(Distributed Coordinator)
    - 분산 코디네이션이란, 여러 개의 도커 서버를 하나의 클러스터로 구성하기위해 각종 정보를 저장하고 동기화를 관리하는 기술을 뜻함.
    - 또한, 클러스터에 영입할 새로운 서버의 발견(Service Discovery), 클러스터의 설정 저장, 동기화 등 을 위한 매니저를 뜻하기도 한다.
    - etcd, zookeeper, consul 등이 대표적이다.
  
## Swarm Classic
- 생략(교재에서 생략되었다.)
  
## Swarm Mode
- Manager Node
  - 기본적으로 Worker Node를 포함하며, Worker Node를 관리하기 위한 Docker Server
  - HA를 위하여, Raft Consensus 알고리즘을 사용.
- Worker[1...N] Node
  - 실제로 Docker Container가 생성되고 관리되는 Docker Server
      
## Swarm Mode Service
- Architecture
![Swarm Mode Architecture](../Resource/Infra,%20Docker,%20docker%20swarm.png)
- Tasks and scheduling
![Swarm Mode Tasks and scheduling](../Resource/Infra,%20Docker,%20docker%20swarm%20taskAndScheduling.png)
- Service
  - Swarm Mode에서의 제어 단위
- Replica
  - Task들을 함께 묶은 정보
- Task
  - Node 안에 몇가지 기능(제어를 당하기 위한기능)과 Docker Container를 채울수 있는 Slot의 묶은 단위를 뜻하며, 채워진(Swarm Mode를 위하여 인스턴스화 된) Docker Container를 뜻하기도 한다.
- Service란
  - Swarm Mode에서 제어하는 단위
  - 명령어를 실행하면, Service에 묶인 모든 Docker Container들은 같은 명령어를 수행한다.
- Task
  - Service내에 Docker Containier를 뜻한다.
- Replica
  - Task들이 Manager Node 또는 Worker Node에 할당이 된 상태

## Command Line Interface
- Swarm Mode (명령어의 제어 단위는 Docker Container)
```console
[root@localhost ~]# docker info | grep Swarm
--------------------------------------
- Command
  - docker info
- Description
  - Docker Engine의 Swarm Mode Cluster 정보를 확인


[root@managernode ~]:/# docker node ls
--------------------------------------
- Command
  - docker node ls
- Description
  - Swarm Cluster에 등록된 Node들을 조회


[root@managernode ~]:/# docker swarm init --advertise-addr 192.168.0.100
--------------------------------------
- Command
  - docker swarm init
- Options
  --advertise-addr: Docker Server가 Manager Node에 접근할 수 있도록 IP를 noti 
- Description
  - Manager 역할을 할 서버에 Swarm Cluster를 시작


[root@managernode ~]:/# docker swarm join --token SWMTKN-1-5...
--------------------------------------
- Command
  - docker swarm join
- Options
  --token: 해당 Swarm Cluster에 추가하기 위한 비밀키
- Description
  - 새로운 Worker Node를 해당 Swarm Cluster에 추가


[root@managernode ~]:/# docker swarm join-token first-worker-node
--------------------------------------
- Command
  - docker swarm join-token NODE_NAME
- Description
  - Node의 token을 확인


[root@first-worker-node ~]:/# docker swarm leave  --force
--------------------------------------
- Command
  - docker swarm leaver
- Options
  --force: Manager Node는 해당 옵션을 추가해야만 삭제할 수 있다.
           Manager Node를 삭제하면 해당 Manager Node에 저장돼 있던 Cluster 정보도 삭제된다.(주의!)
- Description
  - Swarm Mode를 해제한다.


[root@first-worker-node ~]:/# docker swarm rm
--------------------------------------
- Command
  - docker swarm rm
- Description
  - 해제된 Swarm Mode를 삭제한다.


[root@managernode ~]:/# docker swarm promote first-worker-node
--------------------------------------
- Command
  - docker swarm promote first-worker-node
- Description
  - first-worker-node Worker Node를 Manager Node로 변경


[root@managernode ~]:/# docker swarm demote first-worker-node
--------------------------------------
- Command
  - docker swarm demote first-worker-node
- Description
  - first-worker-node Manager Node를 Worker Node로 변경
```

- 이하 K8S로 바로 넘어가며, 다루지 않음.

# Docker Compose
- 각기 다른 Application의 Docker Container를 하나의 Project처럼 다룰 수 있도록 묶을 수 있는 환경을 제공하는 것.
  ex> Web Server용 Docker Container와 DB Server용 Docker Container를 묶어서 기동시키고 down시킨다.
  
- Docker Container의 설정이 정의도니 YAML 파일을 읽어 Docker Engine을 통해 Docker Container를 생성한다.
  
## Command Line Interface
- Origin CLI
```console
[root@localhost ~]# docker run -d --name msql \
                    zlagusdbs/composetest:mysql \
                    mysqld

[root@localhost ~]# docker run -d -p 80:80 \
                    --link mysql:db --name web \
                    zlagusdbs/composetest:web \
                    apachectl -DFOREGROUND
```

- Docker Compose - docker-compose.yml
```console
version: '3.0'
services:
  web:
    image: zlagusdbs/composetest:web
    ports:
      - "80:80"
    links:
      - mysql:db
    command: apachectl -DFOREGROUND
  mysql:
    image: zlagusdbs/composetest:mysql
    command: mysqld
```

- Docker Compose CLI
```console
[root@localhost ~]# docker-compose up -d
--------------------------------------
- Command
    - docker-compose up
- Options
    -d: 
- Description
    - first-worker-node Manager Node를 Worker Node로 변경
```

- 이하 K8S로 바로 넘어가며, 자세한 사항은 다루지 않음.

# Reference
- colima: [Colima Github: https://github.com/abiosoft/colima](https://github.com/abiosoft/colima)  
- colima: [Colima Blog: https://smallsharpsoftwaretools.com/tutorials/use-colima-to-run-docker-containers-on-macos/](https://smallsharpsoftwaretools.com/tutorials/use-colima-to-run-docker-containers-on-macos/)

- Docker Swarm: [https://docs.microsoft.com/ko-kr/dotnet/architecture/containerized-lifecycle/what-is-docker](https://docs.microsoft.com/ko-kr/dotnet/architecture/containerized-lifecycle/what-is-docker)