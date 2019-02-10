## Creating the main server

This starts a jupyter notebook server with the emission modules loaded,
connected to a database.

This is also an example of [tweaking the standard
image](../../README.md#Tweaking_the_image). We copy over a startup file
(`start_notebook.sh`) that launches a juypter server instead of the standard
emission server. Note that this requires an extra command if the base image has
changed.

There are some special instructions for running this container.
1. **Do not use** the `-d` option. You want to be able to see the logs.

    ```
    docker-compose -f examples/juypter-notebook/docker-compose.yml up
    ```

1. When the container has finished launching, find these lines in the log
    ```
    web-server_1  |     Copy/paste this URL into your browser when you connect for the first time,
    web-server_1  |     to login with a token:
    web-server_1  |         http://0.0.0.0:8888/?token=<some_long_token>
    ```
1. Copy-paste that URL into the browser
    - Make sure to [change `localhost` to the correct
host IP for your operating system if needed](../../README.md#Connecting_to_the_created_container)

1. Note that because of the way that docker works, all the notebooks created in the main e-mission-server directory are essentially **temporary**.
    - they will be **retained** when you kill (Ctrl+C) and restart (`up`)the containers.
    - they will be **deleted** when the container is removed (e.g. when you run `docker-compose down`).
      - If you want to preserve your notebooks, across `up/down` sessions, store them in the **`saved-notebooks`** directory.

### Testing

The server is started on port 8888. 

- So on \*nix systems, this server is at http://localhost:8888
- For other operating systems, you may have to [use a different host than
  `localhost`](../../README.md#Connecting_to_the_created_container)
