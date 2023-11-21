<?php
include '../conexion.php'; 

// Recibir datos de la solicitud HTTP.
$userId = $_POST["userId"];
$newLastName = $_POST["newLastName"];

// Actualizar el nombre del usuario en la base de datos.
$sql = "UPDATE user_app SET lastname = ? WHERE id = ?";
$stmt = $connect->prepare($sql);
$stmt->bind_param("si", $newLastName, $userId);

if ($stmt->execute()) {
    // Éxito en la actualización.
    echo "Nombre actualizado con éxito.";
} else {
    // Error en la actualización.
    echo "Error al actualizar el nombre: " . $connect->error;
}

$stmt->close();
$connect->close();
?>