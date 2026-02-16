FROM dunglas/frankenphp:1-php8.3-bookworm


# Install dependencies sistem
RUN apt-get update && apt-get install -y \
    git unzip zip curl \
    && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN install-php-extensions \
    gd \
    zip \
    pdo_mysql \
    mbstring \
    exif \
    pcntl \
    bcmath \
    intl

# Install Composer secara manual (lebih aman)
RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer

WORKDIR /app

COPY . .

RUN composer install --optimize-autoloader --no-interaction

RUN php artisan config:cache \
 && php artisan route:cache \
 && php artisan view:cache

RUN php artisan config:clear \
 && php artisan cache:clear


EXPOSE 8080

CMD php artisan serve --host=0.0.0.0 --port=$PORT


