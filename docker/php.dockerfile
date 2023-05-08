FROM php:8.1.0-fpm-alpine

RUN addgroup -g 1000 laravel && adduser -G laravel -g laravel -s /bin/sh -D laravel

RUN mkdir -p /var/www/html

RUN chown laravel:laravel /var/www/html

WORKDIR /var/www/html

# && pecl install redis \
# && docker-php-ext-enable redis \

# imagick
RUN apk add --update --no-cache autoconf g++ imagemagick imagemagick-dev libtool make pcre-dev \
    && pecl install imagick \
    && docker-php-ext-enable imagick \
    && apk del autoconf g++ libtool make pcre-dev

RUN apk add --no-cache libc-dev libzip-dev libpng libpng-dev libjpeg-turbo-dev libwebp-dev zlib-dev libxpm-dev freetype-dev jpegoptim pngquant optipng \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd  \
    && docker-php-ext-install exif \
    && docker-php-ext-install pdo pdo_mysql \
    && apk del libpng-dev