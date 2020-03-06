This is an example of setting up a server for the devapp. You can use it over
use case scenarios:
- deploy the code from a particular branch, or
- mount the source from a directory on the host to allow for local editing.

#### `docker-compose.yml`: deploy the code for exploration ####

Modify the repo and branch if needed. The code will be checked out to the
container, and will be removed when the container is removed.

#### `docker-compose.livereload.yml`: Deploy the container for editing ####

- The code will be mounted to a directory on your host
- Edit the code on the host for auto-reload
- Restarting the container will retain changes from previous runs
- Currently checks out to ~/e-mission-phone-docker/src
- Change this using the `CHANGEME` locations if needed
- If you run into issues - commit and push your pending changes, remove the host directory and restart, which will check out the repo and set everything up again
