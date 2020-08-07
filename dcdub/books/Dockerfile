FROM php:7.3.8-apache

RUN apt-get update && apt-get install -y \
        git \
        jq \
        libicu-dev \
        unzip \
        zip && \
    apt-get clean

RUN docker-php-ext-install intl pdo_mysql

COPY --from=composer:1.8.6 /usr/bin/composer /usr/bin/composer

ENV PATH=$PATH:/var/www/html/vendor/bin
ENV APACHE_DOCUMENT_ROOT /var/www/html/public
ENV USER_ID=${USER_ID:-1000}
ENV GROUP_ID=${GROUP_ID:-1000}

RUN groupadd -g 999 docker

RUN useradd -r -u $USER_ID -G docker user

RUN chown user: /var/www -R

RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}\n\t<Directory "${APACHE_DOCUMENT_ROOT}">\n\t\tOptions FollowSymLinks\n\t\tAllowOverride All\n\t</Directory>!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf
RUN ln -s /etc/apache2/mods-available/rewrite.load /etc/apache2/mods-enabled/rewrite.load

USER user
