# Auto CI/CD

---


# Auto CI/CD

## Jenkins by git branch change log
### pipeline
- scheduling: cron
- architecture: parallel
- process: git change log분석(with shell)후 build(with shell)진행.
           빌드는 기존의 jenkins item을 원격호출하는 방식

```console
pipeline {
    agent any

    triggers {
        // MINUTES(0-59) HOURS(0-23) DAYMONTH(1-31) MONTH DAYWEEK(0-7)
        cron('0 10 * * 1,2')
    }

    environment {
        SHELL_PATH = './../cicd/bin'

        CONSTANT_SUCCESS = "0"

        CUSTOMER = "Spharos"
        BASE_IMAGE = "base-spharos:5.6"
        BASE_NGINX_IMAGE = "base-nginx:1.18.0-alpine"
    }

    stages {
        stage('Parallel') {
            parallel {
                stage('api') {
                    steps {
                        script {
                            def repositoryName = "api"
                            def isProcessing = gitChangeLog("${CUSTOMER}", "${repositoryName}")
                            if ("${isProcessing}" == "true") {
                                build("${CUSTOMER}", "${repositoryName}", "${BASE_IMAGE}")
                            }
                        }
                    }
                }
                stage('cpon') {
                    steps {
                        script {
                            def repositoryName = "cpon"
                            def isProcessing = gitChangeLog("${CUSTOMER}", "${repositoryName}")
                            if ("${isProcessing}" == "true") {
                                build("${CUSTOMER}", "${repositoryName}", "${BASE_IMAGE}")
                            }
                        }
                    }
                }
                stage('mber') {
                    steps {
                        script {
                            def repositoryName = "mber"
                            def isProcessing = gitChangeLog("${CUSTOMER}", "${repositoryName}")
                            if ("${isProcessing}" == "true") {
                                build("${CUSTOMER}", "${repositoryName}", "${BASE_IMAGE}")
                            }
                        }
                    }
                }
                stage('point') {
                    steps {
                        script {
                            def repositoryName = "point"
                            def isProcessing = gitChangeLog("${CUSTOMER}", "${repositoryName}")
                            if ("${isProcessing}" == "true") {
                                build("${CUSTOMER}", "${repositoryName}", "${BASE_IMAGE}")
                            }
                        }
                    }
                }
            }
        }
    }
}

def gitChangeLog(customer, repositoryName) {
    dir("$SHELL_PATH") {
        def result = sh(returnStdout: true, script: "sh gitChangeLog.sh $customer $repositoryName").trim()
        echo "$customer-$repositoryName result: ${result} ${CONSTANT_SUCCESS}"

        return "${result}" == "${CONSTANT_SUCCESS}" ? true : false
    }
}

def build(customer, repositoryName, baseImage) {
    dir("$SHELL_PATH") {
        def result = sh(returnStdout: true, script: "sh build.sh $customer $repositoryName $baseImage").trim()
        echo "$customer-$repositoryName BUILD result: ${result} ${CONSTANT_SUCCESS}"

        return "${result}" == "${CONSTANT_SUCCESS}" ? true : false
    }
}
```

