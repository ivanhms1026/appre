import 'dart:convert';
import 'dart:io';

import 'package:appre/menu_app/login/session.dart';
import 'package:flutter/material.dart';
import 'package:appre/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class EditProfile extends StatefulWidget {
  final UserCredentials credentials;

  const EditProfile({Key? key, required this.credentials}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerLastName = TextEditingController();
  TextEditingController controllerDocNumber = TextEditingController();
  TextEditingController controllerCellNumber = TextEditingController();

  File? imagen;
  String nameUser = "";
  String lastName = "";
  String document = "";
  String phone = "";
  String state = "";
  String level = "";

  Future<XFile?> getImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    return image;
  }

  Future<void> fetchUserData(int userId) async {
    final response = await http.post(
      Uri.parse("https://appreopc.000webhostapp.com/updateUser/dateUser.php"),
      body: {
        "userId": userId.toString(),
      },
    );

    if (response.statusCode == 200) {
      final userData = json.decode(response.body);
      nameUser = userData['name_user'];
      lastName = userData['lastname'];
      document = userData['document_number'];
      phone = userData['cell_phone_number'];
      state = userData['id_state'].toString();
      level = userData['id_level'].toString();
      print(state);
      print(level);
      setState(() {});
    } else {
      throw Exception('Error al cargar los datos del usuario');
    }
  }

  Future<void> updateName(int userId, String newName) async {
    final response = await http.post(
      Uri.parse("https://appreopc.000webhostapp.com/updateUser/updateName.php"),
      body: {
        "userId": userId.toString(),
        "newName": newName,
      },
    );

    if (response.statusCode == 200) {
      print("Nombre actualizado con éxito");
    } else {
      throw Exception('Error al actualizar el estado');
    }
  }

  Future<void> updateLastName(int userId, String newLastName) async {
    final response = await http.post(
      Uri.parse("https://appreopc.000webhostapp.com/updateUser/updateLastName.php"),
      body: {
        "userId": userId.toString(),
        "newLastName": newLastName,
      },
    );

    if (response.statusCode == 200) {
      print("Nombre actualizado con éxito");
    } else {
      throw Exception('Error al actualizar el estado');
    }
  }

  Future<void> updateDocument(int userId, String newDocument) async {
    final response = await http.post(
      Uri.parse("https://appreopc.000webhostapp.com/updateUser/updateDocument.php"),
      body: {
        "userId": userId.toString(),
        "newDocument": newDocument,
      },
    );

    if (response.statusCode == 200) {
      print("Nombre actualizado con éxito");
    } else {
      throw Exception('Error al actualizar el estado');
    }
  }

  Future<void> updatePhone(int userId, String newPhone) async {
    final response = await http.post(
      Uri.parse("https://appreopc.000webhostapp.com/updateUser/updatePhone.php"),
      body: {
        "userId": userId.toString(),
        "newPhone": newPhone,
      },
    );

    if (response.statusCode == 200) {
      print("Nombre actualizado con éxito");
    } else {
      throw Exception('Error al actualizar el estado');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserData(widget.credentials.id);
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          toolbarHeight: 55.h,
          leading: BackButton(color: AppColor.colorBlack),
          title: Text(
            "Editar Perfil",
            style: TextStyle(
              fontSize: 15.sp,
              color: AppColor.colorBlack,
            ),
          ),
          centerTitle: false,
          elevation: 0,
          flexibleSpace: Container(
            color: AppColor.colorWhite,
          ),
        ),
        body: Container(
          width: screenWidth,
          height: screenHeight,
          color: Colors.white,
          child: ListView(
            children: [
              Container(
                width: 120.w,
                height: 120.h,
                margin: const EdgeInsets.all(30),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: imagen != null
                      ? ClipOval(
                          child: Image.file(
                            File(imagen!.path),
                            width: 120.w,
                            height: 120.h,
                            fit: BoxFit.cover,
                          ),
                        )
                      : ClipOval(
                          child: Image.asset(
                            'assets/user.jpg',
                            width: 120.w,
                            height: 120.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    final image = await getImage();
                    setState(() {
                      imagen = File(image!.path);
                    });
                  },
                  child: Text("Subir Imagen")),
              Container(
                //color: Colors.yellow,
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Nombre',
                                  style: TextStyle(
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.colorBlack,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  nameUser,
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    color: AppColor.colorBlack,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(child: Container()),
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(16.w),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(vertical: 10),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Align(
                                                alignment: Alignment.center,
                                                child: TextField(
                                                  controller: controllerName,
                                                  obscureText: false,
                                                  style: TextStyle(color: Colors.black, fontSize: 15.sp),
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: "Digite el nuevo Nombre",
                                                    contentPadding: const EdgeInsets.symmetric(vertical: 8),
                                                    hintStyle: TextStyle(
                                                      color: Colors.black.withOpacity(0.3),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: TextButton(
                                            onPressed: () async {
                                              print(widget.credentials.id);
                                              print(controllerName.text);
                                              Navigator.of(context).pop();
                                              await updateName(widget.credentials.id, controllerName.text);
                                              fetchUserData(widget.credentials.id);
                                              setState(() {});
                                            },
                                            child: Text('Guardar',
                                                style: TextStyle(
                                                    color: AppColor.colorTextOne, fontWeight: FontWeight.bold)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Wrap(
                            children: List.generate(1, (index) {
                              return Icon(
                                Icons.edit_square,
                                color: AppColor.colorBlack,
                                size: 35.h,
                              );
                            }),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 30.w, right: 30.w, bottom: 10.h),
                color: Colors.black.withOpacity(0.3),
                height: screenHeight * 0.002.h,
              ),
              Container(
                //color: Colors.yellow,
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Apellido',
                                  style: TextStyle(
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.colorBlack,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  lastName,
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    color: AppColor.colorBlack,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(child: Container()),
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(16.w),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(vertical: 10),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Align(
                                                alignment: Alignment.center,
                                                child: TextField(
                                                  controller: controllerLastName,
                                                  obscureText: false,
                                                  style: TextStyle(color: Colors.black, fontSize: 15.sp),
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: "Digite el nuevo Apellido",
                                                    contentPadding: const EdgeInsets.symmetric(vertical: 8),
                                                    hintStyle: TextStyle(
                                                      color: Colors.black.withOpacity(0.3),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: TextButton(
                                            onPressed: () async {
                                              print(widget.credentials.id);
                                              print(controllerLastName.text);
                                              Navigator.of(context).pop();
                                              await updateLastName(widget.credentials.id, controllerLastName.text);
                                              fetchUserData(widget.credentials.id);
                                              setState(() {});
                                            },
                                            child: Text('Guardar',
                                                style: TextStyle(
                                                    color: AppColor.colorTextOne, fontWeight: FontWeight.bold)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Wrap(
                            children: List.generate(1, (index) {
                              return Icon(
                                Icons.edit_square,
                                color: AppColor.colorBlack,
                                size: 35.h,
                              );
                            }),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 30.w, right: 30.w, bottom: 10.h),
                color: Colors.black.withOpacity(0.3),
                height: screenHeight * 0.002.h,
              ),
              Container(
                //color: Colors.yellow,
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Numero documento',
                                  style: TextStyle(
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.colorBlack,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  document,
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    color: AppColor.colorBlack,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(child: Container()),
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(16.w),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(vertical: 10),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Align(
                                                alignment: Alignment.center,
                                                child: TextField(
                                                  controller: controllerDocNumber,
                                                  obscureText: false,
                                                  style: TextStyle(color: Colors.black, fontSize: 15.sp),
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: "Digite el nuevo Documento",
                                                    contentPadding: const EdgeInsets.symmetric(vertical: 8),
                                                    hintStyle: TextStyle(
                                                      color: Colors.black.withOpacity(0.3),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: TextButton(
                                            onPressed: () async {
                                              print(widget.credentials.id);
                                              print(controllerDocNumber.text);
                                              Navigator.of(context).pop();
                                              await updateDocument(widget.credentials.id, controllerDocNumber.text);
                                              fetchUserData(widget.credentials.id);
                                              setState(() {});
                                            },
                                            child: Text('Guardar',
                                                style: TextStyle(
                                                    color: AppColor.colorTextOne, fontWeight: FontWeight.bold)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Wrap(
                            children: List.generate(1, (index) {
                              return Icon(
                                Icons.edit_square,
                                color: AppColor.colorBlack,
                                size: 35.h,
                              );
                            }),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 30.w, right: 30.w, bottom: 10.h),
                color: Colors.black.withOpacity(0.3),
                height: screenHeight * 0.002.h,
              ),
              Container(
                //color: Colors.yellow,
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Celular',
                                  style: TextStyle(
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.colorBlack,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  phone,
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    color: AppColor.colorBlack,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(child: Container()),
                        InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(16.w),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(vertical: 10),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Align(
                                                alignment: Alignment.center,
                                                child: TextField(
                                                  controller: controllerCellNumber,
                                                  obscureText: false,
                                                  style: TextStyle(color: Colors.black, fontSize: 15.sp),
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    hintText: "Digite el nuevo Celular",
                                                    contentPadding: const EdgeInsets.symmetric(vertical: 8),
                                                    hintStyle: TextStyle(
                                                      color: Colors.black.withOpacity(0.3),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: TextButton(
                                            onPressed: () async {
                                              print(widget.credentials.id);
                                              print(controllerCellNumber.text);
                                              Navigator.of(context).pop();
                                              await updatePhone(widget.credentials.id, controllerCellNumber.text);
                                              fetchUserData(widget.credentials.id);
                                              setState(() {});
                                            },
                                            child: Text('Guardar',
                                                style: TextStyle(
                                                    color: AppColor.colorTextOne, fontWeight: FontWeight.bold)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Wrap(
                            children: List.generate(1, (index) {
                              return Icon(
                                Icons.edit_square,
                                color: AppColor.colorBlack,
                                size: 35.h,
                              );
                            }),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 30.w, right: 30.w, bottom: 10.h),
                color: Colors.black.withOpacity(0.3),
                height: screenHeight * 0.002.h,
              ),
              Container(
                //color: Colors.yellow,
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Estado',
                                  style: TextStyle(
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.colorBlack,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                state == '1'
                                    ? 'Activo'
                                    : state == '2'
                                        ? 'Inactivo'
                                        : state == '3'
                                            ? 'Pendiente'
                                            : '',
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  color: AppColor.colorBlack,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        Expanded(child: Container()),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 30.w, right: 30.w, bottom: 10.h),
                color: Colors.black.withOpacity(0.3),
                height: screenHeight * 0.002.h,
              ),
              Container(
                //color: Colors.yellow,
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Nivel',
                                  style: TextStyle(
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.colorBlack,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  level == '1'
                                      ? 'Superadministrador'
                                      : level == '2'
                                          ? 'Administrador'
                                          : level == '3'
                                              ? 'Usuario'
                                              : 'Otro',
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    color: AppColor.colorBlack,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(child: Container()),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 30.w, right: 30.w, bottom: 10.h),
                color: Colors.black.withOpacity(0.3),
                height: screenHeight * 0.002.h,
              ),
            ],
          ),
        ));
  }
}
