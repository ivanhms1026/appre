import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;

import 'package:appre/main.dart';
import 'package:appre/colors.dart';
import 'package:appre/menu_app/login/session.dart';
import 'package:appre/super_administrator_module/userInformationSuper.dart';

class SuperModule extends StatefulWidget {
  final UserCredentials credentials;

  const SuperModule({Key? key, required this.credentials}) : super(key: key);

  @override
  State<SuperModule> createState() => _SuperModuleState();
}

class _SuperModuleState extends State<SuperModule> {
  List<Map<String, dynamic>> userList = [];

  Future<void> fetchUserData() async {
    final response = await http.get(Uri.parse("https://appreopc.000webhostapp.com/getdata.php"));
    print("Response status code: ${response.statusCode}");
    print("Response body: ${response.body}");
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      setState(() {
        userList = jsonResponse.cast<Map<String, dynamic>>();
      });
    } else {
      throw Exception('Failed to load user data');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    final String user = widget.credentials.user;
    final String pass = widget.credentials.pass;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          SizedBoxContainer(
            screenWidth: screenWidth,
            screenHeight: screenHeight,
            user: user,
            pass: pass,
            credentials: widget.credentials,
          ),
          Expanded(child: ExpandedListView(screenHeight: screenHeight, screenWidth: screenWidth, userList: userList))
        ],
      ),
    );
  }
}

class SizedBoxContainer extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;
  final String user;
  final String pass;
  final UserCredentials credentials;

  const SizedBoxContainer(
      {super.key,
      required this.screenHeight,
      required this.screenWidth,
      required this.user,
      required this.pass,
      required this.credentials});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      width: screenWidth,
      height: 300.h,
      child: Container(
        padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: Container()),
                GestureDetector(
                  onTap: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Main(credentials: credentials),
                      ),
                    );
                  },
                  child: Container(
                    width: 50.w,
                    height: 50.h,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.widgets_outlined,
                      size: 25,
                      color: AppColor.colorTextOne,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              color: AppColor.colorBlack,
              width: screenWidth,
              height: 190.h,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    flex: 7,
                    child: Container(
                      width: 100.w,
                      height: 100.h,
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
                    flex: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            '${credentials.name} ${credentials.lastname}',
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
                            credentials.userLevel == 1
                                ? 'Super Administrador'
                                : credentials.userLevel == 2
                                    ? 'Administrador'
                                    : credentials.userLevel == 3
                                        ? 'Usuario'
                                        : 'Desconocido',
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
          ],
        ),
      ),
    );
  }
}

class ExpandedListView extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;
  final List<Map<String, dynamic>> userList;

  const ExpandedListView({super.key, required this.screenHeight, required this.screenWidth, required this.userList});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                color: AppColor.colorWhite,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(40),
                  topLeft: Radius.circular(40),
                )),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 30.w, right: 30.w, top: 20.h),
                  width: screenWidth,
                  height: 80.h,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Lista de miembros',
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
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: userList.length,
                    itemBuilder: (BuildContext context, int index) {
                      final user = userList[index];
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  margin: const EdgeInsets.all(10),
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: AssetImage('assets/user.jpg'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "${user['name_user']} ${user['lastname']}",
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Documento: ',
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              color: Colors.black,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            '${user['document_number']}',
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              color: Colors.black,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Expanded(child: Container()),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        Icons.arrow_forward_rounded,
                                        size: 30.h,
                                        color: Colors.black,
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => UserInformationAdmin(
                                              userData: user,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
