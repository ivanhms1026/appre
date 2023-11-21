<?php
include 'conexion.php'; 

// Recibir datos de la solicitud HTTP.
$userId = $_POST["userId"];
$newState = $_POST["newState"];

// Actualizar el estado del usuario en la base de datos.
$sql = "UPDATE user_app SET id_state = ? WHERE id = ?";
$stmt = $connect->prepare($sql);
$stmt->bind_param("ii", $newState, $userId);

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

