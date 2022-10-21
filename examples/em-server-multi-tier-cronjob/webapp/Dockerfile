# python 3
ARG SERVER_IMAGE_TAG=master_2022-10-09--26-05

FROM shankari/e-mission-server:${SERVER_IMAGE_TAG}

COPY conf /conf

COPY start_script.sh /usr/src/app/.docker/start_script.sh
CMD ["/bin/bash", "/usr/src/app/.docker/start_script.sh"]
