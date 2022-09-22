# python 3
FROM shankari/e-mission-server:master_2022-09-22--20-37

COPY conf /conf

COPY start_script.sh /usr/src/app/.docker/start_script.sh
CMD ["/bin/bash", "/usr/src/app/.docker/start_script.sh"]
