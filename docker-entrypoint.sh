#!/bin/bash
set -euo pipefail
set -o errexit
set -o errtrace
IFS=$'\n\t'

export S3_ACL=${S3_ACL:-private}

mkdir -p ${MNT_POINT}

if [ "$IAM_ROLE" == "none" ]; then
  export AWSACCESSKEYID=${AWSACCESSKEYID:-$AK}
  export AWSSECRETACCESSKEY=${AWSSECRETACCESSKEY:-$SK}

  echo "${AK}:${SK}" > /etc/passwd-s3fs
  chmod 0400 /etc/passwd-s3fs

  echo 'IAM_ROLE is not set - mounting S3 with credentials from ENV'
  echo "/usr/bin/s3fs  ${BUCKET} ${MNT_POINT} -d -d -f -o url=${ENDPOINT},allow_other,retries=5"
  /usr/bin/s3fs  ${BUCKET} ${MNT_POINT} -d -d -f -o url=${ENDPOINT},allow_other,retries=5 -o use_path_request_style
  echo 'started...'
else
  echo 'IAM_ROLE is set - using it to mount S3'
  /usr/bin/s3fs ${BUCKET} ${MNT_POINT} -d -d -f -o endpoint=${ENDPOINT},iam_role=${IAM_ROLE},allow_other,retries=5
fi
