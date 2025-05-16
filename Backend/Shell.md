# Shell

---

# Shell
- User와 Kernel간의 인터페이스 역할을 하는 모듈(ex> 명령어 해석 기능 등)
- Shell의 종류
  - Bourne Shell: 유닉스의 표준 쉘
  - Bash Shell: Linux 표준 쉘
  - C Shell
  - Korn Shell
- Shell의 확인
```console
[root@localhost ~]# echo $SHELL

또는

[root@localhost ~]# evn | grep SHELL
oracle:x:1021:1020:Oracle user:/data/network/oracle:/bin/bash
1      2 3    4    5           6                    7
--------------------------------------------
Result
  1 | Username: It is used when user logs in. It should be between 1 and 32 characters in length.
  2 | Password: An x character indicates that encrypted password is stored in /etc/shadow file. Please note that you need to use the passwd command to computes the hash of a password typed at the CLI or to store/update the hash of the password in /etc/shadow file.
  3 | User ID (UID): Each user must be assigned a user ID (UID). UID 0 (zero) is reserved for root and UIDs 1-99 are reserved for other predefined accounts. Further UID 100-999 are reserved by system for administrative and system accounts/groups.
  4 | Group ID (GID): The primary group ID (stored in /etc/group file)
  5 | User ID Info: The comment field. It allow you to add extra information about the users such as user’s full name, phone number etc. This field use by finger command.
  6 | Home directory: The absolute path to the directory the user will be in when they log in. If this directory does not exists then users directory becomes /
  7 | Command/shell: The absolute path of a command or shell (/bin/bash). Typically, this is a shell. Please note that it does not have to be a shell.
- Description
    - Shell 확인
```
  
## Description
### 큰따옴표와 작은따옴표
- 셸 스크립트에서 모든 변수값을 문자열이라 기본으로 인식하기 때문에 큰 따옴표가 딱히 필요가 없습니다.
- 그룹핑에 목적으로 많이씀
- 큰따옴표는 특수문자를 보존시켜주는데 ""보다 ''가 더 강력하게 보호해줍니다. 예를 들어 '$'라는 문자가 들어간 글자를 출력하려면 큰따옴표가 아닌 작은 따옴표로 묶어줘야한다. 요런 약간의 차이가 있지만 일반적으로는 동일하게 인식합니다.
```console
[root@localhost ~]# name=kim
[root@localhost ~]# $name
kim

[root@localhost ~]# name=\kim
[root@localhost ~]# $name
kim     //역슬래쉬가 빠짐

[root@localhost ~]# name=\kim
[root@localhost ~]# "$name"
\kim     //역슬래쉬가 빠지지 않음


[root@localhost ~]# name=\kim
[root@localhost ~]# "$name"
\kim
[root@localhost ~]# name=\kim
[root@localhost ~]# '$name'
$name
``` 

### 변수
- 타입을 설정하지 않음
- 대입연산자 좌우로 공백이 존재할 수 없음
- 영문,숫자,언더바('_') 만 사용가능
```console
variable_one=KimHyunYun    //correct
variable_one =KimHyunYun    //incorrect
variable_one= KimHyunYun    //incorrect
```

- 사용
```console
${변수명}

또는
  
$변수명
```

