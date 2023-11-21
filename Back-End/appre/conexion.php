<?php
$host = '127.0.0.1';
$username = 'root';
$password = '';
$database = 'appre';

$connect = new mysqli($host, $username, $password, $database);

if ($connect->connect_error) {
    die("Error de conexión: " . $connect->connect_error);
}

?>