FROM composer:2.4.4 as builder

FROM php:7.4.33-fpm-alpine3.15 as final
WORKDIR /app
RUN apk update && apk add --no-cache \
    build-base shadow \
    php7 \
    php7-fpm \
    php7-common \
    php7-xml \
    php7-openssl \
    php7-json \
    php7-phar \
    php7-gmp \
    php7-zip \
    php7-curl \
    php7-gd \
    php7-xmlrpc \
    php7-mbstring \
    php7-intl \
    php7-dom \
    php7-soap \
    php7-session \
    php7-zlib \
    libpng \
    libpng-dev \
    freetype-dev \
    libjpeg-turbo-dev \
    && apk add --no-cache $PHPIZE_DEPS \
    && pecl install apcu \
    && pecl install apcu_bc-1.0.5 \
    && docker-php-ext-enable apcu --ini-name 10-docker-php-ext-apcu.ini \
    && docker-php-ext-enable apc --ini-name 20-docker-php-ext-apc.ini \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd --ini-name 30-docker-php-ext-gd.ini\
    && apk del libpng-dev \
    && apk del libjpeg-turbo-dev \
    && rm -rf /var/cache/apk/* \
    && usermod -u 101 www-data \
    && sed -i 's|;date.timezone|date.timezone="UTC"|g' /etc/php7/php.ini
COPY --from=builder /usr/bin/composer /usr/bin/composer
RUN composer create-project --no-plugins livetyping/hermitage-skeleton . \
    && chown -R 101:101 /app
USER www-data
EXPOSE 9000
CMD ["php-fpm"]

