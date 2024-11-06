FROM wordpress:6.4-php8.2-apache

# Install and configure Apache modules
RUN a2enmod rewrite headers ssl && \
    # Configure PHP
    echo "\
memory_limit = 256M\n\
upload_max_filesize = 64M\n\
post_max_size = 64M\n\
max_execution_time = 300\
" > /usr/local/etc/php/conf.d/wordpress.ini

# Set Apache environment variables
ENV APACHE_RUN_USER=www-data \
    APACHE_RUN_GROUP=www-data \
    APACHE_LOG_DIR=/var/log/apache2 \
    APACHE_PID_FILE=/var/run/apache2/apache2.pid \
    APACHE_RUN_DIR=/var/run/apache2 \
    APACHE_LOCK_DIR=/var/lock/apache2 \
    PORT=80

# Create necessary directories and set permissions
RUN mkdir -p /var/run/apache2 /var/lock/apache2 && \
    chown -R www-data:www-data /var/run/apache2 /var/lock/apache2 /var/www/html

# Configure Apache with heredoc syntax
RUN cat >> /etc/apache2/apache2.conf << 'EOL'
ServerName localhost

<Directory /var/www/html/>
    Options Indexes FollowSymLinks
    AllowOverride All
    Require all granted
</Directory>

<IfModule mod_ssl.c>
    SetEnvIf X-Forwarded-Proto https HTTPS=on
</IfModule>
EOL

# Create start script with heredoc syntax
RUN cat > /usr/local/bin/docker-start.sh << 'EOL'
#!/bin/bash

if [ ! -f /var/www/html/wp-config.php ]; then
    cp -r /usr/src/wordpress/* /var/www/html/
    chown -R www-data:www-data /var/www/html
fi

# Create or update .htaccess
cat > /var/www/html/.htaccess << 'EOF'
# BEGIN WordPress
<IfModule mod_rewrite.c>
RewriteEngine On
RewriteCond %{HTTP:X-Forwarded-Proto} !https
RewriteRule ^(.*)$ https://%{HTTP_HOST}%{REQUEST_URI} [L,R=301]
RewriteBase /
RewriteRule ^index\.php$ - [L]
RewriteCond %{REQUEST_FILENAME} !-f
RewriteCond %{REQUEST_FILENAME} !-d
RewriteRule . /index.php [L]
</IfModule>
# END WordPress
EOF

# Set proper permissions
chown -R www-data:www-data /var/www/html
find /var/www/html -type d -exec chmod 755 {} \;
find /var/www/html -type f -exec chmod 644 {} \;

exec apache2-foreground
EOL

RUN chmod +x /usr/local/bin/docker-start.sh

EXPOSE 80

CMD ["/usr/local/bin/docker-start.sh"]