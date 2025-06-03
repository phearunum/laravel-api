FROM php:8.2-fpm 

# Install system dependencies
RUN apt-get update && apt-get install -y \
    nginx \
    supervisor \
    git \
    curl \
    zip \
    unzip \
    libzip-dev \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    libicu-dev \
    && docker-php-ext-install pdo pdo_mysql mbstring zip exif pcntl bcmath xml intl curl

# Set working directory
WORKDIR /var/www/html

# Copy Laravel project
COPY . /var/www/html

# Copy nginx config
COPY nginx.conf /etc/nginx/nginx.conf

# Set permissions
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copy supervisord config
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Set environment variables
ENV APP_ENV=production
ENV APP_DEBUG=false
ENV APP_KEY=base64:WZ9qYrj8+3gKlzJp7PcM7c3RFVXt3PZxJDFUluywZcE=
ENV DB_CONNECTION=mysql
ENV DB_HOST=194.233.95.128
ENV DB_PORT=3306
ENV DB_DATABASE=laravel_db
ENV DB_USERNAME=laravel_db
ENV DB_PASSWORD=yFbpShGyrehBtGxx

# Expose web port
EXPOSE 80

# Run supervisor (will start both PHP-FPM and Nginx)
CMD ["/usr/bin/supervisord"]
