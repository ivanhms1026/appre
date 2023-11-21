import 'package:appre/colors.dart';
import 'package:appre/menu_app/login/register.dart';
import 'package:appre/menu_app/login/session.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;

String message = '';
String validationMessage = "";

/// La clase `Login` es un widget que representa la pantalla de inicio de sesión de la aplicación.
/// Permite a los usuarios iniciar sesión en la aplicación.
class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

/// La clase `_LoginState` es el estado de la pantalla de inicio de sesión (Login).
/// Controla la vista y la interacción del usuario en esta pantalla, incluyendo la detección
/// del teclado virtual y la visibilidad de elementos en la pantalla.
class _LoginState extends State<Login> {
  bool isKeyboardVisible = false;
  bool isImageVisible = true;

  @override
  void initState() {
    super.initState();
    KeyboardVisibilityController().onChange.listen((bool visible) {
      setState(() {
        isKeyboardVisible = visible;
        isImageVisible = !visible;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          SizedBoxContainer(
            screenWidth: screenWidth,
            screenHeight: screenHeight,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ListView(
              reverse: true,
              shrinkWrap: true,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    ElasticInUp(
                      child: LoginContainer(
                        screenWidth: screenWidth,
                        screenHeight: screenHeight,
                      ),
                    ),
                    Container(
                      height: 65.h,
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                      width: screenWidth,
                      child: Image.asset(
                        "assets/logoUni2.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SizedBoxContainer extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;

  const SizedBoxContainer({super.key, required this.screenHeight, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: OvalBottomBorderClipper(),
      child: SizedBox(
        width: screenWidth,
        height: 520.h,
        child: ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [AppColor.colorBlack, AppColor.colorBlack.withOpacity(0.15)],
            begin: Alignment.bottomCenter,
            end: Alignment.center,
          ).createShader(bounds),
          blendMode: BlendMode.darken,
          child: Container(
            padding: EdgeInsets.only(top: 100.h),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage("assets/deporte2.jpg"),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.8),
                  BlendMode.darken,
                ),
              ),
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  height: 230.h,
                  width: screenWidth,
                  child: Image.asset(
                    "assets/logoP.png",
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// La clase `LoginContainer` es un widget que representa un contenedor en la pantalla de inicio de sesión.
/// Recibe las dimensiones de la pantalla (alto y ancho) como argumentos.

class LoginContainer extends StatefulWidget {
  final double screenHeight;
  final double screenWidth;

  const LoginContainer({Key? key, required this.screenHeight, required this.screenWidth}) : super(key: key);

  @override
  _LoginContainerState createState() => _LoginContainerState();
}

/// La clase `_LoginContainerState` es el estado del contenedor de la pantalla de inicio de sesión (LoginContainer).
/// Controla la vista y la interacción de los elementos en este contenedor.
///
/// Realiza el proceso de inicio de sesión y retorna un mensaje.
/// Valida los datos de usuario y contraseña y muestra un mensaje de validación.
class _LoginContainerState extends State<LoginContainer> {
  bool isChecked = false;
  final FocusNode _userFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  TextEditingController controllerUser = TextEditingController();
  TextEditingController controllerPass = TextEditingController();
  var _isObscured;
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  Future<String> _login() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return "No hay conexión a Internet";
    }

    final response = await http.post(
      //Uri.parse("https://appre1.000webhostapp.com/AppRe/appre/login.php"),
      Uri.parse("https://appreopc.000webhostapp.com/login.php"),
      body: {
        "user": controllerUser.text,
        "pass": controllerPass.text,
      },
    );
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      final datauser = json.decode(response.body);
      if (datauser.containsKey("error") && datauser["error"] == true) {
        setState(() {
          message = datauser["mensaje"] ?? "Login Fallido";
        });

        return message;
      } else {
        final List<dynamic> userData = datauser['data'];
        if (userData.isNotEmpty) {
          final Map<String, dynamic> userD = userData[0];
          final int id = int.tryParse(userD['id'].toString()) ?? 0;
          final String userName = userD['name_user'].toString() ?? "";
          final String userLastName = userD['lastname'].toString() ?? "";
          final String documentNumber = userD['document_number'].toString() ?? "";
          final String cellPhoneNumber = userD['cell_phone_number'].toString() ?? "";
          final int userLevel = int.tryParse(userD['id_level'].toString()) ?? 0;
          final int userState = int.tryParse(userD['id_state'].toString()) ?? 0;

          if (userState == 3) {
            message = "Usuario sin acceso";
            return message;
          } else {
            final user = controllerUser.text;
            final pass = controllerPass.text;
            await Session.saveCredentialsAndNavigate(
                id, userName, userLastName, documentNumber, cellPhoneNumber, user, pass, userLevel, userState);
            return "";
          }
        }
        return "Usuario o contraseña incorrectos";
      }
    } else {
      return "Error de conexión";
    }
  }

  Future<void> validationDate(String user, String pass) async {
    setState(() {
      validationMessage = "";
    });

    if (user.trim().isEmpty) {
      setState(() {
        validationMessage = "Ingresa un usuario";
      });
    } else if (pass.trim().isEmpty) {
      setState(() {
        validationMessage = "Ingresa una contraseña";
      });
    } else {
      String loginError = await _login();
      setState(() {
        validationMessage = loginError;
      });
    }
  }

  @override
  void initState() {
    _isObscured = true;
    super.initState();
  }

  @override
  void dispose() {
    _userFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 30.h),
            child: PhysicalModel(
              borderRadius: BorderRadius.circular(35),
              color: Colors.white,
              elevation: 8,
              shadowColor: Colors.black,
              child: SizedBox(
                width: widget.screenWidth,
                height: 380.h,
                child: Column(
                  children: [
                    SizedBox(
                        width: widget.screenWidth,
                        height: 80.h,
                        child: Container(
                          padding: EdgeInsets.only(top: 10.h),
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                          )),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Center(
                                  child: Column(
                                    children: [
                                      AutoSizeText(
                                        "Bienvenido",
                                        style: TextStyle(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black.withOpacity(0.7),
                                        ),
                                        maxLines: 1,
                                      ),
                                      SizedBox(height: 2.h),
                                      AutoSizeText(
                                        "Inicia sesión para ingresar",
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          color: Colors.black.withOpacity(0.5),
                                        ),
                                        maxLines: 2,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                    SizedBox(
                        width: widget.screenWidth,
                        height: 150.h,
                        child: Column(
                          children: [
                            SizedBox(height: 10.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
                              child: Container(
                                width: widget.screenWidth,
                                height: 40.h,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                                  color: Colors.white70,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 1,
                                    ),
                                  ],
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: Icon(
                                        size: 20.w,
                                        Icons.person,
                                        color: Colors.black.withOpacity(0.3),
                                      ),
                                    ),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: TextField(
                                          controller: controllerUser,
                                          style: TextStyle(color: Colors.black, fontSize: 15.sp),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Correo",
                                            contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                                            hintStyle: TextStyle(
                                              color: Colors.black.withOpacity(0.3),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Container(
                                width: widget.screenWidth,
                                height: 40.h,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                                  color: Colors.white70,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 1,
                                    ),
                                  ],
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: Icon(
                                        size: 20.w,
                                        Icons.lock,
                                        color: Colors.black.withOpacity(0.3),
                                      ),
                                    ),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: TextField(
                                          controller: controllerPass,
                                          obscureText: _isObscured,
                                          style: TextStyle(color: Colors.black, fontSize: 15.sp),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Contraseña",
                                            contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                                            hintStyle: TextStyle(
                                              color: Colors.black.withOpacity(0.3),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: IconButton(
                                        icon: _isObscured
                                            ? Icon(Icons.visibility_off, color: Colors.black.withOpacity(0.3))
                                            : const Icon(
                                                Icons.visibility,
                                                color: Colors.black,
                                              ),
                                        onPressed: () {
                                          setState(() {
                                            _isObscured = !_isObscured;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )),
                    SizedBox(
                      width: widget.screenWidth,
                      height: 70.h,
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20.0),
                            bottomRight: Radius.circular(20.0),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () async {
                                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                await validationDate(controllerUser.text, controllerPass.text);
                                if (!validationMessage.isEmpty) {
                                  final snackBar = SnackBar(
                                    backgroundColor: Colors.transparent,
                                    elevation: 0,
                                    content: FadeInUp(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: 30.w),
                                        height: 45.h,
                                        decoration: const BoxDecoration(
                                          color: Colors.redAccent,
                                          borderRadius: BorderRadius.all(Radius.circular(10)),
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.error_outline,
                                              size: 24,
                                              color: AppColor.colorWhite,
                                            ),
                                            SizedBox(width: 8.w),
                                            Text(
                                              validationMessage,
                                              style: TextStyle(fontSize: 15.sp),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    duration: const Duration(seconds: 3),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                textStyle: TextStyle(color: AppColor.colorWhite),
                              ),
                              child: Text(
                                "Ingresar",
                                style:
                                    TextStyle(fontWeight: FontWeight.bold, color: AppColor.colorWhite, fontSize: 17.sp),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Register(),
                                ),
                              );
                            },
                            child: AutoSizeText(
                              "¿Crear una cuenta?",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColor.colorBlack,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
