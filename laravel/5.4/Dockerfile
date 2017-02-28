FROM php:latest
ENV app_name=app
WORKDIR /home/php

COPY buildscript startupscript /
RUN chmod +x /buildscript /startupscript
RUN /buildscript
ENV PATH $PATH:/usr/local/share/nodejs/bin
USER php
CMD ["/startupscript"]
