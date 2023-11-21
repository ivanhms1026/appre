import 'package:appre/menu_app/arm_rehabilitation/pathologies/types_phases/recovery_type/RecoveryType.dart';
import 'package:appre/menu_app/json/zonaMyMJson.dart';
import 'package:flutter/material.dart';

class RecoveryTypeScalefactor extends StatelessWidget {
  const RecoveryTypeScalefactor({Key? key, required this.data}) : super(key: key);
  final zonaMyM data;

  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context);
    return MediaQuery(
      data: query.copyWith(
        textScaleFactor: query.textScaleFactor.clamp(1.0, 1.1),
      ),
      child: Theme(
          data: ThemeData.light(),
          child: RecoveryType(
            data: data,
          )),
    );
  }
}
