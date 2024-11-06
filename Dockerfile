FROM wordpress:6.4-php8.2-apache

# Remove any existing CMD or ENTRYPOINT
ENTRYPOINT []
CMD []

# Configure PHP
RUN { \
    echo 'memory_limit = 256M'; \
    echo 'upload_max_filesize = 64M'; \
    echo 'post_max_size = 64M'; \
    echo 'max_execution_time = 300'; \
} > /usr/local/etc/php/conf.d/wordpress.ini

# Set up Apache
RUN a2enmod rewrite

# Update Apache configuration
RUN echo "Listen \${PORT}" > /etc/apache2/ports.conf && \
    sed -i 's/Listen 80/Listen ${PORT}/g' /etc/apache2/sites-available/000-default.conf

# Set permissions
RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_PID_FILE /var/run/apache2/apache2.pid
ENV APACHE_RUN_DIR /var/run/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2

RUN mkdir -p /var/run/apache2 /var/lock/apache2 && \
    chown -R www-data:www-data /var/run/apache2 /var/lock/apache2

# Remove default start scripts
RUN rm -f /usr/local/bin/docker-entrypoint.sh

# Create our own start script
RUN echo '#!/bin/bash\n\
apache2 -DFOREGROUND' > /usr/local/bin/docker-start.sh && \
    chmod +x /usr/local/bin/docker-start.sh

EXPOSE 80
ENV PORT=80

CMD ["/usr/local/bin/docker-start.sh"]