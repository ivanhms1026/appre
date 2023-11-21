import 'dart:async';

import 'package:appre/menu_app/arm_rehabilitation/pathologies/types_phases/recovery_type/video_list/video_player/json.dart';
import 'package:appre/menu_app/arm_rehabilitation/pathologies/types_phases/recovery_type/video_list/video_player/jsonAuto.dart';
import 'package:appre/colors.dart';
import 'package:appre/menu_app/json/zonaMyMJson.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

String urlVideo = "";
String basicInformacion = "";
String numRepeticiones = "";
Duration duration = const Duration();

class newAuto extends StatefulWidget {
  const newAuto({Key? key, required this.data, required this.movimiento, required this.Cindex}) : super(key: key);

  final zonaMyM data;
  final ListasMovimiento movimiento;
  final int Cindex;

  @override
  _newAutoState createState() => _newAutoState(movimiento, Cindex, data);
}

class _newAutoState extends State<newAuto> {
  final int Cindex;
  late final ListasMovimiento movimientoEncontrado;
  final zonaMyM data;
  String? selectedTitle;
  late YoutubePlayerController _controller;

  _newAutoState(this.movimientoEncontrado, this.Cindex, this.data);

  String _getTitleForCondition(int itemPatologia, int itemFaseHombro) {
    // PATOLOGICA DE HOMBRO
    // Fase Aguda
    if (itemPatologia == 1 && itemFaseHombro == 0 && Cindex == 1) {
      List<String> basicInformacionAuto =
          ListCodoAgudaFortalecimientoAuto.map((movimiento) => movimiento.chacer).toList();
      List<String> numRepeticionesAuto =
          ListCodoAgudaFortalecimientoAuto.map((movimiento) => movimiento.repeticiones).toList();
      List<String> urlVideoAuto = ListCodoAgudaFortalecimientoAuto.map((movimiento) => movimiento.videoUrl).toList();
      int index = ListCodoAgudaFortalecimiento.indexOf(widget.movimiento);
      if (index >= 0 && index < urlVideoAuto.length) {
        urlVideo = urlVideoAuto[index];
        basicInformacion = basicInformacionAuto[index];
        numRepeticiones = numRepeticionesAuto[index];
      }
    } else if (itemPatologia == 0 && itemFaseHombro == 0 && Cindex == 1) {
      List<String> titles = ListHombroAgudaFortalecimientoAuto.map((movimiento) => movimiento.title).toList();
      int index = ListHombroAgudaFortalecimiento.indexOf(widget.movimiento);
      if (index >= 0 && index < titles.length) {
        urlVideo = titles[index];
      }
    } else if (itemPatologia == 0 && itemFaseHombro == 0 && Cindex == 2) {
      List<String> titles = ListHombroAgudaFlexibilidadAuto.map((movimiento) => movimiento.title).toList();
      int index = ListHombroAgudaFlexibilidad.indexOf(widget.movimiento);
      if (index >= 0 && index < titles.length) {
        urlVideo = titles[index];
      }
    } else if (itemPatologia == 0 && itemFaseHombro == 0 && Cindex == 3) {
      List<String> titles = ListHombroAgudaDolorAuto.map((movimiento) => movimiento.title).toList();
      int index = ListHombroAgudaDolor.indexOf(widget.movimiento);
      if (index >= 0 && index < titles.length) {
        urlVideo = titles[index];
      }
    }
    // Fase Cronica
    else if (itemPatologia == 0 && itemFaseHombro == 1 && Cindex == 0) {
      List<String> titles = ListHombroCronicoMovimientoAuto.map((movimiento) => movimiento.title).toList();
      int index = ListHombroCronicoMovimiento.indexOf(widget.movimiento);
      if (index >= 0 && index < titles.length) {
        urlVideo = titles[index];
      }
    } else if (itemPatologia == 0 && itemFaseHombro == 1 && Cindex == 1) {
      List<String> titles = ListHombroCronicoFortalecimientoAuto.map((movimiento) => movimiento.title).toList();
      int index = ListHombroCronicoFortalecimiento.indexOf(widget.movimiento);
      if (index >= 0 && index < titles.length) {
        urlVideo = titles[index];
      }
    } else if (itemPatologia == 0 && itemFaseHombro == 1 && Cindex == 2) {
      List<String> titles = ListHombroCronicoFlexibilidadAuto.map((movimiento) => movimiento.title).toList();
      int index = ListHombroCronicoFlexibilidad.indexOf(widget.movimiento);
      if (index >= 0 && index < titles.length) {
        urlVideo = titles[index];
      }
    } else if (itemPatologia == 0 && itemFaseHombro == 1 && Cindex == 3) {
      List<String> titles = ListHombroCronicoDolorAuto.map((movimiento) => movimiento.title).toList();
      int index = ListHombroCronicoDolor.indexOf(widget.movimiento);
      if (index >= 0 && index < titles.length) {
        urlVideo = titles[index];
      }
    }

    return urlVideo;
  }

