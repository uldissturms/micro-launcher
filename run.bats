#!/usr/bin/env bats

setup() {
  cp paket.dependencies.sample paket.dependencies
}

teardown() {
  pkill mono
  rm -rf ./packages
}

@test "should install services" {
  . ./run.sh

  ls packages | grep hello-world-fsharp
}

@test "should start hello world web app" {
  . ./run.sh

  run curl localhost:8083
}

@test "should not start excluded services" {
  . ./run.sh --exclude hello-world-fs

  [ $(netstat -an | grep -c "8083") -eq 0 ]
}
