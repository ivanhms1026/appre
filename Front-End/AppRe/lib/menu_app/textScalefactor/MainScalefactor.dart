import 'package:appre/main.dart';
import 'package:appre/menu_app/login/session.dart';
import 'package:flutter/material.dart';

class MainScalefactor extends StatelessWidget {
  final UserCredentials credentials;
  const MainScalefactor({Key? key, required this.credentials}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context);
    final textScaleFactor = query.textScaleFactor.clamp(1.0, 1.1);

    return MediaQuery(
      data: query.copyWith(textScaleFactor: textScaleFactor),
      child: Main(credentials:credentials),
    );
  }
}