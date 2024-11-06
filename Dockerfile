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

# Copy WordPress files from default location
RUN cp -r /usr/src/wordpress/. /var/www/html/ && \
    chown -R www-data:www-data /var/www/html

# Create start script
RUN echo '#!/bin/bash\n\
if [ ! -f /var/www/html/wp-config.php ]; then\n\
    # Copy WordPress if not exists\n\
    cp -r /usr/src/wordpress/. /var/www/html/\n\
    chown -R www-data:www-data /var/www/html\n\
fi\n\
apache2 -DFOREGROUND' > /usr/local/bin/docker-start.sh && \
    chmod +x /usr/local/bin/docker-start.sh

EXPOSE 80
ENV PORT=80

CMD ["/usr/local/bin/docker-start.sh"]