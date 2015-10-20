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

@test "should run services" {
  . ./run.sh

  ps aux | grep Program.exe
}
