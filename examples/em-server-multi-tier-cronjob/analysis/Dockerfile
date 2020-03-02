# python 3
FROM emission/e-mission-server:latest

# CHANGEME: If you want to run from a different branch, change the <branch> below 
# to the branch that you want to run
# RUN git fetch origin <branch>
# RUN git checkout -f <branch>

RUN pip install devcron

# CHANGEME: Configure push if necessary
# COPY conf/net/ext_service/push.json /usr/src/app/conf/net/ext_service/push.json

# CHANGEME: Default crontab runs the regular intake pipeline every hour at 5
# mins past the hour. Also includes some additional commented out scripts.
# Replace by your own if you need any other periodic invocations
COPY crontab /usr/src/app/crontab
COPY start_cron.sh /usr/src/app/start_cron.sh

CMD ["/bin/bash", "/usr/src/app/start_cron.sh"]
