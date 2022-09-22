# python 3
FROM agutt/e-mission-server:ceo_ebike_project_2022-09-19--45-23

COPY conf /conf

# CHANGEME: Default crontab runs the regular intake pipeline every hour at 5
# mins past the hour. Also includes some additional commented out scripts.
# Replace by your own if you need any other periodic invocations
COPY crontab /usr/src/app/.docker/crontab
COPY start_cron.sh /usr/src/app/.docker/start_cron.sh

CMD ["/bin/bash", "/usr/src/app/.docker/start_cron.sh"]
