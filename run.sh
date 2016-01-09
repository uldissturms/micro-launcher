. ./restore.sh

args=$@
parallel=1

# parse arguments passed in
while [[ $# > 1 ]]
do
  key="$1"

  case $key in
    -p|--parallel)
      parallel="$2"
      shift # past argument
      ;;
    *)
      # unknown option
      ;;
  esac
  shift # past argument or value
done

ls packages | xargs -n 1 -P $parallel -I % bash -c "./run-service.sh % $args"
