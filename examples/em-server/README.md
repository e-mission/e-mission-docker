## Using the main server on production

This starts the main e-mission server with pre-packaged code from dockerhub.

[![Try in PWD](https://raw.githubusercontent.com/play-with-docker/stacks/master/assets/images/button.png)](https://labs.play-with-docker.com/?stack=https://raw.githubusercontent.com/e-mission/e-mission-docker/master/examples/em-server/docker-compose.yml)

### Testing

The server is started on port 8080. 

- So on \*nix systems, this server is at http://localhost:8080
- For other operating systems, you may have to use a different host than
  `localhost. For more details, check the instructions on connecting to the
   [created container in the main README](../../README.md#connecting-to-the-created-container)

### `docker-compose.dev.yml`: deploy code for testing

Modify the repo and branch if needed. The current code will be checked out to
the container, and will be removed when the container is removed.

### `docker-compose.dev.livereload.yml: deploy code for editing

- The code will be mounted to a directory on your host
- Edit the code on the host for auto-reload
- Restarting the container will retain changes from previous runs
- Currently checks out to ~/e-mission-server-docker/src
- Logs are mounted in ~/e-mission-server-docker/logs
- Change this using the `CHANGEME` locations if needed
- If you run into livereload issues, restart the container
- If you run into setup issues - commit and push your pending changes, remove the host directory and restart, which will check out the repo and set everything up again
