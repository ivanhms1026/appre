import 'package:appre/menu_app/arm_rehabilitation/pathologies/types_phases/recovery_type/video_list/video_player/json.dart';
import 'package:appre/menu_app/arm_rehabilitation/pathologies/types_phases/recovery_type/video_list/video_player/reproductor.dart';
import 'package:appre/menu_app/json/zonaMyMJson.dart';
import 'package:flutter/material.dart';


class reproductorVideos extends StatelessWidget {

  const reproductorVideos({Key? key, required this.movimiento, required this.Cindex, required this.data}) : super(key: key);
  final zonaMyM data;
  final int Cindex;
  final ListasMovimiento movimiento;

  @override
  Widget build(BuildContext context) {
    final query = MediaQuery.of(context);
    print('textScaleFactor: ${query.textScaleFactor}');
    print('devicePixelRatio: ${query.devicePixelRatio}');

    return MediaQuery(
      data: query.copyWith(
        textScaleFactor: query.textScaleFactor.clamp(1.0, 1.1),
      ),
      child: Theme(data: ThemeData.light(), child:  reproductor(movimiento: movimiento, Cindex: Cindex, data: data,)),
    );
  }
}
