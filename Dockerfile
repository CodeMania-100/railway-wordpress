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
RUN echo '#!/bin/bash\napache2 -DFOREGROUND' > /usr/local/bin/docker-start.sh && \
    chmod +x /usr/local/bin/docker-start.sh

# Set permissions
RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html

EXPOSE 80
ENV PORT=80

CMD ["/usr/local/bin/docker-start.sh"]