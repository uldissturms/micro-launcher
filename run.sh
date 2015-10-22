(
# parse arguments passed in
while [[ $# > 1 ]]
do
  key="$1"

  case $key in
    -e|--exclude)
      EXCLUDE="$2"
      shift # past argument
      ;;
    -i|--include)
      INCLUDE="$2"
      shift # past argument
      ;;
    *)
      # unknown option
      ;;
  esac
  shift # past argument or value
done

if test "$OS" = "Windows_NT"
then
  # use .Net
  .paket/paket.bootstrapper.exe
  rm -f paket.lock
  .paket/paket.exe update
else
  # use mono
  mono .paket/paket.bootstrapper.exe
  rm -f paket.lock
  mono .paket/paket.exe update
fi

echo "Including $INCLUDE"

for subdir in packages/*; do
  service=${subdir##*/}
  if [[ ! -z "$EXCLUDE" ]] && [[ "$service" == *$EXCLUDE* ]]
  then
    echo "Skipping: $service"
  elif [[ ! -z "$INCLUDE" ]] && [[ "$service" != *$INCLUDE* ]]
  then
    echo "Skipping: $service"
  else
    echo "Running: $service"
    (cd "$subdir"; . ./run.sh)
  fi
done
)
