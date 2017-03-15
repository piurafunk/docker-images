FROM php:5.6-alpine
ENV app_name=app
WORKDIR /home/www-data/$app_name

COPY buildscript startupscript /
RUN chmod +x /buildscript /startupscript
RUN /buildscript
ENV PATH $PATH:/usr/local/share/nodejs/bin
USER www-data
CMD ["/startupscript"]
