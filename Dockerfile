# python 3
FROM ubuntu:focal

MAINTAINER K. Shankari (shankari@eecs.berkeley.edu)

WORKDIR /usr/src/app

RUN apt-get update
RUN apt-get install -y curl
RUN apt-get install -y git

# install nano and vim for editing
RUN apt-get -y install nano vim

# cleanup
RUN apt-get -y remove --purge build-essential
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ARG SERVER_REPO
ENV SERVER_REPO=${SERVER_REPO:-https://github.com/e-mission/e-mission-server.git}

ARG SERVER_BRANCH
ENV SERVER_BRANCH=${SERVER_BRANCH:-master}

ADD clone_server.sh /clone_server.sh
RUN chmod u+x /clone_server.sh
ADD index.html /index.html

# This clone puts the server code into the image, not the container
RUN bash -c "/clone_server.sh"

#declare environment variables
ENV DB_HOST=''
ENV WEB_SERVER_HOST=''

ENV LIVERELOAD_SRC=''
ADD start_script.sh /start_script.sh
RUN chmod u+x /start_script.sh

EXPOSE 8080

CMD ["/bin/bash", "/start_script.sh"]
