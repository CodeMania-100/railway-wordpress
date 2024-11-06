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

# Set the entry point to Apache
CMD ["apache2-foreground"]