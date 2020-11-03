# python 3
FROM ubuntu:latest

MAINTAINER K. Shankari (shankari@eecs.berkeley.edu)
# set working directory
WORKDIR /usr/src/app

RUN apt-get update
RUN apt-get install -y curl
RUN apt-get install -y git

# clone from repo
RUN git clone https://github.com/e-mission/e-mission-server.git
WORKDIR /usr/src/app/e-mission-server

# setup python environment.
RUN bash -c 'source setup/setup_conda.sh Linux-x86_64; \
source setup/setup.sh'

RUN bash -c 'source setup/activate_conda.sh; conda clean -t; conda clean -p'

# install nano and vim for editing
RUN apt-get -y install nano vim

# cleanup
RUN apt-get -y remove --purge build-essential
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#declare environment variables
ENV DB_HOST=''
ENV WEB_SERVER_HOST=''

#add start script.
# this is a redundant workdir setting, but it doesn't harm anything and might
# be useful if the other one is removed for some reason
WORKDIR /usr/src/app/e-mission-server
ADD start_script.sh /usr/src/app/e-mission-server/start_script.sh
ADD index.html /usr/src/app/e-mission-server/webapp/www/index.html
RUN chmod u+x /usr/src/app/e-mission-server/start_script.sh

EXPOSE 8080

CMD ["/bin/bash", "/usr/src/app/e-mission-server/start_script.sh"]
