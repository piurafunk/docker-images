FROM node:alpine
USER node
VOLUME /code
WORKDIR /code

ADD build_script.sh startup_script.sh /

RUN build_script.sh

CMD ["/startup_script.sh"]