  @override
  void initState() {
    super.initState();
    urlVideo = _getTitleForCondition(widget.data.itemPatologia, widget.data.itemFaseHombro);
    print(urlVideo);
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(urlVideo)!,
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
    _stopSensorUpdates();
    _controller.dispose();
    super.dispose();
  }

  void _stopSensorUpdates() {
    gyroscopeEvents.drain();
    accelerometerEvents.drain();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
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
        body: SizedBox(
          width: screenWidth,
          height: screenHeight,
          child: Column(
            children: [
              player,
              Expanded(child: containerExpanded()),
            ],
          ),
        ),
      ),
    );
  }
}

class containerExpanded extends StatefulWidget {
  @override
  _containerExpandedState createState() => _containerExpandedState();
}

class _containerExpandedState extends State<containerExpanded> {
  bool mostrarCronometro = false;
  bool mostrarInformacion = false;
  double xGyro = 0, yGyro = 0, zGyro = 0;
  double xAccel = 0, yAccel = 0, zAccel = 0;
  int repetitionCount = 0;
  bool isInclined = false;
  bool isInRange = false;
  Timer? timer;
  bool isRunning = false;

  DateTime? _startTime;

  @override
  void initState() {
    super.initState();
    _startSensorUpdates();
  }

  @override
  void dispose() {
    _stopSensorUpdates();
    super.dispose();
  }

  void _stopSensorUpdates() {
    gyroscopeEvents.drain();
    accelerometerEvents.drain();
  }

  void _startSensorUpdates() {
    gyroscopeEvents.listen((GyroscopeEvent event) {
      if (mounted) {
        setState(() {
          xGyro = event.x;
          yGyro = event.y;
          zGyro = event.z;
        });
      }
    });

    accelerometerEvents.listen((AccelerometerEvent event) {
      if (mounted) {
        setState(() {
          xAccel = event.x;
          yAccel = event.y;
          zAccel = event.z;
          _checkInclination(); // Verificar inclinación
        });
      }
    });
  }

  void _checkInclination() {
    if (yAccel > -9.99 && yAccel < 8.99 && zAccel > 0.01) {
      setState(() {
        isInclined = true;
        if (yAccel > 7.99 && yAccel < 9.99 && !isInRange) {
          // Dentro del rango inicial de 9.00 a 9.99
          setState(() {
            isInRange = true;
          });
        } else if (yAccel > -9.99 && yAccel < -7.99 && isInRange) {
          // Dentro del rango objetivo de 0.01 a 2.00 después de estar en el rango inicial
          setState(() {
            repetitionCount++;
            isInRange = false; // Reiniciar el estado del rango inicial
          });
        }
      });
    } else {
      setState(() {
        isInclined = false;
      });
    }
  }

  void _resetRepetitionCount() {
    setState(() {
      repetitionCount = 0;
    });
  }

  void startOrPauseTimer() {
    if (isRunning) {
      timer?.cancel();
    } else {
      timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
    }
    setState(() {
      isRunning = !isRunning;
    });
  }

  void addTime() {
    setState(() {
      duration = duration + const Duration(seconds: 1);
    });
  }

