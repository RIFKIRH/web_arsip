FROM dunglas/frankenphp:1-php8.3-bookworm

RUN apt-get update && apt-get install -y \
    git unzip zip curl \
    && rm -rf /var/lib/apt/lists/*

RUN install-php-extensions \
    gd \
    zip \
    pdo_mysql \
    mbstring \
    exif \
    pcntl \
    bcmath \
    intl

RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer

WORKDIR /app

COPY . .

RUN composer install --optimize-autoloader --no-interaction

# Jangan cache config saat build!

EXPOSE 8080

CMD php artisan config:clear && \
    php artisan cache:clear && \
    php artisan migrate --force && \
    frankenphp php-server --port=$PORT --host=0.0.0.0 public/index.php
