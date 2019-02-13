# Docker usage instructions
This project is now published on dockerhub!
https://hub.docker.com/r/emission/e-mission-server/

**Issues:** Since this repository is part of a larger project, all issues are tracked [in the central docs repository](https://github.com/e-mission/e-mission-docs/issues).

This image currently requires an external mongodb instance to run, so we
strongly recommend using `docker-compose` to create a full setup. We have added
[examples](examples)
for various scenarios - please see the `README.md` for each scenario for
more details.

**`docker-compose` examples are in the [examples](examples) directory**

The standard `Dockerfile`s and startup script are in this directory.

Instructions on re-building the image for upload to DockerHub are [in the build instructions](#Docker_Build_Instructions)

[![Try in PWD](https://raw.githubusercontent.com/play-with-docker/stacks/master/assets/images/button.png)](https://labs.play-with-docker.com/?stack=https://raw.githubusercontent.com/e-mission/e-mission-docker/master/examples/em-server/docker-compose.yml)

   - [Try in PWD](#try-in-pwd)
   - [Quick start installation instructions](#quick-start-installation-instructions)
   - [Using scripts](#using-scripts)
   - [Tweaking the image](#tweaking-the-image)
   - [Connecting to the created container](#connecting-to-the-created-container)

### Try in PWD
[Play With Docker (PWD)](https://labs.play-with-docker.com/) is a docker playground allows you to deploy docker images with the click of a button. The images are short-lived, so they are not a substitute for real cloud resources, but they are a quick way to experiment and ensure that everything works. Each example README (including this one!) has at least one PWD button; you can also use the generated instance(s) to experiment with more complex docker installations. Questions? [PWD has extensive documentation](https://training.play-with-docker.com/).

### Quick-start installation instructions

**Note 1:** This is *NOT* a comprehensive guide to installing or troubleshooting docker. That is beyond the scope of this project. If you have any questions about the way in which e-mission *uses* docker - e.g. our `Dockerfile` or the `docker-compose.yml` examples listed above, please file [an issue](https://github.com/e-mission/e-mission-docs/issues). If you have a generic docker installation or troubleshooting question, check the docker documentation or stackoverflow.

**Note 2:** These instructions assume the use of a POSIX-compliant command line interface. So they will work without modification on **linux and OSX**. If you are on **Windows**, you have to figure out the appropriate translations. I would recommend using a POSIX-compliant CLI (such as [gitbash](https://openhatch.org/missions/windows-setup/install-git-bash)) on windows. But you can also use the windows `cmd.exe` or GUI tools. In that case, *you are responsible* for figuring out how to translate these commands appropriately (e.g. converting `/` to `\` in `cmd.exe`).

1. Clone this repository to your computer

   ```
   $ git clone https://github.com/e-mission/e-mission-docker.git
   ``` 

1. (optional) If you have a previous failed installation, you might want to remove all old containers and images and start with a clean slate (e.g. [following these instructions](https://techoverflow.net/2013/10/22/docker-remove-all-images-and-containers/)). **USE WITH CARE:** Note that this will delete any existing data in your installation. If you did this, then at the end, your docker setup would look like this.

    ```
    $ docker image list
    REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE

    $ docker ps -a
    CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
    ```

1. (optional) If you want to use `swarm` for container management, initialize Swarm. If you don't know what `swarm` is, you can skip this step.

    ```
   docker swarm init 
   ``` 
   For more details on how to do manage a swarm please see the official documentation: https://docs.docker.com/get-started/part4/ 


2. Configure the compose file. We have some
[examples](https://github.com/e-mission/e-mission-docker/tree/master/examples).
If you want to do something different, update the port mappings and environment
variables if necessary, and [submit a pull request](https://github.com/e-mission/e-mission-docker/CONTRIBUTING) so that others can benefit from your work. For more details on how to configure compose files please see the official documentation: https://docs.docker.com/compose/compose-file/#service-configuration-reference 

3. Deploy directly to your computer

   ```
    docker-compose -f <path_to_docker-compose.yml> up -d
   ```

    or to swarm if you initalized it in step 3

   ```
    docker stack deploy -c <path_to_docker-compose.yml> emission
   ```
   There are many ways you can manage your deployment. Again, please see the official documentation for more details: https://docs.docker.com/get-started/part4/

4. Test your connection to the server that you started. Testing instructions are in the `README.md` for each example.

### Using scripts

The documentation has a lot of references to `./e-mission-py.bash` or similar
scripts. These are intended to be run from a checked out `e-mission-server`
repository. If you are using docker, though, `e-mission-server` repository is
inside the docker container. So we have a helper script to run commands in your
docker container.

  - Replace references to `e-mission-py.bash` -> `CONTAINER=<container_name> bin/e-mission-py.bash`
  - For all other commands (e.g. `ls`, `less`...), preface the command with `CONTAINER=<container_name> bin/de.bash`

##### Example

(loading test data using instructions at https://github.com/e-mission/e-mission-server#quick-start)

- The container name is `juypter-notebook_web-server_1` 

    ```
    $ docker ps -a
    CONTAINER ID        IMAGE                         COMMAND                  CREATED             STATUS              PORTS                              NAMES
    f695a6dd541d        juypter-notebook_web-server   "/usr/bin/tini -- /b…"   38 minutes ago      Up 2 minutes        8080/tcp, 0.0.0.0:8888->8888/tcp   juypter-notebook_web-server_1
    f6c2d04f8164        mongo:latest                  "docker-entrypoint.s…"   38 minutes ago      Up 2 minutes        0.0.0.0:27017->27017/tcp           juypter-notebook_db_1
    ```

- So we use it to load the test data

    ```
    $ CONTAINER=juypter-notebook_web-server_1 bin/e-mission-py.bash bin/debug/load_timeline_for_day_and_user.py emission/tests/data/real_examples/shankari_2015-07-22 test_july_22
    ARGS=bin/debug/load_timeline_for_day_and_user.py emission/tests/data/real_examples/shankari_2015-07-22 test_july_22
    Connecting to database URL db
    emission/tests/data/real_examples/shankari_2015-07-22
    Loading file emission/tests/data/real_examples/shankari_2015-07-22
    After registration, test_july_22 -> f433f23a-e31c-4d13-87a6-e3063126e9fc
    Finished loading 0 entries into the usercache and 1906 entries into the timeseries
    ```

- or if we want to see what notebooks we have saved

    ```
    $ CONTAINER=juypter-notebook_web-server_1 bin/de.bash ls saved-notebooks/*.ipynb
    ARGS=ls saved-notebooks/*.ipynb
    saved-notebooks/Check_persistence.ipynb
    ```

### Tweaking the image
(inspired by [nextcloud](https://github.com/nextcloud/docker/#adding-features))

Sometimes, you might want to customize the image by changing the startup script
or installing other utility software. In general, this is not a great idea
because the whole point of using a microservices architecture is to compose
your solution using multiple independent parts. But sometimes, you just want to
add one more package or change the configuration slightly. You can do this in
`docker-compose.yml` by using `build` instead of `image` (see the [jupyter
notebook example](examples/juypter-notebook/)).

In this case, you need to run one extra step to update your built image
container when the e-mission image is updated.

```
docker-compose -f <path_to_docker-compose.yml> build --pull
docker-compose -f <path_to_docker-compose.yml> up -d
```

### Using a docker container for development
This is not a great idea, because the point of using containers is to have
slimmed-down micro services with reproducible deployments. So you shouldn't
really load a lot of editors into container, and by default, you can't edit the
code files outside the container. You should really use the [manual install](https://github.com/e-mission/e-mission-docs/blob/master/docs/e-mission-server/manual_install.md)
instead.

If you really want to edit the source code in the docker image, you can try
[the wisdom of the internet](https://stackoverflow.com/a/43548695), but we have
not tested any of the approaches.

### Connecting to the created container
After you have created the container, you will probably want to connect to a
server running on it. The host to use for the connection is a bit tricky.
  * In general, you will use `localhost`, so 
    * for the e-mission server, [http://localhost:8080](http://localhost:8080)
    * for an ipython notebook, [http://localhost:8888](http://localhost:8888)
  * On **windows**, this [does not work](https://github.com/docker/for-win/issues/204)
    * Try `localhost` -> `host.docker.internal`
    * Try `localhost` -> `<docker_machine_ip>`, where you can get the `docker_machine_ip` using `ipconfig`. Try all the IP addresses you find there.
  * In **the android emulator** using chrome, there is a [special IP for the current host](https://developer.android.com/tools/devices/emulator.html#networkaddresses)
    * Try `localhost` -> `10.0.2.2`

### Docker Build Instructions

#### e-mission-server image

There are two main `e-mission-server` tags.
  - The default uses the [mkl optimizations](https://docs.anaconda.com/mkl-optimizations/)
  - the `nomkl` versions are [smaller and less optimized](https://github.com/e-mission/e-mission-server/pull/637)

1. Build local docker image

   ```
   docker build -f Dockerfile -t emission/e-mission-server:latest .
   docker build -f Dockerfile.nomkl -t emission/e-mission-server:nomkl-latest .
   ```

1. Tag the release (make sure you are in the owners group for emission, or
    replace emission by your own namespace)

   ```
   docker tag emission/e-mission-server:latest emission/e-mission-server:<version>
   docker tag emission/e-mission-server:nomkl-latest emission/e-mission-server:nomkl-<version>
   ```
   
1. Push the release 

   ```
   docker login
   docker push emission/e-mission-server:<version>
   docker push emission/e-mission-server:latest
   docker push emission/e-mission-server:nomkl-<version>
   docker push emission/e-mission-server:nomkl-latest
   ```

