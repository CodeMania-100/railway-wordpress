FROM wordpress:6.4-php8.2-apache

# Enable Apache modules
RUN a2enmod rewrite
RUN a2enmod headers

# Configure PHP
RUN { \
    echo 'memory_limit = 256M'; \
    echo 'upload_max_filesize = 64M'; \
    echo 'post_max_size = 64M'; \
    echo 'max_execution_time = 300'; \
    echo 'post_max_size = 64M'; \
} > /usr/local/etc/php/conf.d/wordpress.ini

# Set Apache environment variables
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_PID_FILE /var/run/apache2/apache2.pid
ENV APACHE_RUN_DIR /var/run/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2

# Create necessary directories
RUN mkdir -p /var/run/apache2 /var/lock/apache2 && \
    chown -R www-data:www-data /var/run/apache2 /var/lock/apache2

# Configure Apache
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf && \
    echo '<Directory /var/www/html/>' >> /etc/apache2/apache2.conf && \
    echo '    Options Indexes FollowSymLinks' >> /etc/apache2/apache2.conf && \
    echo '    AllowOverride All' >> /etc/apache2/apache2.conf && \
    echo '    Require all granted' >> /etc/apache2/apache2.conf && \
    echo '</Directory>' >> /etc/apache2/apache2.conf

# Create start script
RUN echo '#!/bin/bash\n\
\n\
# Create wp-config.php if it doesnt exist\n\
if [ ! -f /var/www/html/wp-config.php ]; then\n\
    cp -r /usr/src/wordpress/* /var/www/html/\n\
    chown -R www-data:www-data /var/www/html\n\
fi\n\
\n\
# Create or update .htaccess\n\
echo "# BEGIN WordPress\n\
<IfModule mod_rewrite.c>\n\
RewriteEngine On\n\
RewriteBase /\n\
RewriteRule ^index\\.php$ - [L]\n\
RewriteCond %{REQUEST_FILENAME} !-f\n\
RewriteCond %{REQUEST_FILENAME} !-d\n\
RewriteRule . /index.php [L]\n\
</IfModule>\n\
# END WordPress" > /var/www/html/.htaccess\n\
\n\
chown -R www-data:www-data /var/www/html\n\
apache2 -DFOREGROUND' > /usr/local/bin/docker-start.sh && \
    chmod +x /usr/local/bin/docker-start.sh

# Set permissions
RUN chown -R www-data:www-data /var/www/html

EXPOSE 80
ENV PORT=80

CMD ["/usr/local/bin/docker-start.sh"]