#!/bin/bash

<< 'DOCS'
  Generate protobuf files from internal_api definitions.
DOCS

# When DEBUG env is set - print output of the scripts.
if [[ -e $DEBUG ]];
then
  set -x
fi

INTERNAL_API_REPO=git@github.com:renderedtext/internal_api.git
INTERNAL_API_OUT=pkg/internal_api
PACKAGE_PREFIX=InternalApi__
MODULE_NAME=github.com/semaphoreio/semaphore/repohub
MODULES=(${1//,/ })
INTERNAL_API_BRANCH=${2:-master}
INTERNAL_API_FOLDER=${3:-"/tmp/internal_api"}

generate_proto_definition()
{
  MODULE=$1
  FILE=$2

  mkdir -p pkg/internal_api/$MODULE
	protoc --proto_path $INTERNAL_API_FOLDER/ \
         --proto_path $INTERNAL_API_FOLDER/include/ \
         --proto_path $INTERNAL_API_FOLDER/include/internal_api \
				 --go-grpc_out=pkg/internal_api/$MODULE \
				 --go-grpc_opt=paths=source_relative \
         --go-grpc_opt=require_unimplemented_servers=false \
				 --go_out=pkg/internal_api/$MODULE \
         --go_opt=M$FILE=internal_api/$MODULE \
				 --go_opt=paths=source_relative  \
				 $FILE
}


set_go_packages()
{
  echo "$(bold "Generating proto definitions")"
  echo "MODULES := (${MODULES[@]})"
  _set_go_package response_status $INTERNAL_API_FOLDER/include/internal_api/response_status.proto
  for MODULE in ${MODULES[@]};
  do
    _set_go_package $MODULE $INTERNAL_API_FOLDER/$MODULE.proto
  done
}
_set_go_package()
{
  MODULE=$1
  FILE=$2

  echo "$(bold "Processing $FILE")"
  echo "Removing current go_package"
	sed --in-place '/go_package/d' $FILE
  GO_PACKAGE="option go_package = \"github.com/semaphoreio/semaphore/repohub/pkg/internal_api/$MODULE\";"
  echo "Setting new go_package"
  echo $GO_PACKAGE >> $FILE
  echo "New go_package set: $GO_PACKAGE"
}

generate_proto_files()
{
  echo "$(bold "Generating proto files")"
  for MODULE in ${MODULES[@]};
  do
    generate_proto_definition $MODULE $INTERNAL_API_FOLDER/$MODULE.proto
  done
  generate_proto_definition response_status $INTERNAL_API_FOLDER/include/internal_api/response_status.proto
  mv pkg/internal_api/response_status/include/internal_api/response_status.pb.go pkg/internal_api/response_status/response_status.pb.go
  rm -rf pkg/internal_api/response_status/include
  echo "Files generated in $INTERNAL_API_OUT"
}

bold() {
  bold_text=$(tput bold)
  normal_text=$(tput sgr0)
  echo -n "${bold_text}$@${normal_text}"
}

set_go_packages && \
generate_proto_files
