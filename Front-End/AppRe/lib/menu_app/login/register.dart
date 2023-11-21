import 'package:appre/colors.dart';
import 'package:appre/menu_app/login/login.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

String msg = '';

/// La clase `Register` es un widget que representa la pantalla de registro de la aplicación.
/// Permite a los usuarios crear una nueva cuenta en la aplicación.
class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

/// La clase `_RegisterState` es el estado de la pantalla de registro (Register).
/// Controla la vista y la interacción del usuario en esta pantalla, incluyendo la detección
/// del teclado virtual y la visibilidad de elementos en la pantalla.
class _RegisterState extends State<Register> {
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

/// La clase `SizedBoxContainer` es un widget que representa un contenedor con un tamaño específico.
/// Este contenedor se utiliza para crear una parte de la interfaz de usuario de la pantalla de registro.
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
            padding: EdgeInsets.only(top: 50.h),
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
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.h),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              width: screenWidth * 0.1,
                              height: screenHeight * 0.05,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white.withOpacity(0.1),
                              ),
                              child: Icon(
                                Icons.arrow_back_ios,
                                size: 20,
                                color: AppColor.colorWhite,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  height: 180.h,
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

/// Crea un widget personalizado para el contenedor de inicio de sesión.
/// [screenHeight] es el alto de la pantalla en la que se muestra el widget.
/// [screenWidth] es el ancho de la pantalla en la que se muestra el widget.
class LoginContainer extends StatefulWidget {
  final double screenHeight;
  final double screenWidth;

  const LoginContainer({Key? key, required this.screenHeight, required this.screenWidth}) : super(key: key);

  @override
  _LoginContainerState createState() => _LoginContainerState();
}

/// La clase `_LoginContainerState` es una clase que representa el estado del widget `LoginContainer`.
/// Es responsable de la lógica y la interfaz de usuario relacionadas con el proceso de inicio de sesión en la aplicación.
class _LoginContainerState extends State<LoginContainer> {
  bool isChecked = false;
  final FocusNode _userFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerLastName = TextEditingController();
  TextEditingController controllerDocNumber = TextEditingController();
  TextEditingController controllerCellNumber = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPass = TextEditingController();
  Set<String> registeredEmails = Set<String>();

  bool isEmailRegistered(String email) {
    return registeredEmails.contains(email);
  }

  bool isEmailValid(String email) {
    final emailPattern = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

    return emailPattern.hasMatch(email);
  }

  Future<String> _registro() async {
    print("Iniciando proceso de registro...");

    final response = await http.post(
      Uri.parse("https://appreopc.000webhostapp.com/registrar.php"),
      body: {
        "name_user": controllerName.text,
        "lastname": controllerLastName.text,
        "document_number": controllerDocNumber.text,
        "cell_phone_number": controllerCellNumber.text,
        "email": controllerEmail.text,
        "password_app": controllerPass.text,
      },
    );

    print("HTTP Status Code: ${response.statusCode}");
    print("Respuesta del servidor: ${response.body}");

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      if (data.containsKey('mensaje')) {
        if (data['mensaje'] == "Correo electronico duplicado") {
          if (mounted) {
            setState(() {
              msg = "Correo electrónico duplicado, por favor elige otro.";
            });
          }
        } else if (data['mensaje'] == "El número de documento ya existe") {
          if (mounted) {
            setState(() {
              msg = "El número de documento ya existe, por favor elige otro.";
            });
          }
        } else if (data['mensaje'] == "El número de teléfono ya existe") {
          if (mounted) {
            setState(() {
              msg = "El número de teléfono ya existe, por favor elige otro.";
            });
          }
        } else if (data['mensaje'] == "Usuario registrado con exito") {
          Get.to(() => Login());
        } else {
          if (mounted) {
            setState(() {
              msg = data['mensaje'];
            });
          }
        }
      } else {
        if (mounted) {
          setState(() {
            msg = "Respuesta del servidor incorrecta";
          });
        }
      }
    } else {
      if (mounted) {
        setState(() {
          msg = "Error en la respuesta del servidor";
        });
      }
    }

    return msg;
  }

  Future<void> validationDate(
      String name, String lastname, String document, String phone, String user, String pass) async {
    if (name.trim().isEmpty) {
      setState(() {
        validationMessage = "Ingresa un nombre";
      });
    } else if (lastname.trim().isEmpty) {
      setState(() {
        validationMessage = "Ingresa una apellido";
      });
    } else if (document.trim().isEmpty) {
      setState(() {
        validationMessage = "Ingresa un numero de documento";
      });
    } else if (document.length >= 10) {
      setState(() {
        validationMessage = "Es muy corto para ser un documento";
      });
    } else if (phone.trim().isEmpty) {
      setState(() {
        validationMessage = "Ingresa una numero de celular";
      });
    } else if (user.trim().isEmpty) {
      setState(() {
        validationMessage = "Ingresa un correo";
      });
    } else if (!isEmailValid(controllerEmail.text)) {
      setState(() {
        validationMessage = "El correo ingresado no es valido";
      });
    } else if (pass.trim().isEmpty) {
      setState(() {
        validationMessage = "Ingresa una contraseña";
      });
    } else if (pass.length > 8) {
      setState(() {
        validationMessage = "La contraseña es muy corta";
      });
    } else {
      String registerError = await _registro();
      setState(() {
        validationMessage = registerError;
      });
    }
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
                height: 460.h,
                child: Column(
                  children: [
                    SizedBox(
                        width: widget.screenWidth,
                        height: 70.h,
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
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black.withOpacity(0.7),
                                        ),
                                        maxLines: 1,
                                      ),
                                      SizedBox(height: 3.h),
                                      AutoSizeText(
                                        "Completa los campos para el registro",
                                        style: TextStyle(
                                          fontSize: 10.sp,
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
                        height: 310.h,
                        child: Column(
                          children: [
                            SizedBox(height: 10.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: Container(
                                width: widget.screenWidth,
                                height: 40.h,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.black.withOpacity(0.3), // Color de la línea
                                      width: 1.0, // Grosor de la línea
                                    ),
                                  ),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: TextField(
                                          controller: controllerName,
                                          obscureText: false,
                                          style: TextStyle(color: Colors.black, fontSize: 15.sp),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Nombre",
                                            contentPadding: const EdgeInsets.symmetric(vertical: 8),
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
                            SizedBox(height: 8.h),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Container(
                                width: widget.screenWidth,
                                height: 40.h,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.black.withOpacity(0.3), // Color de la línea
                                      width: 1.0, // Grosor de la línea
                                    ),
                                  ),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: TextField(
                                          controller: controllerLastName,
                                          obscureText: false,
                                          style: TextStyle(color: Colors.black, fontSize: 15.sp),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Apellido",
                                            contentPadding: const EdgeInsets.symmetric(vertical: 8),
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
                            SizedBox(height: 8.h),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Container(
                                width: widget.screenWidth,
                                height: 40.h,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.black.withOpacity(0.3), // Color de la línea
                                      width: 1.0, // Grosor de la línea
                                    ),
                                  ),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: TextField(
                                          controller: controllerDocNumber,
                                          obscureText: false,
                                          style: TextStyle(color: Colors.black, fontSize: 15.sp),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Numero documento",
                                            contentPadding: const EdgeInsets.symmetric(vertical: 8),
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
                            SizedBox(height: 8.h),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Container(
                                width: widget.screenWidth,
                                height: 40.h,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.black.withOpacity(0.3), // Color de la línea
                                      width: 1.0, // Grosor de la línea
                                    ),
                                  ),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: TextField(
                                          controller: controllerCellNumber,
                                          obscureText: false,
                                          style: TextStyle(color: Colors.black, fontSize: 15.sp),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Celular",
                                            contentPadding: const EdgeInsets.symmetric(vertical: 8),
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
                            SizedBox(height: 8.h),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Container(
                                width: widget.screenWidth,
                                height: 40.h,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.black.withOpacity(0.3), // Color de la línea
                                      width: 1.0, // Grosor de la línea
                                    ),
                                  ),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: TextField(
                                          controller: controllerEmail,
                                          obscureText: false,
                                          style: TextStyle(color: Colors.black, fontSize: 15.sp),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Correo",
                                            contentPadding: const EdgeInsets.symmetric(vertical: 8),
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
                            SizedBox(height: 8.h),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Container(
                                width: widget.screenWidth,
                                height: 40.h,
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.black.withOpacity(0.3), // Color de la línea
                                      width: 1.0, // Grosor de la línea
                                    ),
                                  ),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: TextField(
                                          controller: controllerPass,
                                          obscureText: false,
                                          style: TextStyle(color: Colors.black, fontSize: 15.sp),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Contraseña",
                                            contentPadding: const EdgeInsets.symmetric(vertical: 8),
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
                          ],
                        )),
                    SizedBox(
                      width: widget.screenWidth,
                      height: 60.h,
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
                            ButtonTheme(
                              child: ElevatedButton(
                                onPressed: () async {
                                  await validationDate(
                                      controllerName.text,
                                      controllerLastName.text,
                                      controllerDocNumber.text,
                                      controllerCellNumber.text,
                                      controllerEmail.text,
                                      controllerPass.text);
                                  final text = validationMessage;
                                  final backgroundColor =
                                      text == "Usuario registrado con exito" ? Colors.green : Colors.redAccent;

                                  final snackBar = SnackBar(
                                    backgroundColor: Colors.transparent,
                                    elevation: 0,
                                    content: FadeInUp(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(horizontal: 30.w),
                                        height: 45.h,
                                        decoration: BoxDecoration(
                                          color: backgroundColor, // Establece el color de fondo basado en la validación
                                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(
                                              text == "Usuario registrado con éxito"
                                                  ? Icons
                                                      .check // Cambia el icono a un check si el mensaje es "Usuario registrado con éxito"
                                                  : Icons.error_outline, // De lo contrario, usa el icono de error
                                              size: 24,
                                              color: Colors.white,
                                            ),
                                            SizedBox(width: 8.w),
                                            Text(
                                              text,
                                              style: TextStyle(fontSize: 15.sp),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    duration: const Duration(seconds: 3),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  textStyle: const TextStyle(color: Colors.white),
                                ),
                                child: Text(
                                  "Registrar",
                                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 17.sp),
                                ),
                              ),
                            ),
                          ],
                        ),
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
