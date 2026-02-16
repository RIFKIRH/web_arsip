FROM dunglas/frankenphp:php8.2-bookworm

RUN install-php-extensions \
    gd \
    zip \
    pdo_mysql \
    mbstring \
    exif \
    pcntl \
    bcmath \
    intl

WORKDIR /app

COPY . .

RUN composer install --optimize-autoloader --no-interaction

RUN php artisan config:cache \
 && php artisan route:cache \
 && php artisan view:cache

CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8080"]