### Shell
- gitChangeLog.sh
```console
#!/bin/bash


. ./settings.sh


####################################################################################################
# Description
####################################################################################################
# Creator: HyunHyun Kim
# Date: 2021. 03. 22.
# Description:
#   현재 master 기준으로 변경사항이 있는지 확인하는 용도


####################################################################################################
# Constant Define
####################################################################################################
CONSTANT_MANDATORY_PARAMETERS_COUNT=2


####################################################################################################
# Function Define
####################################################################################################
function isValid() {
  [[ $# -lt $CONSTANT_MANDATORY_PARAMETERS_COUNT ]] && echo "$CONSTANT_ERR_INVALID_PARAMETER_COUNT" && return

  local repositoryName="$2"
  local repositoryId="$(aws codecommit get-repository --repository-name $repositoryName $AWS_CODECOMMIT | jq '.repositoryMetadata .repositoryId')"
  if [[ -z "$repositoryId" ]]; then
    echo "$CONSTANT_ERR_INVALID_PARAMETER"

    return
  else
    echo "$CONSTANT_SUCCESS"

    return
  fi
}

function printerr() {
  echo -e '----------------------------------------------------------------'
  echo -e 'Error> Passing wrong parameters                                 '
  echo -e '----------------------------------------------------------------'
  echo -e '- 1st parameter: Customer Name(ref: $CUSTOMER ./settings.sh)    '
  echo -e '- 2nd parameter: Repository Name of AWS CodeCommit              '
  echo -e '----------------------------------------------------------------'
}

function main() {
  local customerName="$1"
  local repositoryName="$2"
  local repositoryConf="$CONF_PATH/$customerName/$repositoryName"
  local repositoryLogs="$LOGS_PATH/$customerName/$repositoryName"
  local repositoryRepo="$REPO_PATH/$repositoryName"

  local init="$(init $customerName $repositoryName $repositoryConf $repositoryLogs $repositoryRepo)"

  local repositoryConfFile="$repositoryConf/$repositoryName.$CONF_EXTENSION"
  local repositoryConfFileBackUp="$repositoryConf/$(makeFileNameBySeq $repositoryConfFile).$CONF_EXTENSION"

  [[ "$(isProcessing $repositoryRepo $repositoryConfFile $repositoryConfFileBackUp)" == "$CONSTANT_SUCCESS" ]] && echo "$CONSTANT_SUCCESS" || echo "$CONSTANT_SUCCESS_NO_CHANGE"
}

function init() {
  local customerName="$1"
  local repositoryName="$2"

  local repositoryConf="$3"
  local repositoryLogs="$4"
  local repositoryRepo="$5"

  # create a directory named conf, logs and repo
  [[ ! -d "$repositoryConf" ]] && mkdir -p "$repositoryConf"
  [[ ! -d "$repositoryLogs" ]] && mkdir -p "$repositoryLogs"
  [[ ! -d "$repositoryRepo" ]] && mkdir -p "$repositoryRepo"

  # create a init log file
  local logsFile="$repositoryLogs/$repositoryName.$LOG_EXTENSION"
  local logsFileBackUp="$repositoryLogs/$(makeFileNameBySeq $logsFile).$LOG_EXTENSION"

  # logging
  [[ ! -f "$logsFile" ]] && touch "$logsFile"

  cp -f "$logsFile" "$logsFileBackUp"
  echo "===================================" > "$logsFile"
  echo "subjoect: gitChangeLog.sh          " >> "$logsFile"
  echo "date: $NOW_DATE                    " >> "$logsFile"
  echo "===================================" >> "$logsFile"
  echo "customerName: $customerName        " >> "$logsFile"
  echo "repositoryName: $repositoryName    " >> "$logsFile"
  echo "repositoryRepo: $repositoryRepo    " >> "$logsFile"

  # git clone a repo
  if [[ ! "$(ls -A $repositoryRepo)" ]]; then
    echo "pwd: $(pwd)" >> "$logsFile"
    echo "git clone $GIT_REPOSITORY_URL/$repositoryName $repositoryRepo" >> "$logsFile"
    git clone "$GIT_REPOSITORY_URL/$repositoryName" "$repositoryRepo"
  fi

  # git checkout master
  local branch="$(git -C "$repositoryRepo" status | grep "On branch" | sed 's/On branch//g' | xargs)"
  if [[ "$branch" != "$GIT_BRANCH" ]]; then
    git -C "$repositoryRepo" checkout "$GIT_BRANCH"
  fi

  # git pull
  git -C "$repositoryRepo" pull
}

function isProcessing(){
  local repositoryRepo="$1"
  local repositoryConfFile="$2"
  local repositoryConfFileBackUp="$3"
  local config="$(config $repositoryRepo $repositoryConfFile $repositoryConfFileBackUp)"

  [[ "$(cat $repositoryConfFile)" != "$(cat $repositoryConfFileBackUp)" ]] && echo "$CONSTANT_TRUE" && return || echo "$CONSTANT_FALSE"
}

function config(){
  local repositoryRepo="$1"
  local repositoryConfFile="$2"
  local repositoryConfFileBackUp="$3"

  # create a init conf file
  [[ ! -f "$repositoryConfFile" ]] && touch "$repositoryConfFile"

  # confing
  cp -f "$repositoryConfFile" "$repositoryConfFileBackUp"
  echo "$(git -C "$repositoryRepo" log -n 1 --pretty=format:"%H")" > "$repositoryConfFile"
}

function makeFileNameBySeq(){
  local fileFullName=$1
  local filePath="${fileFullName%/*}"
  local fileName=$(echo "$fileFullName" | sed 's/.*\/\(.*\)\..*/\1/')
  local fileSeq=$(printf "%03d" $(($(printf "%d" "$(ls -r "$filePath" | grep "$fileName-$NOW_DATE" | head -n 1 | sed 's/.*_\(.*\)\..*/\1/')") + 1)))
  echo printf "%d" "$(ls -r "$filePath" | grep "$fileName-$NOW_DATE" | head -n 1 | sed 's/.*_\(.*\)\..*/\1/')" >> log.log 

  echo "$fileName-$NOW_DATE-$fileSeq"
}


####################################################################################################
# Main Process
####################################################################################################
isValid="$(isValid $*)"
if [[ "$isValid" -eq "$CONSTANT_SUCCESS" ]]; then
  echo "$(main $*)"
else
  echo "$(printerr)"

  echo $isValid
fi
```

