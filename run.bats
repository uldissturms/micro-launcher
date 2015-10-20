#!/usr/bin/env bats

setup() {
  cp paket.dependencies.sample paket.dependencies
  . ./run.sh
}

teardown() {
  pkill mono
  rm -rf ./packages
}

@test "should install services" {
  ls packages | grep hello-world-fsharp
}

@test "should run services" {
  ps aux | grep Program.exe
}

@test "should start hello world web app" {
  run curl localhost:8083
}
