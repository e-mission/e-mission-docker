# python 3
FROM emission/e-mission-server:latest

# CHANGEME: If you want to run from a different branch, uncomment the lines
# below and change the <branch> to your target
# RUN git fetch origin <branch>
# RUN git checkout -f <branch>

# CHANGEME: Create the files that correspond to your configuration in the conf directory
# COPY conf/net/auth/google_auth.json /usr/src/app/conf/net/auth/google_auth.json
COPY conf/net/api/webserver.conf /usr/src/app/conf/net/api/webserver.conf.sample
COPY start_script.sh /usr/src/app/start_script.sh

CMD ["/bin/bash", "/usr/src/app/start_script.sh"]
