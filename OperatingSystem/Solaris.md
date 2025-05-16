# Solaris

---


# 1. SunOS/Solaris
## 1. SunOS/Solaris Meaning
    - SunOS 4(=Solaris 1): 1990년대 초반 Sun.inc의 자체 운영체제명
    - SunOS 5(=Solaris 2): 기존의 'SunOS 4'의 상위버전으로 운영체제가 도입되고, 신규로 도입된 운영체제명을 'Solaris 2'로 사용.(이때, 기존 'SunOS 4'의 이름을 'Solaris 1'이라고 지정)
    - Solaris 2.7(=Solaris 7) : Solraris 2.5 이후의 version은 사소한 업그레이드였으나, 2.7이후로는 'Solaris 7'으로 지정
    - SunOS: 현대에 들어서 'SunOS'를 Solaris의 Kernel Version으로 해석하며, 히스토리는 아래와 같다
      - ex> Solaris 7 Kernel Version은 SunOS 5.7이라 지칭한다.
      - ex> Solaris 10 Kernel Version은 SunOS 5.10이라 지칭한다.

## 2. Architecture
    - Processor에서 사용하는 명령어 집합(=processor architecture)
      - ex> SPARC를 사용하는 Processor는 SPARC가 있다(architecture와 porcessor명이 동일)
      - ex> ADM64를 사용하는 Processor는 ADM.inc의 애슬론64, 애슬론64FX, 튜리온64 등이 존재
    - 지원 종류
      - SPARC
      - x86
      - AMD64
      - IA-32
      - EM64T
      
## 3. Command/Description
```console
[solaris:/]# uname (옵션)
-------------------------
- Command
    - uname
- Option
    -a : All 정보
    -i : Platform 정보
    -m : System Kernel Architecture 정보
    -n : Nodename(Host name) 정보
    -p : Processor(Processor type) 정보
    -r : System OS Release 정보
    -s : System OS 정보
    -v : Kernel ID 정보
    -X : 조금더 디테일 한 정보
    -S : 호스트 이름 변경
- Description
    - uname은 UnixNAME의 약자로 Unix계열에서 사용하나, Solaris에서도 사용가능합니다.(단, Solaris전용 명령어로 'isainfo'존재)
-Result
    SunOS incorp-dev21 5.8 Generic_117350-58 sun4us sparc FJSV,GPUZC-M
    ⓐ    ⓑ           ⓒ   ⓓ                ⓔ     ⓕ    ⓖ   ⓗ
    ------------------------------------------------------------------
    ⓐ -s : System(OS)
    ⓑ -n : Nodename(Host name)
    ⓒ -r : Release
    ⓓ -v : Kernel Version(ID)
    ⓔ -m : System Kernel Architecture(그외, sun4m, sun4c 등)
    ⓕ -p : Processor(Application) Architecture(그외 sparc, i686등)
    ⓖ -i : Platform
    ⓗ Banner
```

## 4. Tools
```console
#JDK Install: kernel modules에 따른 설치방법
- Solaris version 별, 32bit/64bit 지원상황
    - Solaris x.x~5.6: 32bit 지원
    - Solaris 5.7~x.x: 32bit/64bit 지원

- 32-bit i586 kernel modules
    - 32비트: jdk-6u33-solaris-i586.tar.Z
- 64-bit amd64 kernel modules
    - 32비트: jdk-6u33-solaris-i586.tar.Z
    - 64비트: jdk-6u33-solaris-x64.tar.Z

- 32-bit sparc kernel modules
    - 32비트: jdk-6u33-solaris-sparc.tar.Z
- 64-bit sparcv9 kernel modules
    - 32비트: jdk-6u33-solaris-sparc.tar.Z
    - 64비트: jdk-6u33-solaris-sparcv9.tar.Z

- checking jdk version
    - sparcv: https://docs.oracle.com/cd/E63395_01/html/E63331/grrxn.html

<jdk 1.6 설치방법-64비트 SPARC로 설명: 설치방법은 파일명만 틀릴 뿐 동일>
#32비트 추가 설치
[root] /home/jdk6/32bit > gunzip jdk-6u33-solaris-sparc.tar.Z
[root] /home/jdk6/32bit > tar xvf jdk-6u33-solaris-sparc.tar
[root] /home/jdk6/32bit > pkgadd -d . SUNWj6rt SUNWj6dev SUNWj6cfg SUNWj6man SUNWj6jmp 
[root] /home/jdk6/32bit > /usr/jdk/jdk1.6.0_33 위치에 설치 됩니다

#64비트 추가 설치
[root] /home/jdk6/64bit > gunzip jdk-6u33-solaris-sparcv9.tar.Z
[root] /home/jdk6/64bit > tar xvf jdk-6u33-solaris-sparcv9.tar
[root] /home/jdk6/64bit > pkgadd -d . SUNWj6rtx SUNWj6dvx

#설치된 디렉토리로 이동해서 버전 및 64비트 확인
[root] / > cd /usr/jdk/jdk1.6.0_33/bin
[root] /usr/jdk/instances/jdk1.6.0/bin > ./java  –version
java version "1.6.0_33"
Java(TM) SE Runtime Environment (build 1.6.0_33-b04)
Java HotSpot(TM) Server VM (build 20.8-b03, mixed mode)
```
---
