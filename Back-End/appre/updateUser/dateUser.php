<?php
include '../conexion.php'; 

// Recibir el ID del usuario como parámetro
$userId = $_POST["userId"];

// Crear una consulta SQL para obtener todos los datos del usuario con el ID proporcionado
$sql = "SELECT * FROM user_app WHERE id = ?";
$stmt = $connect->prepare($sql);
$stmt->bind_param("i", $userId);

if ($stmt->execute()) {
    // Éxito en la ejecución de la consulta
    $result = $stmt->get_result();
    $userData = $result->fetch_assoc();

    // Devolver los datos del usuario en formato JSON
    echo json_encode($userData);
} else {
    // Error en la ejecución de la consulta
    echo json_encode(['error' => 'Error al obtener los datos del usuario']);
}

$stmt->close();
$connect->close();
?>
