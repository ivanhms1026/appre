<?php
include 'conexion.php'; // Importa tu archivo de conexión a la base de datos

$query = "SELECT * FROM user_app WHERE id_level = 3";
$result = $connect->query($query);

$users = array();

if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $users[] = $row;
    }
}

header('Content-Type: application/json');
echo json_encode($users);

$connect->close();
?>
