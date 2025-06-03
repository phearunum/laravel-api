sudo apt update
sudo apt install -y software-properties-common
sudo add-apt-repository ppa:ondrej/php -y
sudo apt update

sudo apt install -y php8.1 php8.1-cli php8.1-fpm php8.1-mbstring php8.1-openssl php8.1-pdo php8.1-tokenizer php8.1-xml php8.1-curl php8.1-fileinfo php8.1-mysql php8.1-zip php8.1-bcmath php8.1-gd php8.1-soap php8.1-intl

php artisan key:generate
composer install --optimize-autoloader --no-dev
php artisan config:cache
php artisan route:cache
php artisan view:cache
sudo chown -R www-data:www-data storage bootstrap/cache
sudo chmod -R 775 storage bootstrap/cache

php artisan migrate

#Docker

docker build -t laravel-app .
docker run -p 9000:9000 laravel-app
