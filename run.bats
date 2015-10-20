#!/usr/bin/env bats

teardown() {
  rm -rf ./packages
}

@test "should install services" {
  run . ./run.sh

  [ "$status" -eq 0 ]
  ls packages | grep hello-world-fsharp
}

@test "should run services" {
  run . ./run.sh

  ps aux | grep Program.exe
}
