#!/usr/bin/env bats

setup() {
  cp paket.dependencies.sample paket.dependencies
}

teardown() {
  pkill mono || true
  pkill node || true
}

@test "installs services" {
  rm -rf ./packages

  . ./run.sh

  ls packages | grep hello-world-fsharp
}

fsharp-app-running() {
  sleep 3
  curl localhost:8083
}

fsharp-app-not-running() {
  ! curl localhost:8083
}

node-app-running() {
  sleep 3
  curl localhost:3000
}

@test "starts all services when no arguments provided" {
  . ./run.sh

  fsharp-app-running
  node-app-running
}

@test "starts all services in parallel" {
  . ./run.sh --parallel 2

  fsharp-app-running
  node-app-running
}

@test "doesn't start excluded services" {
  . ./run.sh --exclude hello-world-fs

  node-app-running
  fsharp-app-not-running
}

@test "starts only included services" {
  . ./run.sh --include hello-world-node

  node-app-running
  fsharp-app-not-running
}