- build.sh
```console
#!/bin/bash


. ./settings.sh


####################################################################################################
# Description
####################################################################################################
# Creator: Bandi Lee
# Date: 2021. 03. 24.
# Description:
#   STG 특정 고객사 - repository 빌드 배포

####################################################################################################
# Constant Define
####################################################################################################
CONSTANT_MANDATORY_PARAMETERS_COUNT=3

####################################################################################################
# ARGUMENT DEFINE
####################################################################################################

customer="${1,,}"
repositoryName="$2"
baseImage="$3"

####################################################################################################
# Function Define
####################################################################################################

function isValid() {
  [[ $# -lt $CONSTANT_MANDATORY_PARAMETERS_COUNT ]] && echo "$CONSTANT_ERR_INVALID_PARAMETER_COUNT" && return

  local repositoryId="$(aws codecommit get-repository --repository-name $repositoryName $AWS_CODECOMMIT | jq '.repositoryMetadata .repositoryId')"
  if [[ -z "$repositoryId" ]]; then
    echo "$CONSTANT_FALSE"

    return
  else
    echo "$CONSTANT_TRUE"

    return
  fi
}

function printer() {
  echo -e "-------------------------------------------------------------"
  echo -e "Error> Passing wrong parameters                              "
  echo -e "-------------------------------------------------------------"
  echo -e "- 1st parameter: Customer Name(ref: $CUSTOMERS ./settings.sh)"
  echo -e "- 2st parameter: Repository Name of AWS CodeCommit           "
  echo -e "- 3nd parameter: BaseImageName					            "
  echo -e "-------------------------------------------------------------"
}

function main() {	
  # LOG
  echo "$(createLog)" >>$ACTIVEPROFILE-executeBuild.log

  # BUILD
  curl -u $JENKINS_USER:$JENKINS_TOKEN -X post "http://$JENKINS_URL:$JENKINS_PORT/view/Auto_Repository/job/$repositoryName/buildWithParameters?token=$JENKINS_TOKEN&activeProfile=$ACTIVEPROFILE&customerName=$customer&baseImage=$baseImage"
  wait
  # -- After build finished, start the next repository build
  waitBuildFinished

  echo $CONSTANT_SUCCESS
}

function waitBuildFinished() {
  sleep 30 
  while true; do
    local status="$(curl -u $JENKINS_USER:$JENKINS_TOKEN -X get "http://$JENKINS_URL:$JENKINS_PORT/job/$repositoryName/lastStableBuild/api/json" | jq '.nextBuild' | jq '.number')"
    wait
    if [[ "$status" -eq null ]]; then
      break
    fi
    echo "$customer $repositoryName building..." >>$ACTIVEPROFILE-executeBuild.log
    sleep 15
  done
}

function createLog() {
  echo "------------------------------------------------------------"
  echo "[START BUILD]-----------------------------------------------"
  echo " * EXE_DATE : $(date "+%y%m%d")"
  echo " * CUSTOMER : $customer REPOSITORYNAME : $repositoryName"
  echo "------------------------------------------------------------" 
}

####################################################################################################
# Main Process
####################################################################################################
isValid="$(isValid $*)"
if [[ "$isValid" -eq "$CONSTANT_TRUE" ]]; then
  isMain="$(main)"
  [[ "$isMain" == "$CONSTANT_TRUE" ]] && exit $CONSTANT_SUCCESS || exit $isMain
else
  echo "$(printer)"

  exit $isValid
fi
```

