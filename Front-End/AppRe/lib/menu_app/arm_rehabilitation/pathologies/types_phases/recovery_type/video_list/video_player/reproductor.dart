import 'package:appre/menu_app/arm_rehabilitation/pathologies/types_phases/recovery_type/video_list/video_player/json.dart';
import 'package:appre/menu_app/arm_rehabilitation/pathologies/types_phases/recovery_type/video_list/video_player/newAuto.dart';
import 'package:appre/menu_app/arm_rehabilitation/pathologies/types_phases/recovery_type/video_list/video_player/reproductor_autodirigido.dart';
import 'package:appre/menu_app/json/zonaMyMJson.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:appre/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

late YoutubePlayerController _controller;

class reproductor extends StatefulWidget {
  const reproductor({Key? key, required this.movimiento, required this.Cindex, required this.data}) : super(key: key);

  final int Cindex;
  final ListasMovimiento movimiento;
  final zonaMyM data;

  @override
  _reproductorState createState() => _reproductorState(movimiento, Cindex, data);
}

class _reproductorState extends State<reproductor> {
  final ListasMovimiento movie;
  final int Cindex;
  final zonaMyM data;

  _reproductorState(this.movie, this.Cindex, this.data);

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
    super.deactivate();
    _controller.pause();
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
              SizedBox(height: 10.h),
              CustomContainer(
                  title: "Como hacerlo a${Cindex}",
                  description: widget.movimiento.chacer,
                  movie: movie,
                  autoDirigido: widget.movimiento.autoDirigido,
                  Cindex: Cindex,
                  data: data),
              SizedBox(
                height: 15.h,
              ),
              CustomRepeticionesContainer(
                  title: "Numero de repeticiones", repeticiones: widget.movimiento.repeticiones),
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

class CustomContainer extends StatelessWidget {
  final String title;
  final String description;
  final ListasMovimiento movie;
  final bool autoDirigido;
  final int Cindex;
  final zonaMyM data;

  const CustomContainer({
    super.key,
    required this.title,
    required this.description,
    required this.movie,
    required this.autoDirigido,
    required this.Cindex,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 12.w, right: 12.w),
            child: Row(
              children: [
                AutoSizeText(
                  title,
                  style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColor.colorBlack,
                  ),
                ),
                Expanded(child: Container()),
                Visibility(
                  visible: autoDirigido,
                  child: ElevatedButton(
                    onPressed: () async {
                      _controller.pause();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => newAuto(movimiento: movie, Cindex: Cindex, data: data)),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      textStyle: const TextStyle(color: Colors.white),
                    ),
                    child: Text(
                      "Movimiento Autodirigido",
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 11.sp),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 12.w, right: 12.w),
            child: AutoSizeText(
              description,
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 15.sp,
                color: AppColor.colorfontParagraph,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomRepeticionesContainer extends StatelessWidget {
  final String title;
  final String repeticiones;

  const CustomRepeticionesContainer({super.key, required this.title, required this.repeticiones});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 12.w, right: 12.w),
            child: AutoSizeText(
              title,
              style: TextStyle(
                fontSize: 17.sp,
                fontWeight: FontWeight.bold,
                color: AppColor.colorBlack,
              ),
            ),
          ),
          SizedBox(
            height: 5.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 12.w, right: 12.w),
            child: AutoSizeText(
              repeticiones,
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 15.sp,
                color: AppColor.colorfontParagraph,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
