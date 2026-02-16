FROM dunglas/frankenphp:php8.2-bookworm

# Install PHP extensions yang dibutuhkan
RUN install-php-extensions \
    gd \
    zip \
    pdo_mysql \
    mbstring \
    exif \
    pcntl \
    bcmath \
    intl

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /app

COPY . .

# Install dependency Laravel
RUN composer install --optimize-autoloader --no-interaction

# Cache config biar production ready
RUN php artisan config:cache \
 && php artisan route:cache \
 && php artisan view:cache

EXPOSE 8080

CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8080"]
