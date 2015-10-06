.paket/paket.bootstrapper.exe
rm paket.lock
.paket/paket.exe update
for subdir in packages/*; do
    (cd "$subdir"; echo "Running: ${PWD##*/}"; ./run.sh)
done