- settings.sh
```console
####################################################################################################
# AWS
####################################################################################################
AWS_CODECOMMIT="--profile codecommit"


####################################################################################################
# SYSTEM
####################################################################################################
CONSTANT_SUCCESS=0
CONSTANT_SUCCESS_NO_CHANGE=100
CONSTANT_ERR=200
CONSTANT_ERR_INVALID_PARAMETER_COUNT=200
CONSTANT_ERR_INVALID_PARAMETER=201
CONSTANT_ERR_UNKNOWN=255

CONSTANT_TRUE=0
CONSTANT_FALSE=1

CONSTANT_MANDATORY_PARAMETERS_COUNT=1


####################################################################################################
# PATH
####################################################################################################
HOME_PATH=./..
CONF_PATH=$HOME_PATH/conf
LOGS_PATH=$HOME_PATH/logs
REPO_PATH=$HOME_PATH/repo


####################################################################################################
# GIT
####################################################################################################
GIT_REPOSITORY_URL="https://git-codecommit.ap-northeast-2.amazonaws.com/v1/repos"
GIT_BRANCH="master"
ACTIVEPROFILE="stg"
BASEIMAGE="base-dev:1.0"

####################################################################################################
# CONFIG
####################################################################################################
CONF_EXTENSION=conf
CONF_BACKUP_DATE=$(date +%Y%m%d)


####################################################################################################
# LOGGING
####################################################################################################
LOG_EXTENSION=log
LOG_BACKUP_DATE=$(date +%Y%m%d)


####################################################################################################
# VARIABLE
####################################################################################################
NOW_DATE=$(date +%Y%m%d)
DATE_FORMAT="%Y%m%d"


####################################################################################################
# CUSTOMER
####################################################################################################
REPOSITORIES=api,mber,point
CUSTOMERS=Spharos,Josunhotel,Emoney,Shinsegaepoint


####################################################################################################
# JENKINS
####################################################################################################
JENKINS_URL="10.222.57.74"
JENKINS_PORT="8080"
JENKINS_USER="ssgadmin"
JENKINS_TOKEN="11ed1ef91e7f818b56dffb6251becb1b3d"
```

