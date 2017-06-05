FROM openjdk:jre-alpine
ADD startup_script.sh /startup_script.sh
WORKDIR /srv/minecraft
RUN apk add openssl --no-cache && adduser -D -h /srv/minecraft mc && chown mc: /srv/minecraft -R && chmod g+s /srv/minecraft && chmod +x /startup_script.sh
USER mc
CMD ["/startup_script.sh"]
