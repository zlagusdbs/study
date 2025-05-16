#!/bin/bash

####################################################################################################
# CONSTANT Define
####################################################################################################
CONSTANT_MANDATORY_PARAMETERS_COUNT=2

CONSTANT_SUCCESS=0
CONSTANT_FAILURE=1

CONSTANT_TRUE=0
CONSTANT_FALSE=1

####################################################################################################
# PATH
####################################################################################################
LOG_DIR='./logs'
LOG_FILE=''

####################################################################################################
# Command Line
####################################################################################################
COMMAND_LINE=''

####################################################################################################
# Function Define
####################################################################################################
function validate() {
  local result=$CONSTANT_TRUE

  if [ $# -lt ${CONSTANT_MANDATORY_PARAMETERS_COUNT} ] || [ -z "$1" ] || [ -z "$2" ]; then
    result=$CONSTANT_FALSE
  fi

  echo $result
}

function printerr() {
  echo -e "------------------------------------------------------------"
  echo -e "Error> Passing wrong parameters                             "
  echo -e "------------------------------------------------------------"
  echo -e "- 1st parameter: AWS Batch - Task Definition Name           "
  echo -e "- 2nd parameter: docker image uri                           "
  echo -e "------------------------------------------------------------"
}

function main() {
  local result=$(awsBatchDefinition $1 $2)
  if [ $result -eq ${CONSTANT_TRUE} ]; then
    # result 반환 후 list를 조회해 온 뒤(정렬필요), 3번 째 이후 job은 모두 삭제할 것.
    # 단, aws등록만 성공해도 된다. 즉, 등록은 잘 되었으나, 기존 Batch들의 삭제가 실패하여도 jenkins는 성공으로 받아야 한다.
    $(awsBatchRemove $*)
  fi

  echo $result
}

function awsBatchDefinition() {
  local result=CONSTANT_FALSE

  local batchResult
  local batchTaskName=$1
  local batchDockerImageUri=$2

  batchResult=$(
    aws batch register-job-definition --job-definition-name "${batchTaskName}" \
    --type container \
    --parameters '{"JobName":"default"}' \
    --container-properties '{"image":"'"${batchDockerImageUri}"'", "vcpus":1, "memory":3584, "command":["Ref::JobName"]}' \
    --retry-strategy '{"attempts":1}' \
    --timeout '{"attemptDurationSeconds":3600}' \
    --output json
  )

  $(logging "$1" "$2" "${batchResult}")

  local resultBatchTaskName=$(echo "${batchResult}" | jq '.jobDefinitionName' | sed -e 's/"//g')
  if [ "${resultBatchTaskName}" == "${batchTaskName}" ]; then
    result=$CONSTANT_TRUE
  else
    result=$CONSTANT_FALSE
  fi

  echo $result
}

function awsBatchRemove() {
  local batchTaskName=$1

  #조회
  local batches=$(
    aws batch describe-job-definitions --job-definition-name ${batchTaskName} \
    --status ACTIVE
  )

  for revision in $(echo "${batches}" | grep revision | sed -e 's/,//g' -e 's/"revision"://g' -e 's/ //g' | sed -n "4, \$p"); do
    #삭제
    aws batch deregister-job-definition --job-definition $1':'$revision
  done;
}

function logging() {
  if [ ! -d "${LOG_DIR}" ]; then
    mkdir "${LOG_DIR}"
  fi

  LOG_FILE="$(date +%Y-%m-%d).log"
  # 파일이 존재하면 appender, 없으면 신규
  if [ ! -d "${LOG_FILE}" ]; then
    touch "${LOG_FILE}"
  fi

  echo -e $1'\t'$2'\n'$3'\n\n\n' >>${LOG_DIR}"/"${LOG_FILE}
}

####################################################################################################
# Main Process
####################################################################################################
if [ $(validate $*) -eq ${CONSTANT_TRUE} ]; then
  echo "$(main $*)"
else
  echo "$(printerr)"
fi
