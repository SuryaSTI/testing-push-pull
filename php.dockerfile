FROM php:8.3.1-apache

COPY config/php.ini /usr/local/etc/php/php.ini
COPY config/ports.conf /etc/apache2/ports.conf

RUN service apache2 stop

RUN apt-get update && \
    apt-get install -y \
    libssl-dev \
    openssl \
    libldap2-dev \
    libxslt1-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libxml2-dev \
    libcurl4-openssl-dev \
    curl \
    libicu-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ \
    && docker-php-ext-install ldap curl gettext intl exif mysqli pdo pdo_mysql soap xsl

RUN pecl install stomp && \
    docker-php-ext-enable stomp

RUN service apache2 start

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN apt-get remove -y libssl-dev \
    openssl \
    libldap2-dev \
    libxslt1-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libxml2-dev \
    libcurl4-openssl-dev \
    curl \
    libicu-dev \
    && rm -rf /var/lib/apt/lists/*

RUN a2enmod rewrite

COPY config/apache-config.conf /etc/apache2/sites-available/000-default.conf
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

COPY src/ /var/www/html/
WORKDIR /var/www/html

EXPOSE 8888

CMD ["apache2-foreground"]
