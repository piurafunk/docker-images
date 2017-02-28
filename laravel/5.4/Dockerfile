FROM php:latest
ARG app_name=app
ENV app_name $app_name
WORKDIR /home/php/$app_name

COPY buildscript startupscript /
RUN chmod +x /buildscript /startupscript
RUN /buildscript
USER php
CMD ["/startupscript"]
