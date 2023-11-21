import 'package:flutter/material.dart';
import '../arm_rehabilitation/RehabilitationZone.dart';

class RehabilitationZoneScalefactor extends StatelessWidget {
  const RehabilitationZoneScalefactor({super.key});

  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context);
    return MediaQuery(
      data: query.copyWith(
        textScaleFactor: query.textScaleFactor.clamp(1.0, 1.1),
      ),
      child: Theme(data: ThemeData.light(), child: const RehabilitationZone()),
    );
  }
}
