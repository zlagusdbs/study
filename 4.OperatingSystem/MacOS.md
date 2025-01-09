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

# Containerd for Mac
Windows에서는 WSL을 이용하여 docker를 그대로 설치하여 제약없이(eg. wsl이 결국 브릿지를 거치기 때문에 vpn등 사용시 mtu 조절이 필요할 수 있는 제약이 있음)사용 가능하다.
하지만 Mac은 Linux 스택을 그대로 사용할 수 없기때문에 VM을 반드시 띄운 후 사용해야 한다.

## UTM
macOS와 iOS에서 사용 가능한 가상화 소프트웨어로, QEMU를 기반으로 다양한 운영 체제를 가상화할 수 있습니다. 오픈소스이며, 사용자가 리눅스를 포함한 여러 OS를 가상 머신으로 실행할 수 있게 해줍니다.

## Lima
기본적으로 lima는 containerd를 실행하여 컨테이너를 관리하며, 컨테이너 생성, 시작, 중지, 이미지 가져오기 및 저장, 마운트 구성, 네트워킹 등의 역할을 한다.
Docker를 사용하는 목적이라면, 가장 인기있다. Docker 버전을 테스트 했을때 기존의 대부분의 동작들이 거의 완벽하게 호환되기때문.

> =Docker Desktop for Mac

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

## Multipass
Canonical (우분투의 개발사)에서 만든 경량화된 가상 머신 관리 도구

## Bagrant

## Parallels Desktop

