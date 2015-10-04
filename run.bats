#!/usr/bin/env bats

@test "should install services" {
    command rm -rf ./packages  
    
    run . ./run.sh
    
    [ "$status" -eq 0 ]
    ls packages | grep hello-world-fsharp
}

@test "should run services" {
    run . ./run.sh

    ps aux | grep hello-world-fsharp
}
