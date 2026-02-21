FROM php:8.3-cli

RUN apt-get update && apt-get install -y \
    git unzip zip curl libzip-dev libpng-dev libjpeg-dev libfreetype6-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install pdo pdo_mysql zip gd \
    && rm -rf /var/lib/apt/lists/*

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /app

COPY . .

RUN composer install --no-interaction --prefer-dist --optimize-autoloader --no-dev

# kasih permission biar nggak error storage
RUN chmod -R 775 storage bootstrap/cache

EXPOSE 8080

CMD php artisan config:clear && \
    php artisan migrate --seed --force && \
    php artisan serve --host=0.0.0.0 --port=${PORT:-8080}