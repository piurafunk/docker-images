FROM php:5.6-alpine
ENV app_name=app
WORKDIR /home/www-data/$app_name

COPY buildscript /
RUN chmod +x /buildscript
RUN /buildscript

COPY startupscript /
RUN chmod +x /startupscript

USER www-data
ENV PATH $PATH:/usr/local/share/nodejs/bin

EXPOSE 80 443

ENTRYPOINT ["/startupscript"]
