#!/bin/bash
if test "$OS" = "Windows_NT"
then
  # use .Net
  .paket/paket.bootstrapper.exe
  rm paket.lock
  .paket/paket.exe update
else
  # use mono
  mono .paket/paket.bootstrapper.exe
  rm paket.lock
  mono .paket/paket.exe update
fi

for subdir in packages/*; do
    (cd "$subdir"; echo "Running: ${PWD##*/}"; ./run.sh)
done
