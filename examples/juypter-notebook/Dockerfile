# python 3
FROM emission/e-mission-server

ADD start_notebook.sh /usr/src/app/start_notebook.sh
RUN chmod u+x /usr/src/app/start_notebook.sh

EXPOSE 8888

CMD ["/bin/bash", "/usr/src/app/start_notebook.sh"]
