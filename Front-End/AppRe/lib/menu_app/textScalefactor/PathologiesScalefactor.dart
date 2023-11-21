import 'package:appre/menu_app/arm_rehabilitation/pathologies/Pathologies.dart';
import 'package:flutter/material.dart';


class PathologiesScalefactor extends StatelessWidget {
  const PathologiesScalefactor({super.key});

  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context);
    return MediaQuery(
      data: query.copyWith(
        textScaleFactor: query.textScaleFactor.clamp(1.0, 1.1),
      ),
      child: Theme(data: ThemeData.light(), child: const Pathologies()),
    );
  }
}
