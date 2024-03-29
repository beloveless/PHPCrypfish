# Base image
FROM ubuntu:18.04

# Set non-interactive mode
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && \
    apt-get install -y \
        software-properties-common \
        apt-transport-https \
        git \
        gcc \
        make \
        re2c \
        apache2

# Add PHP PPA for additional PHP versions
RUN add-apt-repository -y ppa:ondrej/php

# Update package lists after adding repository
RUN apt-get update

# Install specific PHP version and other packages
RUN apt-get install -y php7.2 \
    mysql-server \
    php7.2-json \
    php7.2-dev \
    libpcre3-dev \
    libboost-all-dev \
    php7.2-mysql \
    phpmyadmin

# Clone PHP-CPP repository
RUN git clone https://github.com/CopernicaMarketingSoftware/PHP-CPP.git ./PHP-CPP \
    && cd ./PHP-CPP \
    && make \
    && make install

RUN mkdir -p ./phpcrypf-ex
COPY ./src ./phpcrypf-ex

RUN ls && pwd

# Copy PHPCrypfish files
# RUN cp -r ./src ./phpcrypt-ex

# Install PHPCrypfish
RUN cd ./phpcrypf-ex \
    && make install \
    && make clean \
    && make \
    && make install \
    && phpenmod -v 7.2 phpcrypfish \
    && php -m \
    && php tes#1.php \
    && php obfus1.php \
    && ls \
    && php tes#1.php.obfuskasi 

# Set working directory
WORKDIR /var/www/html

EXPOSE 80
