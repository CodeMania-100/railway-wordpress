FROM wordpress:6.4-php8.2-apache

# Enable Apache modules
RUN a2enmod rewrite

# Configure PHP
RUN { \
    echo 'memory_limit = 256M'; \
    echo 'upload_max_filesize = 64M'; \
    echo 'post_max_size = 64M'; \
    echo 'max_execution_time = 300'; \
} > /usr/local/etc/php/conf.d/wordpress.ini

# Create start script
RUN echo '#!/bin/bash\n\
apache2ctl -D FOREGROUND' > /usr/local/bin/start.sh && \
    chmod +x /usr/local/bin/start.sh

# Configure Apache
RUN sed -i "s/80/\${PORT}/g" /etc/apache2/sites-available/000-default.conf /etc/apache2/ports.conf

# Set permissions
RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html

EXPOSE 80
ENV PORT=80

USER www-data