## Jenkins by git tag change log
### shell
- gitAutoTagging.sh
```console
#!/bin/bash


. ./settings.sh


####################################################################################################
# Description
####################################################################################################
# Creator: HyunHyun Kim
# Date: 2021. 03. 19.
# Description:
#   git remote에서 master branch를 가져와 tag를 생성한 뒤 push까지 진행.
#   이후 jenkins의 빌드/배포를 실행한다.
#   단, 아직 exception, error처리에 대한 부분이 미흡함으로 아직까지는 실무에서 사용하기 부적합하다.
# Parameter
#   $1=고객사:-default $CUSTOMER(in ./settings.sh)
#     형태: 고객사,고객사,고객사(구분자 ',')
#     예제: josunhotel,emoney,spharos


####################################################################################################
# Function Define
####################################################################################################
function main() {
    local repositories=$(aws codecommit list-repositories | jq '.repositories | .[]')
#  local repositories='{
#                        "repositoryName": "jenkins",
#                        "repositoryId": "7f0a170c-6f7d-43ab-be9e-69044192d1a1"
#                      }'
  for repositoryName in $(echo "$repositories" | jq -r '.repositoryName'); do
    local repositoryName="$repositoryName"
    local repositoryRepo="$REPO_PATH/$repositoryName"
    local init="$(init $repositoryName $repositoryRepo)"

    local repositoryConf="$CONF_PATH/$repositoryName"
    local repositoryConfFile="$CONF_PATH/$repositoryName/$repositoryName.$CONF_EXTENSION"
    local repositoryConfFileBackUp="$CONF_PATH/$repositoryName/$(makeFileNameBySeq "$repositoryConf" "$repositoryName.$CONF_EXTENSION")"

    [[ "$(isProcessing $repositoryRepo $repositoryConfFile $repositoryConfFileBackUp)" != "$CONSTANT_TRUE" ]] && continue

    echo "$(gitTagging $repositoryName $repositoryRepo $1)"
  done

  # 결과값을 어떻게 처리하지..? 총카운트/이행카운트? 뭐 이런식 ?
}

function init() {
  local repositoryName="$1"
  local repositoryRepo="$2"

  # create a directory named conf, logs and repo
  [[ ! -d "$CONF_PATH" ]] && mkdir -p "$CONF_PATH/$repositoryName"
  [[ ! -d "$LOGS_PATH" ]] && mkdir -p "$LOGS_PATH/$repositoryName"
  [[ ! -d "$REPO_PATH" ]] && mkdir -p "$REPO_PATH"

  # git clone a repo
  if [[ ! -d "$repositoryRepo" ]]; then
    git clone "$GIT_REPOSITORY_URL/$repositoryName" "$repositoryRepo"
  fi

  # git checkout master
  local branch="$(git -C "$repositoryRepo" status | grep "On branch" | sed 's/On branch//g' | xargs)"
  if [[ "$branch" != "$GIT_BRANCH" ]]; then
    git -C "$repositoryRepo" checkout "$GIT_BRANCH"
  fi

  # git pull
  git -C "$repositoryRepo" pull
}

function isProcessing(){
  local repositoryRepo="$1"
  local repositoryConfFile="$2"
  local repositoryConfFileBackUp="$3"
  local config="$(config $repositoryRepo $repositoryConfFile $repositoryConfFileBackUp)"

  [[ "$(cat $repositoryConfFile)" != "$(cat $repositoryConfFileBackUp)" ]] && echo "$CONSTANT_TRUE" && return || echo "$CONSTANT_FALSE"
}

function config(){
  local repositoryRepo="$1"
  local repositoryConfFile="$2"
  local repositoryConfFileBackUp="$3"

  # create a init conf file
  [[ ! -f "$repositoryConfFile" ]] && touch "$repositoryConfFile"

  # config
  cp -f "$repositoryConfFile" "$repositoryConfFileBackUp"
  echo "$(git -C "$repositoryRepo" log -n 1 --pretty=format:"%H")" > "$repositoryConfFile"
}

function makeFileNameBySeq(){
  local repositoryConf=$1
  local fileFullName=$2
  local fileName=$(echo "$fileFullName" | sed 's/\(.*\)\..*/\1/')
  local fileSeq=$(printf "%03d" $(($(printf "%d" "$(ls -r "$repositoryConf" | grep "$fileName-$NOW_DATE" | head -n 1 | sed 's/.*-\(.*\)\..*/\1/')") + 1)))

  echo "$fileName-$NOW_DATE-$fileSeq.$CONF_EXTENSION"
}

function gitTagging() {
  local repositoryName="$1"
  local repositoryRepo="$2"
  local customers="${3:-default $CUSTOMERS}"

  for customer in $(echo "$customers" | tr ',' "\n"); do
    local oriTagName=$(git -C "$repositoryRepo" ls-remote --tags origin | grep -E "$customer" | head -n 1)      ##### 정렬할 것
    local newTagName=$NOW_DATE-"$customer"-$(printf "%03d" $(($(printf "%d" "${oriTagName##*-}") + 1)))

    git -C "$repositoryRepo" tag -a "$newTagName" -m "$newTagName"
    git -C "$repositoryRepo" push --tag
  done
}


####################################################################################################
# Main Process
####################################################################################################
isMain="$(main $*)"
[[ "$isMain" == "$CONSTANT_TRUE" ]] && exit $CONSTANT_SUCCESS || exit $isMain
```

## pull request checker
- AWS의 codecommit에 pull request가 있는지 구분한다.
```
#!/bin/bash


####################################################################################################
# CONSTANT Define
####################################################################################################
CONSTANT_MIN_COUNT=0


####################################################################################################
# Function Define
####################################################################################################
function main() {
  # get list-repository
  local repositories=$(aws codecommit list-repositories | jq '.repositories | .[]' | jq -r '.repositoryName')

  for repositoryName in ${repositories}; do
    echo "$(awsCodeCommitListPullRequests "${repositoryName}")"
  done
}

function awsCodeCommitListPullRequests() {
  local repositoryName="$1"

  local pullRequests=$(aws codecommit list-pull-requests --repository-name "${repositoryName}" --pull-request-status open)
  local pullRequestCount=$(echo "${pullRequests}" | jq '.pullRequestIds | length')
  if ((${pullRequestCount} >CONSTANT_MIN_COUNT)); then
    echo "    - ${repositoryName}"
  fi
}


####################################################################################################
# Main Process
####################################################################################################
echo "$(main $*)"
```
  
