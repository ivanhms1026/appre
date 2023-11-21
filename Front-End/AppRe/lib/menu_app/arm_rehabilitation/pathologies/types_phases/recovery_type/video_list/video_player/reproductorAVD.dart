import 'package:appre/menu_app/arm_rehabilitation/pathologies/types_phases/recovery_type/video_list/video_player/json.dart';
import 'package:appre/menu_app/arm_rehabilitation/pathologies/types_phases/recovery_type/video_list/video_player/newAuto.dart';
import 'package:appre/menu_app/json/zonaMyMJson.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:appre/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class reproductorAvd extends StatefulWidget {
  const reproductorAvd({Key? key, required this.movimiento}) : super(key: key);

  final ListasMovimiento movimiento;

  @override
  _reproductorAvdState createState() => _reproductorAvdState(movimiento);
}

class _reproductorAvdState extends State<reproductorAvd> {
  final ListasMovimiento movie;

  late YoutubePlayerController _controller;

  _reproductorAvdState(this.movie);

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
        body: ListView(
          children: [
            player,
            SizedBox(height: 10.h),
            CustomContainer(title: "Como hacerlo", description: widget.movimiento.chacer),
            SizedBox(
              height: 15.h,
            ),
            CustomRepeticionesContainer(title: "Numero de repeticiones", repeticiones: widget.movimiento.repeticiones),
            SizedBox(
              height: 15.h,
            ),
            /*Container(
              width: MediaQuery.of(context).size.width * 0.3,
              height: MediaQuery.of(context).size.height* 0.065,
              decoration: ShapeDecoration(
                shape: const StadiumBorder(),
                color: AppColor.colorBlack.withOpacity(0.8),
              ),
              child: MaterialButton(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: const StadiumBorder(),
                child: Icon(
                  Icons.east_outlined,
                  size: MediaQuery.of(context).size.width * 0.12,
                  color: AppColor.colorBlack,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => newAuto(movimiento: widget.movimiento, Cindex: Cindex, data: widget.data,))
                  );
                },
              ),
            )*/
          ],
        ),
      ),
    );
  }
}

class CustomContainer extends StatelessWidget {
  final String title;
  final String description;

  const CustomContainer({super.key, required this.title, required this.description});

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
