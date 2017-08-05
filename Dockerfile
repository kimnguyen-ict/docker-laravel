FROM ubuntu:16.04

MAINTAINER Kim Nguyen <kimnguyen.ict@gmail.com>

RUN apt-get update \
    && apt-get install -y language-pack-en-base

RUN locale-gen en_US.UTF-8

ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV LC_TYPE=UTF-8
ENV TERM xterm

RUN apt-get install -y software-properties-common

RUN add-apt-repository ppa:ondrej/php \
    && apt-get update \
    && apt-get install -y --force-yes \
        php7.1 \
        php7.1-cli \
        php7.1-curl \
        php7.1-mbstring \
        php7.1-json \
        php7.1-dom \
        php7.1-zip \
        php7.1-gd \
        php7.1-mysql \
        php7.1-soap \
        libapache2-mod-php7.1 \
        git \
        curl

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN curl -sL https://deb.nodesource.com/setup_7.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g yarn eslint

RUN echo "export PATH=$PATH:/root/.composer/vendor/bin:/var/www/laravel/vendor/bin" >> ~/.bashrc

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /var/www/laravel
