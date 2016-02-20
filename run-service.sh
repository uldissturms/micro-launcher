function match {
  if echo $1 | grep -i $2 > /dev/null ; then
    return 0
  else
    return 1
  fi
}

(
  service=$1
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

  if [[ ! -z "$EXCLUDE" ]] && match $service $EXCLUDE
  then
    echo "Skipping: $service"
  elif [[ ! -z "$INCLUDE" ]] && ! match $service $INCLUDE
  then
    echo "Skipping: $service"
  elif [[ ! -d "packages/$service" ]]
  then
    echo "Missing: $service"
  else
    echo "Running: $service"
    (cd "packages/$service"; . ./run.sh)
  fi
)
