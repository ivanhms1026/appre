import 'package:appre/menu_app/login/session.dart';
import 'package:appre/menu_app/profile/edit_profile/EditProfile.dart';
import 'package:appre/menu_app/profile/usage_policies/UsagePolicies.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'package:appre/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'terms _conditions/TermsConditions.dart';

class ProfileMenu extends StatefulWidget {
  final UserCredentials credentials;

  const ProfileMenu({super.key, required this.credentials});

  @override
  State<ProfileMenu> createState() => _ProfileMenuState();
}

class _ProfileMenuState extends State<ProfileMenu> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    String message = 'Usuario';
    if (widget.credentials.userLevel != null) {
      if (widget.credentials.userLevel == 1) {
        message = 'Super administrador';
      } else if (widget.credentials.userLevel == 2) {
        message = 'Administrador';
      } else {
        message = 'Usuario';
      }
    }

    return Scaffold(
      body: Container(
        color: AppColor.colorWhite,
        child: Column(
          children: [
            SizedBox(
              width: screenWidth,
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: 70.w,
                        height: 70.h,
                        margin: EdgeInsets.only(left: 20.w, top: 60.h),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage('assets/user.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20.w, top: 60.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '${widget.credentials.name} ${widget.credentials.lastname}',
                                style: TextStyle(
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                message,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.black.withOpacity(0.8),
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
                  Container(
                    width: screenWidth,
                    height: 2.h,
                    margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                    color: AppColor.colorBlack.withOpacity(0.2),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0.h),
                    height: 580.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            AutoSizeText(
                              "Editar perfil",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17.sp,
                                color: AppColor.colorBlack,
                              ),
                            ),
                            Expanded(child: Container()),
                            IconButton(
                              icon: Icon(
                                Icons.arrow_forward_rounded,
                                size: 35.h,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => EditProfile(credentials: widget.credentials)),
                                );
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          children: [
                            AutoSizeText(
                              "Terminos y condiciones",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17.sp,
                                color: AppColor.colorBlack,
                              ),
                            ),
                            Expanded(child: Container()),
                            IconButton(
                              icon: Icon(
                                Icons.arrow_forward_rounded,
                                size: 35.h,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => TermsConditions()),
                                );
                              },
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          children: [
                            AutoSizeText(
                              "Politicas de uso",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17.sp,
                                color: AppColor.colorBlack,
                              ),
                            ),
                            Expanded(child: Container()),
                            IconButton(
                              icon: Icon(
                                Icons.arrow_forward_rounded,
                                size: 35.h,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UsagePolicies(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        Expanded(child: Container()),
                        Container(
                          width: screenWidth,
                          height: 2.h,
                          margin: EdgeInsets.symmetric(vertical: 10.h),
                          color: AppColor.colorBlack.withOpacity(0.2),
                        ),
                        Container(
                            padding: EdgeInsets.only(right: 20.w, top: 15.h),
                            child: InkWell(
                              onTap: () async {
                                await Session.removeCredential(widget.credentials.user, widget.credentials.pass);
                              },
                              child: Row(
                                children: [
                                  Container(
                                    width: 40.w,
                                    height: 40.h,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.redAccent,
                                    ),
                                    child: IconButton(
                                      icon: const Icon(Icons.power_settings_new_outlined, color: Colors.white),
                                      iconSize: 20.h,
                                      onPressed: () {},
                                    ),
                                  ),
                                  SizedBox(width: 15.h),
                                  AutoSizeText(
                                    "Cerrar sesión",
                                    style: TextStyle(
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black.withOpacity(0.4),
                                    ),
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
