import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:appre/colors.dart';
import 'package:http/http.dart' as http;

List<Map<String, dynamic>> estados = [];
List<Map<String, dynamic>> niveles = [];

class UserInformationAdmin extends StatefulWidget {
  final Map<String, dynamic> userData;

  const UserInformationAdmin({Key? key, required this.userData}) : super(key: key);

  @override
  State<UserInformationAdmin> createState() => _UserInformationAdminState();
}

class _UserInformationAdminState extends State<UserInformationAdmin> {
  List<Map<String, dynamic>> userList = [];
  String userLevel = '';
  String userState = '';
  String selectedName = "";
  String dropdownValue = "";
  Map<String, int> stateMap = {};
  Map<String, int> levelMap = {};

  Future<void> fetchUserData(int userId) async {
    final response = await http.get(Uri.parse("https://appreopc.000webhostapp.com/infoLevelAndState.php?user_id=$userId"));
    print("Response status code: ${response.statusCode}");
    print("Response body: ${response.body}");
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      setState(() {
        userList = [jsonResponse['user_data']];
        userLevel = jsonResponse['user_level'].toString();
        userState = jsonResponse['user_state'].toString();
      });
      print("UserList: $userList");
      print(widget.userData['id']);
    } else {
      throw Exception('Failed to load user data');
    }
  }

  Future<void> fetchEstados() async {
    final response = await http.get(Uri.parse("https://appreopc.000webhostapp.com/getStates.php"));
    print("Response status code: ${response.statusCode}");
    print("Response body: ${response.body}");
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);

      if (jsonResponse is List) {
        List<Map<String, dynamic>> estadosList = jsonResponse.cast<Map<String, dynamic>>();

        setState(() {
          estados = estadosList;
        });
      } else {
        throw Exception('Failed to load estados data');
      }
    } else {
      throw Exception('Failed to load estados data');
    }
  }

  Future<void> updateState(int userId, int newState) async {
    final response = await http.post(
      Uri.parse("https://appreopc.000webhostapp.com/updateState.php"),
      body: {
        "userId": userId.toString(),
        "newState": newState.toString(),
      },
    );

    if (response.statusCode == 200) {
      print("Estado actualizado con éxito");
    } else {
      throw Exception('Error al actualizar el estado');
    }
  }

  Future<void> fetchNiveles() async {
    final response = await http.get(Uri.parse("https://appreopc.000webhostapp.com/getLevels.php"));
    print("Response status code: ${response.statusCode}");
    print("Response body: ${response.body}");
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);

      if (jsonResponse is List) {
        List<Map<String, dynamic>> nivelesList = jsonResponse.cast<Map<String, dynamic>>();

        setState(() {
          niveles = nivelesList;
        });
      } else {
        throw Exception('Failed to load estados data');
      }
    } else {
      throw Exception('Failed to load estados data');
    }
  }

  Future<void> updateLevel(int userId, int newLevel) async {
    final response = await http.post(
      Uri.parse("https://appreopc.000webhostapp.com/updateLevel.php"),
      body: {
        "userId": userId.toString(),
        "newLevel": newLevel.toString(),
      },
    );

    if (response.statusCode == 200) {
      print("Estado actualizado con éxito");
    } else {
      throw Exception('Error al actualizar el estado');
    }
  }

  @override
  void initState() {
    super.initState();
    int userId = int.parse(widget.userData['id']);
    int userIdToFetch = userId;
    fetchUserData(userIdToFetch);
    fetchEstados();
    fetchNiveles();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    int userId = int.parse(widget.userData['id']);
    int userIdToFetch = userId;
    int selectedStateId = 0;
    int selectedLevelId = 0;

    for (var estado in estados) {
      stateMap[estado['name_state']] = int.parse(estado['id']);
    }

    for (var nivel in niveles) {
      levelMap[nivel['name_level']] = int.parse(nivel['id']);
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          toolbarHeight: 50.h,
        ),
        body: Column(
          children: [
            ClipPath(
              clipper: OvalBottomBorderClipper(),
              child: Container(
                color: AppColor.colorBlack,
                width: screenWidth,
                height: 190.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 7,
                      child: Container(
                        width: 80.w,
                        height: 80.h,
                        margin: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage('assets/user.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              '${widget.userData['name_user']} ${widget.userData['lastname']}',
                              style: TextStyle(
                                fontSize: 17.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColor.colorTextOne,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              userLevel,
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                                color: AppColor.colorWhite,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 30.w, right: 30.w),
              width: screenWidth,
              height: 50.h,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Datos de usuario',
                  style: TextStyle(
                    fontSize: 21.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColor.colorBlack,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  Container(
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
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      widget.userData['name_user'],
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
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30.w),
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
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      widget.userData['lastname'],
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
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30.w),
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
                                      'Numero de documento',
                                      style: TextStyle(
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.colorBlack,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      widget.userData['document_number'],
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
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30.w),
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
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      widget.userData['cell_phone_number'],
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
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30.w),
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
                                      'Correo',
                                      style: TextStyle(
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.colorBlack,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      widget.userData['email'],
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
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30.w),
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
                                      'Rol',
                                      style: TextStyle(
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.colorBlack,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      userLevel,
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
                                                  DropdownMenu<String>(
                                                    width: 250.w,
                                                    hintText: 'Cambiar nivel',
                                                    onSelected: (String? value) {
                                                      setState(() {
                                                        userIdToFetch = userId;
                                                        dropdownValue = value!;
                                                        selectedLevelId = levelMap[value]!;
                                                      });
                                                    },
                                                    dropdownMenuEntries:
                                                        levelMap.keys.map<DropdownMenuEntry<String>>((nameState) {
                                                      return DropdownMenuEntry<String>(
                                                          value: nameState, label: nameState);
                                                    }).toList(),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: TextButton(
                                                onPressed: () async {
                                                  Navigator.of(context).pop();
                                                  await updateLevel(userIdToFetch, selectedLevelId);
                                                  await fetchUserData(userIdToFetch);
                                                  setState(() {});
                                                },
                                                child: Text('OK',
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
                                    color: AppColor.colorBlack.withOpacity(0.8),
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
                    margin: EdgeInsets.symmetric(horizontal: 30.w),
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
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      userState,
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
                                                  DropdownMenu<String>(
                                                    width: 250.w,
                                                    hintText: 'Cambiar estado',
                                                    onSelected: (String? value) {
                                                      setState(() {
                                                        userIdToFetch = userId;
                                                        dropdownValue = value!;
                                                        selectedStateId = stateMap[value]!;
                                                      });
                                                    },
                                                    dropdownMenuEntries:
                                                        stateMap.keys.map<DropdownMenuEntry<String>>((nameState) {
                                                      return DropdownMenuEntry<String>(
                                                          value: nameState, label: nameState);
                                                    }).toList(),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: TextButton(
                                                onPressed: () async {
                                                  Navigator.of(context).pop();
                                                  await updateState(userIdToFetch, selectedStateId);
                                                  await fetchUserData(userIdToFetch);
                                                  setState(() {});
                                                },
                                                child: Text('OK',
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
                                    color: AppColor.colorBlack.withOpacity(0.8),
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
                ],
              ),
            )
          ],
        ));
  }
}
