FROM php:8.3-cli

# Install system dependencies + Node.js
RUN apt-get update && apt-get install -y \
    git unzip zip curl libzip-dev libpng-dev libjpeg-dev libfreetype6-dev \
    nodejs npm \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install pdo_mysql zip gd \
    && rm -rf /var/lib/apt/lists/*

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /app

# Copy composer files dulu (biar cache optimal)
COPY composer.json composer.lock ./
RUN composer install --no-interaction --optimize-autoloader --no-dev

# Copy package.json dulu (biar cache optimal)
COPY package.json package-lock.json* ./
RUN npm install

# Copy seluruh project
COPY . .

# Build frontend
RUN npm run build

EXPOSE 8080

CMD php artisan config:clear && \
    php artisan migrate --seed --force && \
    php artisan serve --host=0.0.0.0 --port=${PORT:-8080}