<?php
require_once('wp-load.php');

echo "<pre>";
echo "Current User Info:\n";
echo "----------------\n";
var_dump(wp_get_current_user());

echo "\nCurrent Cookies:\n";
echo "--------------\n";
var_dump($_COOKIE);

echo "\nCurrent Session:\n";
echo "---------------\n";
var_dump($_SESSION);

echo "\nServer Variables:\n";
echo "----------------\n";
var_dump($_SERVER);
echo "</pre>";