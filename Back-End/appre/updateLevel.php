<?php
include 'conexion.php'; 

// Recibir datos de la solicitud HTTP.
$userId = $_POST["userId"];
$newLevel = $_POST["newLevel"];

// Actualizar el nivel del usuario en la base de datos.
$sql = "UPDATE user_app SET id_level = ? WHERE id = ?";
$stmt = $connect->prepare($sql);
$stmt->bind_param("ii", $newLevel, $userId);

if ($stmt->execute()) {
    // Éxito en la actualización.
    echo "Estado actualizado con éxito.";
} else {
    // Error en la actualización.
    echo "Error al actualizar el estado: " . $connect->error;
}

$stmt->close();
$connect->close();
?>
