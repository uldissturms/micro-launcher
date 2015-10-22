#!/usr/bin/env bats

setup() {
  cp paket.dependencies.sample paket.dependencies
}

teardown() {
  pkill mono || true
  pkill node || true
}

@test "should install services" {
  rm -rf ./packages
  . ./run.sh
  ls packages | grep hello-world-fsharp
}

@test "should start hello world web app" {
  . ./run.sh
  sleep 3
  curl localhost:8083
}

@test "should not start excluded services" {
  . ./run.sh --exclude hello-world-fs
  [ $(ps aux | grep -c "Program.exe") -eq 0 ]
}

@test "should start only included services" {
  . ./run.sh --include hello-world-fs

  fsharp_running=$(ps aux | grep -c "Program.exe")
  [[ "$fsharp_running" -eq 1 ]]

  [ $(ps aux | grep -c "node") -eq 0 ]
}
