# WindowsOS


---

# WSL(Windows Subsystem for Linux)
winodws를 linux처럼 사용할 수 있도록 하는 WSL을 설치해야 한다.
docker를 windows에서 cli 환경으로 설치할 때 필요하다.

```bash
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
root@D-045522-00:/mnt/c/Users/anonymous# whoami
root
 
 
---
 
 
# WSL 배포판 삭제
C:\Users\anonymous> wsl --unregister Ubuntu-24.04
```

# UI 환경
  - window를 화면 구석으로 Drag할 경우, 자동으로 window가 구석으로 맞춰진다.
  - 이게 난 너무너무 싫타...
  ```
  [설정] > [멀티태스킹] > '창 맞춤' > "끔"
  ```
