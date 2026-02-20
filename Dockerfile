FROM php:8.3-cli

# Install system dependencies + Node
RUN apt-get update && apt-get install -y \
    git unzip zip curl libzip-dev libpng-dev libjpeg-dev libfreetype6-dev \
    nodejs npm \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install pdo_mysql zip gd \
    && rm -rf /var/lib/apt/lists/*

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /app

# Copy seluruh project dulu (artisan harus ada sebelum composer install)
COPY . .

# Install PHP dependencies
RUN composer install --no-interaction --optimize-autoloader --no-dev



RUN php artisan config:clear && \
    php artisan config:cache && \
    php artisan route:cache && \
    php artisan view:cache

EXPOSE 8080


CMD php artisan config:clear && \
    php artisan migrate --seed --force && \
    php artisan serve --host=0.0.0.0 --port=${PORT:-8080}