## Example
### auto create tag on git
```
#!/bin/bash


. ./createAutoTag_setting.sh


####################################################################################################
# Description
####################################################################################################
# Creator: HyunHyun Kim
# Date: 2021. 03. 19.
# Description:
#   git remote에서 master branch를 가져와 tag를 생성한 뒤 push까지 진행.
#   이후 jenkins의 빌드/배포를 실행한다.
#   단, 아직 exception, error처리에 대한 부분이 미흡함으로 실무에서 사용하기 부적합하다.
# Parameter
#   $1=고객사:-default $CUSTOMER(in ./createAutoTag_setting.sh)
#     형태: 고객사,고객사,고객사(구분자 ',')
#     예제: josunhotel,emoney,spharos



####################################################################################################
# Constant Define
####################################################################################################
CONSTANT_TRUE=0
CONSTANT_FALSE=1


####################################################################################################
# Variable Define
####################################################################################################
GIT_REPOSITORY_URL="https://git-codecommit.ap-northeast-2.amazonaws.com/v1/repos"
GIT_LOG_COUNT=1
GIT_DATE_PREFIX="Date:"

WORKSPACE_PATH=./cicd
NOW_DATE=$(date +%Y%m%d)
DATE_FORMAT="%Y%m%d"

LOG_PATH=$WORKSPACE_PATH/logs
LOG_EXTENSION=log
LOG_BACKUP_DATE=$(date +%Y%m%d)


####################################################################################################
# Function Define
####################################################################################################
function main() {
  $(init)

  local repositories=$(aws codecommit list-repositories | jq '.repositories | .[]')
  for repositoryName in $(echo "$repositories" | jq -r '.repositoryName'); do
    local resultForInitRepo=$(gitInitRepo "$repositoryName")

    [[ $(isProcessing "$repositoryName") != $CONSTANT_TRUE ]] && continue

    echo "$(gitTagging "$repositoryName" "$1")"
  done
}

function init() {
  # create a directory named logs
  if [ ! -d "$LOG_PATH" ]; then
    mkdir -p $LOG_PATH
  fi
}

function gitInitRepo() {
  local repositoryName="$1"
  local repositoryPath="$WORKSPACE_PATH/$1"

  if [[ ! -d $WORKSPACE_PATH/$repositoryName ]]; then
    git clone $GIT_REPOSITORY_URL/"$repositoryName" "$repositoryPath"
  fi

  git -C "$repositoryPath" checkout master
  git -C "$repositoryPath" pull
}

function isProcessing() {
  # create meta-data as log file
  local repositoryName=$1
  local repositoryPath=$WORKSPACE_PATH/$1
  local repositoryTagInfo=$(git -C "$repositoryPath" log -$GIT_LOG_COUNT --date=format:"$DATE_FORMAT")

  local logFile=$LOG_PATH/$repositoryName.$LOG_EXTENSION
  local logBackUpFile=$LOG_PATH/$(makeFileNameBySeq "$repositoryName.$LOG_EXTENSION")

  if [[ -f $logFile ]]; then
    cp -f "$logFile" "$logBackUpFile"
  else
    touch "$logBackUpFile"
  fi
  echo "$repositoryTagInfo" > "$logFile"

  # check logging file
  local crntDate=$(grep "$GIT_DATE_PREFIX" "$logFile")
  local pastDate=$(grep "$GIT_DATE_PREFIX" "$logBackUpFile")

  if [[ "$pastDate" == "" || "$crntDate" > "$pastDate" ]]; then
    echo $CONSTANT_TRUE
  else
    echo $CONSTANT_FALSE
  fi
}

function makeFileNameBySeq(){
  local fileFullName=$1
  local fileName=$(echo "$fileFullName" | sed 's/\(.*\)\..*/\1/')
  local fileSeq=$(printf "%03d" $(($(printf "%d" "$(ls -r "$LOG_PATH" | grep "$fileName-$NOW_DATE" | head -n 1 | sed 's/.*-\(.*\)\..*/\1/')") + 1)))

  echo "$fileName-$NOW_DATE-$fileSeq.$LOG_EXTENSION"
}

function gitTagging() {
  local repositoryName="$1"
  local repository=$WORKSPACE_PATH/$repositoryName
  local customers="${2:-default $CUSTOMERS}"

  for customer in $(echo "$customers" | tr ',' "\n"); do
    local oriTagName=$(git -C "$repository" ls-remote --tags origin | grep -E "$customer" | head -n 1)
    local newTagName=$NOW_DATE-"$customer"-$(printf "%03d" $(($(printf "%d" "${oriTagName##*-}") + 1)))

    git -C "$repository" tag -a "$newTagName" -m "$newTagName"
    git -C "$repository" push --tag
  done
}

####################################################################################################
# Main Process
####################################################################################################
echo "start[$(date)]"
echo "$(main "$*")"
echo "end[$(date)]"
```
