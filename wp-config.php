<?php $table_prefix = getenv('WORDPRESS_TABLE_PREFIX') ?: 'wp2_';

// Force these settings
define('WORDPRESS_DB_HOST', getenv('MYSQLHOST'));
define('WORDPRESS_DB_NAME', getenv('MYSQL_DATABASE'));
define('WORDPRESS_DB_USER', getenv('MYSQLUSER'));
define('WORDPRESS_DB_PASSWORD', getenv('MYSQLPASSWORD'));

// Enable debugging
define('WP_DEBUG', true);
define('WP_DEBUG_LOG', true);
define('WP_DEBUG_DISPLAY', true);

// Generate these using https://api.wordpress.org/secret-key/1.1/salt/
define('AUTH_KEY',         getenv('AUTH_KEY'));
define('SECURE_AUTH_KEY',  getenv('SECURE_AUTH_KEY'));
define('LOGGED_IN_KEY',    getenv('LOGGED_IN_KEY'));
define('NONCE_KEY',        getenv('NONCE_KEY'));
define('AUTH_SALT',        getenv('AUTH_SALT'));
define('SECURE_AUTH_SALT', getenv('SECURE_AUTH_SALT'));
define('LOGGED_IN_SALT',   getenv('LOGGED_IN_SALT'));
define('NONCE_SALT',      getenv('NONCE_SALT'));

// Add this to force SSL/HTTPS:
if (isset($_SERVER['HTTP_X_FORWARDED_PROTO']) && $_SERVER['HTTP_X_FORWARDED_PROTO'] === 'https') {
    $_SERVER['HTTPS'] = 'on';
}