# MasOS

---

# Homebrew
## Homebrew 란?
  - macOS 용 Package 관리자
  - [참고사이트] [https://brew.sh/index_ko](https://brew.sh/index_ko)
  
### Hot to Install ?
  ```console
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  ```
  
### How to use ?
  ```console
  $ brew search zulu
  ==> Casks
  zulu11 ✔        zulu13       zulu15        zulu7        zulu8        homebrew/cask/zulu


  $ brew install zulu11
  ...


  $ brew list
  ==> Formulae
  bdw-gc		emacs		gnutls		libev		libtasn1	nettle		pcre2
  c-ares		gettext		guile		libevent	libtool		nghttp2		pkg-config
  cask		git		jansson		libffi		libunistring	openssl@1.1	readline
  coreutils	gmp		jemalloc	libidn2		m4		p11-kit		unbound

  ==> Casks
  zulu11
  ```
  
### Command
  |                         Command                        |               Describe               |              Blank              |
  |--------------------------------------------------------|------------------------------------- |---------------------------------|
  | brew install [패키지명]                                 | 패키지설치                            |                                 |
  | brew install [패키지명]                                 | 패키지설치                            |                                 |
  | brew remove --force --ignore-dependencies $(brew list) | Homebrew로 설치한 모든 패키지 일괄삭제  |                                 |
  | brew upgrade [패키지명]                                 | 패키지 Upgrade                        | 패키지명 미입력 시, 전체 업데이트 |
  | brew search [패키지명]                                  | 패키지 검색                           |                                 |
  | brew list                                              | 설치된 패키지 목록조회                 |                                 |
  | brew update                                            | Homebrew Update                      |                                 |

## Homebrew Cask 란?
  - masOS 앱, 폰트, 플로그인, 오픈소스가 아닌 소프트웨어를 설치할 수 있도록 해주는 Package
  
### How to Install ?
  ```console
  # homebrew 설치가 선행되어야 한다.
  $ brew install cask
  ```

### How to use ?
  ```console
  $ brew cask install Brackets
  ```

# Linux VM for Mac
Mac에서 Linux를 실행하려면 전체 Linux OS가 가상화되어 실행되어야 한다.
Windows에서는 WSL을 이용하여 docker를 그대로 설치하여 제약없이(eg. wsl이 결국 브릿지를 거치기 때문에 vpn등 사용시 mtu 조절이 필요할 수 있는 제약이 있음)사용 가능하다.
하지만 Mac은 Linux 스택을 그대로 사용할 수 없기때문에 VM을 반드시 띄운 후 사용해야한다.

UTM, Lima, VirtualBox, VMWare Fusion, Parallels Desktop 등 다양한 소프트웨어가 존재한다.

## UTM
macOS와 iOS에서 사용 가능한 가상화 소프트웨어로, QEMU를 기반으로 다양한 운영 체제를 가상화할 수 있습니다. 오픈소스이며, 사용자가 리눅스를 포함한 여러 OS를 가상 머신으로 실행할 수 있게 해줍니다.

## Lima
기본적으로 lima는 containerd를 실행하여 컨테이너를 관리하며, 컨테이너 생성, 시작, 중지, 이미지 가져오기 및 저장, 마운트 구성, 네트워킹 등의 역할을 한다.
Docker를 사용하는 목적이라면, 가장 인기있다. Docker 버전을 테스트 했을때 기존의 대부분의 동작들이 거의 완벽하게 호환되기때문.
```base
# lima install
hyunyukim@LM-046570-00 ~ % brew install lima

# lima 실행
hyunyukim@LM-046570-00 ~ % limactl start

# 첫 실행 시, "default"이름의 VM환경이 만들어진다.
hyunyukim@LM-046570-00 ~ % limactl list
NAME       STATUS     SSH            VMTYPE    ARCH      CPUS    MEMORY    DISK      DIR
default    Stopped    127.0.0.1:0    qemu      x86_64    4       4GiB      100GiB    ~/.lima/default

# VM 환경은 아래와 같이 중지/삭제 할 수 있다.
hyunyukim@LM-046570-00 ~ % limactl stop default
hyunyukim@LM-046570-00 ~ % limactl remove default
```

### Reference
[https://github.com/lima-vm/lima](https://github.com/lima-vm/lima)


# Containerd for Mac
Mac에서 Linux를 실행하기 위해 전체 운영 체제를 실행하는 VM for Mac 대신, 필요한 애플리케이션과 라이브러리만 격리하여 실행한다.
Mac에서 Linux 컨테이너를 실행하려면 Docker와 같은 컨테이너화 도구를 사용합니다.

Colima, minikube 등 다양한 소프트웨어가 존재한다.

## Colima
Lima를 기반으로 하여 Docker 환경을 더 사용자 친화적이고 간편하게 설정하도록 중점을 둔 소프트웨어

### docker colima
docker와 colima를 같이 사용한다.
```bash
hyunyukim@LM-046570-00 ~ % brew install docker docker-compose
hyunyukim@LM-046570-00 ~ % brew install colima

hyunyukim@LM-046570-00 ~ % colima start
```

## Minikube
Minikube는 macOS에서 Kubernetes 클러스터를 로컬로 실행할 수 있게 해주는 도구
Minikube는 Kubernetes의 컨테이너 런타임으로 containerd를 선택할 수 있는 옵션을 제공한다.

