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

  if [[ ! -z "$EXCLUDE" ]] && [[ "$service" == *$EXCLUDE* ]]
  then
    echo "Skipping: $service"
  elif [[ ! -z "$INCLUDE" ]] && [[ "$service" != *$INCLUDE* ]]
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
