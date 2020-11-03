# python 3
FROM emission/e-mission-server.dev.server-only:2.9.1

COPY conf /conf

# CHANGEME: Default crontab runs the regular intake pipeline every hour at 5
# mins past the hour. Also includes some additional commented out scripts.
# Replace by your own if you need any other periodic invocations
COPY crontab /usr/src/app/crontab
COPY start_cron.sh /usr/src/app/start_cron.sh

CMD ["/bin/bash", "/usr/src/app/start_cron.sh"]
