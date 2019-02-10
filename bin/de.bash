ARGS="$@"
echo "ARGS="$ARGS
docker exec -it $CONTAINER bash -c "source activate emission && $ARGS"
