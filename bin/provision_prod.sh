#!/bin/sh
app_path=$(pwd)
# PHP
echo "Installing PHP";sleep 1;
sudo apt update
sudo apt install -y lsb-release gnupg2 ca-certificates apt-transport-https software-properties-common
sudo add-apt-repository ppa:ondrej/php
sudo apt update
sudo apt install -y php8.2 php8.2-fpm php8.2-curl php8.2-dom php8.2-mbstring php8.2-xml php8.2-sqlite3 php8.2-mysql php8.2-redis
# Redis
echo "Installing Redis";sleep 1;
sudo apt install redis
# Caddy
echo "Installing Caddy";sleep 1;
sudo apt install -y debian-keyring debian-archive-keyring apt-transport-https
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/gpg.key' | sudo gpg --dearmor -o /usr/share/keyrings/caddy-stable-archive-keyring.gpg
curl -1sLf 'https://dl.cloudsmith.io/public/caddy/stable/debian.deb.txt' | sudo tee /etc/apt/sources.list.d/caddy-stable.list
sudo apt update
sudo apt install caddy
caddy reload
echo "Setting up Supervisor for queue work";sleep 1;
sudo apt-get install supervisor
cp supervisord/horizon.conf /etc/supervisor/conf.d/
sed -i "s/app_path/$app_path/g" /etc/supervisor/conf.d/horizon.conf
sudo supervisorctl reread
sudo supervisorctl update
sudo supervisorctl start laravel-worker:*
# Application
echo "Setting up application";sleep 1;
composer install
npm install
npm run build
touch sqlite/database.sqlite
cp .env.prod.example .env
php artisan key:generate
php artisan migrate --seed
echo "Installing Laravel cron schedule";sleep 1;
crontab -l >> mycron
echo '\n'"# '* * * * * php $app_path/artisan schedule:run >> /dev/null 2>&1" >> mycron
crontab mycron
rm mycron
