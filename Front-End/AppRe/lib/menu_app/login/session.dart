import 'package:appre/administrator_module/administratorModule.dart';
import 'package:appre/main.dart';
import 'package:appre/menu_app/login/login.dart';
import 'package:appre/super_administrator_module/superModule.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Es una clase simple que almacena las credenciales y la información del usuario.
class UserCredentials {
  final int id;
  final String name;
  final String lastname;
  final String document;
  final String phone;
  final String user;
  final String pass;
  final int userLevel;
  final int userState;

  UserCredentials(this.id, this.name, this.lastname, this.document, this.phone, this.user, this.pass, this.userLevel,
      this.userState);
}

/// Guarda las credenciales del usuario en el almacenamiento y navega a una pantalla específica según el nivel y estado del usuario.
///
/// [id] es el ID del usuario.
/// [name] es el nombre del usuario.
/// [lastname] es el apellido del usuario.
/// [document] es el número de documento del usuario.
/// [phone] es el número de teléfono del usuario.
/// [user] es el nombre de usuario.
/// [pass] es la contraseña del usuario.
/// [userLevel] es el nivel del usuario (puede ser 1, 2 o 3).
/// [userState] es el estado del usuario (puede ser 1 para activo).
class Session {
  static late SharedPreferences _sharedPreferences;

  static Future<void> initialize() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<void> saveCredentialsAndNavigate(int id, String name, String lastname, String document, String phone,
      String user, String pass, int userLevel, int userState) async {
    _sharedPreferences.setInt('id', id);
    _sharedPreferences.setString('name', name);
    _sharedPreferences.setString('lastname', lastname);
    _sharedPreferences.setString('document', document);
    _sharedPreferences.setString('phone', phone);
    _sharedPreferences.setString('user', user);
    _sharedPreferences.setString('pass', pass);
    _sharedPreferences.setInt('userLevel', userLevel);
    _sharedPreferences.setInt('userState', userState);
    print(name);
    print(lastname);
    print(document);
    print(phone);
    UserCredentials credentials =
        UserCredentials(id, name, lastname, document, phone, user, pass, userLevel, userState);
    if (userLevel == 1) {
      Get.to(() => SuperModule(credentials: credentials));
    } else if (userLevel == 2) {
      Get.to(() => AdministratorModule(credentials: credentials));
    } else if (userLevel == 3) {
      Get.to(() => Main(credentials: credentials));
    }
  }

  static Future<void> removeCredential(String user, String pass) async {
    _sharedPreferences.remove('user');
    _sharedPreferences.remove('pass');
    Get.off(() => const Login());
  }
}
