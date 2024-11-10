<?php
define('WP_USE_THEMES', false);
require_once('wp-load.php');

error_reporting(E_ALL);
ini_set('display_errors', 1);

echo "<h2>WordPress Admin Access Test</h2>";

// Test user authentication
$current_user = wp_get_current_user();
echo "<p>Current User ID: " . $current_user->ID . "</p>";
echo "<p>Current User Roles: ";
print_r($current_user->roles);
echo "</p>";

// Test admin cookie
echo "<p>Admin Cookie Path: " . ADMIN_COOKIE_PATH . "</p>";
echo "<p>Cookie Domain: " . COOKIE_DOMAIN . "</p>";

// Test server variables
echo "<h3>Server Variables:</h3>";
echo "<p>REQUEST_URI: " . $_SERVER['REQUEST_URI'] . "</p>";
echo "<p>SCRIPT_NAME: " . $_SERVER['SCRIPT_NAME'] . "</p>";
echo "<p>PHP_SELF: " . $_SERVER['PHP_SELF'] . "</p>";
echo "<p>HTTP_HOST: " . $_SERVER['HTTP_HOST'] . "</p>";
echo "<p>HTTPS: " . (isset($_SERVER['HTTPS']) ? $_SERVER['HTTPS'] : 'not set') . "</p>";
echo "<p>HTTP_X_FORWARDED_PROTO: " . (isset($_SERVER['HTTP_X_FORWARDED_PROTO']) ? $_SERVER['HTTP_X_FORWARDED_PROTO'] : 'not set') . "</p>";

// Test wp-admin access
$admin_url = admin_url();
echo "<p>Admin URL: " . $admin_url . "</p>";

// Test headers
echo "<h3>Response Headers:</h3>";
foreach (headers_list() as $header) {
    echo $header . "<br>";
}