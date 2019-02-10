ARGS="$@"
echo "ARGS="$ARGS
docker exec -it $CONTAINER bash -c "source activate emission && ./e-mission-py.bash $ARGS"
