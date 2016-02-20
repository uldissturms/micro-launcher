function match {
  left=$1
  right=$2

  for keyword in $(echo $right | tr "," "\n")
  do
    if echo $left | grep -i $keyword > /dev/null ; then
      return 0
    fi
  done

  return 1
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
