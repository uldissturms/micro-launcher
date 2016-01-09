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

@test "should start hello world web apps" {
  . ./run.sh

  sleep 3
  curl localhost:8083
  curl localhost:3000
}

@test "should not start excluded services" {
  . ./run.sh --exclude hello-world-fs

  sleep 3
  curl localhost:3000
}

@test "should start only included services" {
  . ./run.sh --include hello-world-node

  sleep 3
  curl localhost:3000
}
