FROM php:8.1

# Installer les dépendances nécessaires
RUN apt-get update && \
    apt-get install -y \
    git \
    unzip \
    libzip-dev \
    && docker-php-ext-install zip pdo_mysql

# Installer Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

EXPOSE 9000

WORKDIR /var/www/html
COPY . /var/www/html
COPY wait-for-it.sh /wait-for-it.sh
RUN chmod +x /wait-for-it.sh

# Installer les dépendances PHP
RUN composer install
RUN php artisan key:generate

CMD /wait-for-it.sh mysql:3306 --timeout=30 -- php artisan key:generate && php artisan migrate:fresh --seed