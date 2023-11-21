<?php
include 'conexion.php';

$name_user = $_POST['name_user'];
$lastname = $_POST['lastname'];
$document_number = $_POST['document_number'];
$cell_phone_number = $_POST['cell_phone_number'];
$email = $_POST['email'];
$password_app = $_POST['password_app'];

// Verifica si el correo electrónico ya existe en la base de datos
$checkDuplicateEmail = $connect->query("SELECT * FROM user_app WHERE email='$email'");
if ($checkDuplicateEmail->num_rows > 0) {
    echo json_encode(["error" => true, "mensaje" => "El correo digitado ya existe"]);
    exit();
}

// Verifica si el número de documento ya existe en la base de datos
$checkDuplicateDocument = $connect->query("SELECT * FROM user_app WHERE document_number='$document_number'");
if ($checkDuplicateDocument->num_rows > 0) {
    echo json_encode(["error" => true, "mensaje" => "El numero de documento ya existe"]);
    exit();
}

// Verifica si el número de teléfono ya existe en la base de datos
$checkDuplicatePhoneNumber = $connect->query("SELECT * FROM user_app WHERE cell_phone_number='$cell_phone_number'");
if ($checkDuplicatePhoneNumber->num_rows > 0) {
    echo json_encode(["error" => true, "mensaje" => "El número de telefono ya existe"]);
    exit();
}

// Obtén el ID del nivel y estado "Usuario"
$consultarUserLevel = $connect->query("SELECT id FROM level_app WHERE name_level='Usuario'");
$id_user_level = $consultarUserLevel->fetch_assoc()['id'];

$consultarUserState = $connect->query("SELECT id FROM state_app WHERE name_state='Pendiente'");
$id_user_state = $consultarUserState->fetch_assoc()['id'];

// Inserta los datos del usuario con el ID del nivel y estado "Usuario"
$consultar = $connect->query("INSERT INTO user_app (name_user, lastname, document_number, cell_phone_number, email, password_app, id_level, id_state)
  VALUES ('$name_user', '$lastname', '$document_number', '$cell_phone_number', '$email', '$password_app', $id_user_level, $id_user_state)");

if (!$consultar) {
    echo json_encode(["error" => true, "mensaje" => "Error en la inserción: " . $connect->error]);
    exit();
}

echo json_encode(["error" => false, "mensaje" => "Usuario registrado con exito"]);
?>


