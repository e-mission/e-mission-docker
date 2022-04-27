# python 3
FROM emission/e-mission-server:4.0.0

RUN conda env update --name emission --file setup/environment36.notebook.additions.yml
RUN conda clean -t
RUN conda clean -p

ADD start_notebook.sh /usr/src/app/start_notebook.sh
RUN chmod u+x /usr/src/app/start_notebook.sh

EXPOSE 8888

CMD ["/bin/bash", "/usr/src/app/start_notebook.sh"]
