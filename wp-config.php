<?php
// Database settings
define('DB_NAME', getenv('MYSQL_DATABASE'));
define('DB_USER', getenv('MYSQLUSER'));
define('DB_PASSWORD', getenv('MYSQLPASSWORD'));
define('DB_HOST', getenv('MYSQLHOST'));
define('DB_CHARSET', 'utf8');
define('DB_COLLATE', '');

$table_prefix = 'wp_';

// Authentication keys and salts
define('AUTH_KEY',         getenv('AUTH_KEY'));
define('SECURE_AUTH_KEY',  getenv('SECURE_AUTH_KEY'));
define('LOGGED_IN_KEY',    getenv('LOGGED_IN_KEY'));
define('NONCE_KEY',        getenv('NONCE_KEY'));
define('AUTH_SALT',        getenv('AUTH_SALT'));
define('SECURE_AUTH_SALT', getenv('SECURE_AUTH_SALT'));
define('LOGGED_IN_SALT',   getenv('LOGGED_IN_SALT'));
define('NONCE_SALT',       getenv('NONCE_SALT'));

// Site URLs
define('WP_HOME', 'https://railway-wordpress-production-56c1.up.railway.app');
define('WP_SITEURL', 'https://railway-wordpress-production-56c1.up.railway.app');

// SSL and cookie settings
define('FORCE_SSL_ADMIN', true);
define('COOKIE_DOMAIN', '');  // Leave empty to allow all domains
define('COOKIEPATH', '/');
define('SITECOOKIEPATH', '/');
define('ADMIN_COOKIE_PATH', '/wp-admin');

// Handle reverse proxy
if (isset($_SERVER['HTTP_X_FORWARDED_PROTO']) && $_SERVER['HTTP_X_FORWARDED_PROTO'] === 'https') {
    $_SERVER['HTTPS'] = 'on';
}
if (isset($_SERVER['HTTP_X_FORWARDED_FOR'])) {
    $list = explode(',', $_SERVER['HTTP_X_FORWARDED_FOR']);
    $_SERVER['REMOTE_ADDR'] = trim($list[0]);
}

// Debug settings
define('WP_DEBUG', false);
define('WP_DEBUG_LOG', false);
define('WP_DEBUG_DISPLAY', false);

// Additional settings
define('FS_METHOD', 'direct');
define('DISABLE_WP_CRON', true);

if (!defined('ABSPATH')) {
    define('ABSPATH', dirname(__FILE__) . '/');
}
// Force admin SSL but allow flexible SSL detection
define('FORCE_SSL_ADMIN', true);
if (strpos($_SERVER['HTTP_X_FORWARDED_PROTO'], 'https') !== false) {
    $_SERVER['HTTPS']='on';
    define('FORCE_SSL_ADMIN',true);
    define('FORCE_SSL_LOGIN',true);
}

// Set cookie domain and path explicitly
define('COOKIE_DOMAIN', '');
define('COOKIEPATH', '/');
define('SITECOOKIEPATH', '/');
define('ADMIN_COOKIE_PATH', '/wp-admin');

// Allow direct file system access

define('WP_TEMP_DIR', ABSPATH . 'wp-content/temp');


// Additional security headers
header('X-Content-Type-Options: nosniff');
header('X-Frame-Options: SAMEORIGIN');
header('X-XSS-Protection: 1; mode=block');

require_once(ABSPATH . 'wp-settings.php');