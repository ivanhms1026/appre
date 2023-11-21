import 'package:appre/menu_app/arm_rehabilitation/pathologies/types_phases/recovery_type/video_list/video_player/json.dart';
import 'package:appre/menu_app/arm_rehabilitation/pathologies/types_phases/recovery_type/video_list/video_player/newAuto.dart';
import 'package:appre/menu_app/json/zonaMyMJson.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:appre/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class reproductorAutodirigido extends StatefulWidget {
  const reproductorAutodirigido({Key? key, required this.movimiento, required this.Cindex, required this.data})
      : super(key: key);

  final int Cindex;
  final ListasMovimiento movimiento;
  final zonaMyM data;

  @override
  _reproductorAutodirigidoState createState() => _reproductorAutodirigidoState(movimiento, Cindex, data);
}

class _reproductorAutodirigidoState extends State<reproductorAutodirigido> {
  final ListasMovimiento movie;
  final int Cindex;
  final zonaMyM data;

  late YoutubePlayerController _controller;

  _reproductorAutodirigidoState(this.movie, this.Cindex, this.data);

  @override
  void initState() {
    super.initState();
    final url = movie.videoUrl;
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(url)!,
      flags: const YoutubePlayerFlags(
        mute: false,
        loop: true,
        autoPlay: true,
      ),
    );
  }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
      ),
      builder: (context, player) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          toolbarHeight: 55.h,
          leading: BackButton(color: AppColor.colorBlack),
          title: Text(
            widget.movimiento.title,
            style: TextStyle(
              fontSize: 15.sp,
              color: AppColor.colorBlack,
            ),
          ),
          centerTitle: false,
          elevation: 2,
          flexibleSpace: Container(
            color: AppColor.colorWhite,
          ),
        ),
        body: Container(
          child: Column(
            children: [
              player,
              SizedBox(
                height: 15.h,
              ),
              CustomRepeticionesContainer(),
              SizedBox(
                height: 15.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomRepeticionesContainer extends StatelessWidget {
  const CustomRepeticionesContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: Container(
            color: Colors.red,
          )),
          Expanded(child: Container(color: Colors.amber)),
        ],
      ),
    );
  }
}
