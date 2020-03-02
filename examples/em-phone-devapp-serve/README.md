This is an example of setting up a server for the devapp. You can use it over
use case scenarios:
- deploy the code from a particular branch, or
- mount the source from a directory on the host to allow for local editing.

#### Just deploy the code for exploration ####

Use without any changes. The code will be checked out to the container, and
will be removed when the container is removed.

#### Deploy the container for editing ####

- Include the currently commented out volume
- Look through all the `CHANGEME` locations and fill them out.
    ```
    $ grep -r CHANGEME .
    ```
    Some of these are required; others are optional.
- The code will be mounted to a directory on your host
- Edit the code on the host for auto-reload
- Restarting the container will retain changes from previous runs
- If you run into issues - check in your pending changes, remove the host directory and restart, which will check out the repo and set everything up again
