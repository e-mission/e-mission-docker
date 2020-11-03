# python 3
FROM emission/e-mission-server.dev.server-only:2.9.1

COPY conf /conf

COPY start_script.sh /usr/src/app/start_script.sh
CMD ["/bin/bash", "/usr/src/app/start_script.sh"]
