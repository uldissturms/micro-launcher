rm -f paket.lock

if test "$OS" = "Windows_NT"
then
  # use .Net
  .paket/paket.bootstrapper.exe
  .paket/paket.exe update
else
  # use mono
  mono .paket/paket.bootstrapper.exe
  mono .paket/paket.exe update
fi

args=$@
ls packages | xargs -n 1 -P 10 -I % bash -c "./run-service.sh % $args"
