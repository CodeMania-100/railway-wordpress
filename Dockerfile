FROM wordpress:6.4-php8.2-apache

# Enable Apache modules
RUN a2enmod rewrite
RUN a2enmod ssl
RUN a2enmod headers

# Configure PHP
RUN { \
    echo 'memory_limit = 256M'; \
    echo 'upload_max_filesize = 64M'; \
    echo 'post_max_size = 64M'; \
    echo 'max_execution_time = 300'; \
} > /usr/local/etc/php/conf.d/wordpress.ini

# Create start script with HTTPS configurations
RUN echo '#!/bin/bash\n\
# Add HTTPS headers\n\
cat > /etc/apache2/conf-available/security.conf << EOL\n\
Header set Content-Security-Policy "upgrade-insecure-requests"\n\
Header always set Strict-Transport-Security "max-age=31536000; includeSubDomains"\n\
EOL\n\
\n\
a2enconf security\n\
\n\
# Update WordPress URLs to HTTPS\n\
sed -i "s/http:\/\//https:\/\//g" /var/www/html/wp-includes/js/*.js\n\
sed -i "s/http:\/\//https:\/\//g" /var/www/html/wp-includes/css/*.css\n\
\n\
apache2 -D FOREGROUND' > /usr/local/bin/docker-start.sh && \
    chmod +x /usr/local/bin/docker-start.sh

# Set permissions
RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html

EXPOSE 80
ENV PORT=80

CMD ["/usr/local/bin/docker-start.sh"]