<?php
// ** Database Settings ** //
$table_prefix = getenv('WORDPRESS_TABLE_PREFIX') ?: 'wp2_';

// Force these settings
define('DB_NAME', getenv('MYSQL_DATABASE'));
define('DB_USER', getenv('MYSQLUSER'));
define('DB_PASSWORD', getenv('MYSQLPASSWORD'));
define('DB_HOST', getenv('MYSQLHOST'));
define('DB_CHARSET', 'utf8');
define('DB_COLLATE', '');

// Enable debugging
define('WP_DEBUG', true);
define('WP_DEBUG_LOG', true);
define('WP_DEBUG_DISPLAY', false);
ini_set('log_errors', true);
ini_set('error_log', '/tmp/wordpress-errors.log');

// Set site URLs
define('WP_HOME', getenv('WP_HOME'));
define('WP_SITEURL', getenv('WP_SITEURL'));

// Force SSL
define('FORCE_SSL_ADMIN', true);
if (isset($_SERVER['HTTP_X_FORWARDED_PROTO']) && $_SERVER['HTTP_X_FORWARDED_PROTO'] === 'https') {
    $_SERVER['HTTPS'] = 'on';
}

// Authentication Keys and Salts
define('AUTH_KEY',         getenv('AUTH_KEY'));
define('SECURE_AUTH_KEY',  getenv('SECURE_AUTH_KEY'));
define('LOGGED_IN_KEY',    getenv('LOGGED_IN_KEY'));
define('NONCE_KEY',        getenv('NONCE_KEY'));
define('AUTH_SALT',        getenv('AUTH_SALT'));
define('SECURE_AUTH_SALT', getenv('SECURE_AUTH_SALT'));
define('LOGGED_IN_SALT',   getenv('LOGGED_IN_SALT'));
define('NONCE_SALT',       getenv('NONCE_SALT'));

// Disable automatic updates
define('AUTOMATIC_UPDATER_DISABLED', true);
define('WP_AUTO_UPDATE_CORE', false);

// Force HTTPS for admin
define('FORCE_SSL_ADMIN', true);

// Set specific cookie settings
define('ADMIN_COOKIE_PATH', '/');
define('COOKIE_DOMAIN', '');
define('COOKIEPATH', '/');
define('SITECOOKIEPATH', '/');

// Force WordPress Address and Site Address
define('WP_HOME', 'https://railway-wordpress-production-56c1.up.railway.app');
define('WP_SITEURL', 'https://railway-wordpress-production-56c1.up.railway.app');

// Additional security
define('DISALLOW_FILE_EDIT', false);
define('WP_HTTP_BLOCK_EXTERNAL', false);

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( !defined('ABSPATH') )
    define('ABSPATH', dirname(__FILE__) . '/');

/** Sets up WordPress vars and included files. */
require_once(ABSPATH . 'wp-settings.php');