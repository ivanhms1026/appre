<?php

include 'conexion.php';

$user = $_POST['user']; 
$pass = $_POST['pass'];

$consultar = $connect->query("SELECT * FROM user_app WHERE email='".$user."' AND password_app='".$pass."'");

$resultado = array();

if (!$consultar) {
    $resultado = array("error" => true);
} else {
    $resultado = array("error" => false, "data" => array());
    while ($extraerDatos = $consultar->fetch_assoc()) {
        $resultado["data"][] = $extraerDatos;
    }
}

echo json_encode($resultado);
?>

