#!/bin/bash

# Strict mode
set -e

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
done
TEST_DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

echo -e "\n################# Testing JS ##################"
# TODO: Use mocha and real testing tools instead of rolling our own
cd $TEST_DIR/../libethash-js 
node test.js

echo -e "\n################# Testing Python ##################"
$TEST_DIR/python/test.sh

echo -e "\n################# Testing C ##################"
$TEST_DIR/c/test.sh

#echo "################# Testing Go ##################"
#( rm -rf $TEST_DIR/../go-build 
#  export GOPATH=$TEST_DIR/../go-build 
#  export PATH=$PATH:$GOPATH/bin 
#  cd $TEST_DIR/go 
#  go get -dv 
#  go get -v github.com/ethereum/ethash 
#  go test )