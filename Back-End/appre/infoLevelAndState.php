<?php
include 'conexion.php'; // Importa tu archivo de conexión a la base de datos

// Verifica si se proporcionó un parámetro de ID
if (isset($_GET['user_id'])) {
    $user_id = $_GET['user_id'];
    
    // Utiliza una consulta preparada para mayor seguridad
    $query = "SELECT user_app.*, level_app.name_level AS user_level, state_app.name_state AS user_state
              FROM user_app
              INNER JOIN level_app ON user_app.id_level = level_app.id
              LEFT JOIN state_app ON user_app.id_state = state_app.id
              WHERE user_app.id = ?";
    
    // Prepara la consulta
    $stmt = $connect->prepare($query);
    $stmt->bind_param('i', $user_id); // 'i' indica un entero
    
    // Ejecuta la consulta
    $stmt->execute();
    
    // Obtiene el resultado
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        $user = $result->fetch_assoc();
        
        // Construye un arreglo para los datos del usuario, nivel y estado
        $user_data = $user;
        $user_level = $user['user_level'];
        $user_state = $user['user_state'];
        
        // Devuelve los datos en un arreglo asociativo
        $response = array(
            'user_data' => $user_data,
            'user_level' => $user_level,
            'user_state' => $user_state
        );
        
        header('Content-Type: application/json');
        echo json_encode($response);
    } else {
        echo "No se encontró un usuario con el ID proporcionado.";
    }
    
    // Cierra la consulta preparada
    $stmt->close();
} else {
    echo "Por favor, proporcione un ID de usuario.";
}

// Cierra la conexión a la base de datos
$connect->close();
?>
