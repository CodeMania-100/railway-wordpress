FROM wordpress:6.4-php8.2-apache

# Enable Apache modules
RUN a2enmod rewrite
RUN a2enmod headers

# Configure PHP
RUN echo "memory_limit = 256M" > /usr/local/etc/php/conf.d/wordpress.ini && \
    echo "upload_max_filesize = 64M" >> /usr/local/etc/php/conf.d/wordpress.ini && \
    echo "post_max_size = 64M" >> /usr/local/etc/php/conf.d/wordpress.ini && \
    echo "max_execution_time = 300" >> /usr/local/etc/php/conf.d/wordpress.ini

# Set Apache environment variables
ENV APACHE_RUN_USER=www-data \
    APACHE_RUN_GROUP=www-data \
    APACHE_LOG_DIR=/var/log/apache2 \
    APACHE_PID_FILE=/var/run/apache2/apache2.pid \
    APACHE_RUN_DIR=/var/run/apache2 \
    APACHE_LOCK_DIR=/var/lock/apache2

# Create necessary directories
RUN mkdir -p /var/run/apache2 /var/lock/apache2 && \
    chown -R www-data:www-data /var/run/apache2 /var/lock/apache2

# Configure Apache
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf && \
    echo "<Directory /var/www/html/>" >> /etc/apache2/apache2.conf && \
    echo "    Options Indexes FollowSymLinks" >> /etc/apache2/apache2.conf && \
    echo "    AllowOverride All" >> /etc/apache2/apache2.conf && \
    echo "    Require all granted" >> /etc/apache2/apache2.conf && \
    echo "</Directory>" >> /etc/apache2/apache2.conf

# Create start script
RUN echo '#!/bin/bash

# Create wp-config.php if it doesnt exist
if [ ! -f /var/www/html/wp-config.php ]; then
    cp -r /usr/src/wordpress/* /var/www/html/
    chown -R www-data:www-data /var/www/html
fi

# Create or update .htaccess
cat > /var/www/html/.htaccess << "EOF"
# BEGIN WordPress
<IfModule mod_rewrite.c>
RewriteEngine On
RewriteBase /
RewriteRule ^index\.php$ - [L]
RewriteCond %{REQUEST_FILENAME} !-f
RewriteCond %{REQUEST_FILENAME} !-d
RewriteRule . /index.php [L]
</IfModule>
# END WordPress
EOF

chown -R www-data:www-data /var/www/html
apache2 -DFOREGROUND' > /usr/local/bin/docker-start.sh && \
    chmod +x /usr/local/bin/docker-start.sh

# Set permissions
RUN chown -R www-data:www-data /var/www/html

EXPOSE 80
ENV PORT=80

CMD ["/usr/local/bin/docker-start.sh"]