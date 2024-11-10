<?php
define('DB_NAME', getenv('MYSQL_DATABASE'));
define('DB_USER', getenv('MYSQLUSER'));
define('DB_PASSWORD', getenv('MYSQLPASSWORD'));
define('DB_HOST', getenv('MYSQLHOST'));
define('DB_CHARSET', 'utf8');
define('DB_COLLATE', '');

$table_prefix = 'wp2_';

define('WP_DEBUG', true);
define('WP_DEBUG_LOG', true);
define('WP_DEBUG_DISPLAY', false);

define('FORCE_SSL_ADMIN', true);
if (isset($_SERVER['HTTP_X_FORWARDED_PROTO']) && $_SERVER['HTTP_X_FORWARDED_PROTO'] === 'https') {
    $_SERVER['HTTPS'] = 'on';
}

define('WP_HOME', 'https://railway-wordpress-production-56c1.up.railway.app');
define('WP_SITEURL', 'https://railway-wordpress-production-56c1.up.railway.app');

if (!defined('ABSPATH')) {
    define('ABSPATH', dirname(__FILE__) . '/');
}

define('SCRIPT_DEBUG', true);
define('CONCATENATE_SCRIPTS', false);

// Force direct filesystem access
define('FS_METHOD', 'direct');

// Disable WP Cron
define('DISABLE_WP_CRON', true);

// Allow unfiltered HTML for administrators
define('ALLOW_UNFILTERED_UPLOADS', true);

error_reporting(E_ALL);
ini_set('display_errors', 1);

require_once(ABSPATH . 'wp-settings.php');