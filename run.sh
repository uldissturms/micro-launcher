.paket/paket.bootstrapper.exe
rm paket.lock
.paket/paket.exe update
find packages -name "*.exe" -exec start {} \;
