<?php
include 'conexion.php';

$query = "SELECT * FROM level_app";
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