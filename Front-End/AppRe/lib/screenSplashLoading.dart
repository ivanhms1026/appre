import 'package:appre/main.dart';
import 'package:appre/menu_app/textScalefactor/MainScalefactor.dart';
import 'package:flutter/material.dart';
import 'package:appre/colors.dart';

import 'menu_app/login/login.dart';

class screenSplashLoading extends StatefulWidget {
  @override
  _screenSplashLoadingState createState() => _screenSplashLoadingState();
}

class _screenSplashLoadingState extends State<screenSplashLoading> {
  @override
  void initState() {
    Future.delayed(
      const Duration(milliseconds: 4500),
      () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Login()),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: AppColor.colorWhite,
      child: SafeArea(
        child: Column(
          children: [
            Expanded(flex: 3, child: Container()),
            Expanded(
              flex: 4,
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Image.asset(
                        'assets/imagelogo2.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(flex: 3, child: Container()),
            CircularProgressIndicator(
              color: AppColor.colorBlack,
            ),
            const SizedBox(
              height: 20,
            ),
            Text("Universidad Mariana",
                style: TextStyle(
                  color: AppColor.colorBlack,
                  fontSize: 15,
                )),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    ));
  }
}
