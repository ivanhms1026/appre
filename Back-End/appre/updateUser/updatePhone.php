<?php
include '../conexion.php'; 

// Recibir datos de la solicitud HTTP.
$userId = $_POST["userId"];
$newPhone = $_POST["newPhone"];

// Actualizar el nombre del usuario en la base de datos.
$sql = "UPDATE user_app SET cell_phone_number = ? WHERE id = ?";
$stmt = $connect->prepare($sql);
$stmt->bind_param("si", $newPhone, $userId);

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