  void resetTimer() {
    timer?.cancel();
    setState(() {
      duration = const Duration();
      isRunning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(repetitionCount);
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          mostrarCronometro
              ? Expanded(
                  child: Column(
                    children: [
                      Expanded(
                          flex: 3,
                          child: Container(
                            //color: Colors.yellow,
                            child: Padding(
                              padding: EdgeInsets.only(left: 12.w, right: 12.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10.h),
                                  AutoSizeText(
                                    "Como hacerlo",
                                    style: TextStyle(
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.colorBlack,
                                    ),
                                  ),
                                  SizedBox(height: 5.h),
                                  RichText(
                                    textAlign: TextAlign.justify,
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: basicInformacion,
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: AppColor.colorfontParagraph,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )),
                      Expanded(
                          flex: 5,
                          child: Container(
                            //color: Colors.brown,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                    flex: 3,
                                    child: Container(
                                      //color: Colors.red,
                                      child: Container(
                                        width: 60,
                                        height: 60,
                                        padding: const EdgeInsets.all(4),
                                        decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.black),
                                        child: Container(
                                          width: 60,
                                          height: 60,
                                          decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                                          child: Center(
                                              child: Column(
                                            children: [
                                              IconButton(
                                                onPressed: startOrPauseTimer,
                                                icon: Icon(
                                                  isRunning ? Icons.pause : Icons.play_arrow,
                                                  size: 32, // Tamaño personalizado
                                                ),
                                              )
                                            ],
                                          )),
                                        ),
                                      ),
                                    )),
                                Expanded(
                                    flex: 5,
                                    child: Container(
                                      //color: Colors.green,
                                      child: Container(
                                        width: 180,
                                        height: 180,
                                        padding: const EdgeInsets.all(4),
                                        decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.black),
                                        child: Container(
                                          width: 60,
                                          height: 60,
                                          decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                                          child: Center(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "$repetitionCount",
                                                  style: TextStyle(fontSize: 70.sp, fontWeight: FontWeight.bold),
                                                ),
                                                Text(
                                                  "Reps",
                                                  style: TextStyle(fontSize: 15.sp),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )),
                                Expanded(
                                    flex: 3,
                                    child: Container(
                                      //color: Colors.redAccent,
                                      child: CounterApp(),
                                    )),
                              ],
                            ),
                          )),
                      Expanded(
                          flex: 2,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                durationToString(duration),
                                style: TextStyle(
                                  fontSize: 25.sp,
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                )
              : Expanded(
                  child: Container(
                    child: Column(
                      children: [
                        Expanded(
                            flex: 8,
                            child: Container(
                              child: Column(
                                children: [
                                  SizedBox(height: 10.h),
                                  CustomContainer(
                                    title: "Como hacerlo",
                                    description: basicInformacion,
                                  ),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                  CustomRepeticionesContainer(
                                      title: "Numero de repeticiones", repeticiones: numRepeticiones),
                                ],
                              ),
                            )),
                        Expanded(
                            flex: 2,
                            child: Container(
                              child: Center(
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      mostrarCronometro = true;
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    textStyle: const TextStyle(color: Colors.black),
                                  ),
                                  child: const Text('Comenzar Ejercicio'),
                                ),
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}

class CustomContainer extends StatelessWidget {
  final String title;
  final String description;

  const CustomContainer({
    super.key,
    required this.title,
    required this.description,
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

class CounterApp extends StatefulWidget {
  @override
  _CounterAppState createState() => _CounterAppState();
}

class _CounterAppState extends State<CounterApp> {
  int contador = 5;

  void incrementarContador() {
    setState(() {
      contador++;
    });
  }

  void disminuirContador() {
    setState(() {
      contador--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          '$contador',
          style: const TextStyle(fontSize: 25),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                incrementarContador();
              },
              child: Container(
                width: 25,
                height: 25,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                ),
                child: const Stack(
                  fit: StackFit.expand,
                  children: [
                    Center(
                      child: Icon(
                        Icons.add,
                        size: 15,
                        color: Colors.white, // Cambia el color según tus necesidades
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 7),
            InkWell(
              onTap: () {
                disminuirContador();
              },
              child: Container(
                width: 25,
                height: 25,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                ),
                child: const Stack(
                  fit: StackFit.expand,
                  children: [
                    Center(
                      child: Icon(
                        Icons.remove,
                        size: 15,
                        color: Colors.white, // Cambia el color según tus necesidades
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

String durationToString(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  final hours = twoDigits(duration.inHours);
  final minutes = twoDigits(duration.inMinutes.remainder(60));
  final seconds = twoDigits(duration.inSeconds.remainder(60));
  return '$hours:$minutes:$seconds';
}
