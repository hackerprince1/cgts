<?php
/*
|--------------------------------------------------------------------------
| CGTSTest.com
| Database Configuration
|--------------------------------------------------------------------------
*/

date_default_timezone_set('Asia/Kolkata');

define('SITE_NAME', 'CGTSTest.com');
define('SITE_URL', 'http://localhost');   // बाद में Domain डालेंगे

define('DB_HOST', 'localhost');
define('DB_NAME', 'cgtstest');
define('DB_USER', 'root');
define('DB_PASS', '');

$conn = mysqli_connect(DB_HOST, DB_USER, DB_PASS, DB_NAME);

if (!$conn) {
    die("Database Connection Failed : " . mysqli_connect_error());
}

mysqli_set_charset($conn, "utf8mb4");

session_start();

?>
