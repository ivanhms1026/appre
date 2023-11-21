import 'dart:async';
import 'package:appre/menu_app/arm_rehabilitation/pathologies/types_phases/recovery_type/FadeAnimation.dart';
import 'package:appre/menu_app/arm_rehabilitation/pathologies/types_phases/recovery_type/video_list/listaVideosAVD.dart';
import 'package:appre/menu_app/arm_rehabilitation/pathologies/types_phases/recovery_type/video_list/video_player/json.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'package:appre/colors.dart';
import 'package:appre/menu_app/json/zonaMyMJson.dart';
import 'package:appre/menu_app/textScalefactor/reproductorVideosScalefactor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

int currentIndex = 0;
int currentTabIndex = 0;
final List<List<String>> products = [
  ['assets/listOne.jpg'],
  ['assets/listTwo.jpg'],
  ['assets/listThree.jpg']
];

class RecoveryType extends StatefulWidget {
  const RecoveryType({Key? key, required this.data}) : super(key: key);
  final zonaMyM data;

  @override
  State<RecoveryType> createState() => _RecoveryTypeState(data);
}

class _RecoveryTypeState extends State<RecoveryType> with TickerProviderStateMixin {
  final zonaMyM data;

  _RecoveryTypeState(this.data);

  List<ListasMovimiento> _getListForCondition(int itemPatologia, int itemFaseHombro) {
    List<ListasMovimiento> result = [];
    if (itemPatologia == 0) {
      result = (itemFaseHombro == 0) ? ListHombroAgudaMovimiento : ListHombroCronicoMovimiento;
    } else if (itemPatologia == 1) {
      result = (itemFaseHombro == 0) ? ListCodoAgudaMovimiento : ListCodoCronicoMovimiento;
    } else if (itemPatologia == 2) {
      result = (itemFaseHombro == 0) ? ListMunecaAgudaMovimiento : ListMunecaCronicoMovimiento;
    } else if (itemPatologia == 3) {
      result = (itemFaseHombro == 0) ? ListManoAgudaMovimiento : ListManoCronicoMovimiento;
    }

    if (result.isEmpty) {
      result = [];
    }
    return result;
  }

  List<ListasMovimiento> _getListFortalecimiento(int itemPatologia, int itemFaseHombro) {
    List<ListasMovimiento> result = [];
    if (itemPatologia == 0) {
      result = (itemFaseHombro == 0) ? ListHombroAgudaFortalecimiento : ListHombroCronicoFortalecimiento;
    } else if (itemPatologia == 1) {
      result = (itemFaseHombro == 0) ? ListCodoAgudaFortalecimiento : ListCodoCronicoFortalecimiento;
    } else if (itemPatologia == 2) {
      result = (itemFaseHombro == 0) ? ListMunecaAgudaFortalecimiento : ListMunecaCronicoFortalecimiento;
    } else if (itemPatologia == 3) {
      result = (itemFaseHombro == 0) ? ListManoAgudaFortalecimiento : ListManoCronicoFortalecimiento;
    }
    if (result.isEmpty) {
      result = [];
    }
    return result;
  }

  List<ListasMovimiento> _getListFlexibilidad(int itemPatologia, int itemFaseHombro) {
    List<ListasMovimiento> result = [];
    if (itemPatologia == 0) {
      result = (itemFaseHombro == 0) ? ListHombroAgudaFlexibilidad : ListHombroCronicoFlexibilidad;
    } else if (itemPatologia == 1) {
      result = (itemFaseHombro == 0) ? ListCodoAgudaFlexibilidad : ListCodoCronicoFlexibilidad;
    } else if (itemPatologia == 2) {
      result = (itemFaseHombro == 0) ? ListMunecaAgudaFlexibilidad : ListMunecaCronicoFlexibilidad;
    } else if (itemPatologia == 3) {
      result = (itemFaseHombro == 0) ? ListManoAgudaFlexibilidad : ListManoCronicoFlexibilidad;
    }
    if (result.isEmpty) {
      result = [];
    }
    return result;
  }

  List<ListasMovimiento> _getListDolor(int itemPatologia, int itemFaseHombro) {
    List<ListasMovimiento> result = [];
    if (itemPatologia == 0) {
      result = (itemFaseHombro == 0) ? ListHombroAgudaDolor : ListHombroCronicoDolor;
    } else if (itemPatologia == 1) {
      result = (itemFaseHombro == 0) ? ListCodoAgudaDolor : ListCodoCronicoDolor;
    } else if (itemPatologia == 2) {
      result = (itemFaseHombro == 0) ? ListMunecaAgudaDolor : ListMunecaCronicoDolor;
    } else if (itemPatologia == 3) {
      result = (itemFaseHombro == 0) ? ListManoAgudaDolor : ListManoCronicoDolor;
    }
    if (result.isEmpty) {
      result = [];
    }
    return result;
  }

  List<zonaMyM> _getLisReentrenamiento(int itemPatologia, int itemFaseHombro) {
    List<zonaMyM> resultAVD = [];
    if (itemPatologia == 0) {
      resultAVD = (itemFaseHombro == 0) ? botonesListAvdAgudaHombro : botonesListAvdCronicaHombro;
    } else if (itemPatologia == 1) {
      resultAVD = (itemFaseHombro == 0) ? botonesListAvdAgudaCodo : botonesListAvdCronicaCodo;
    } else if (itemPatologia == 2) {
      resultAVD = (itemFaseHombro == 0) ? botonesListAvdAgudaMuneca : botonesListAvdCronicaMuneca;
    } else if (itemPatologia == 3) {
      resultAVD = (itemFaseHombro == 0) ? botonesListAvdAgudaMano : botonesListAvdCronicaMano;
    }
    if (resultAVD.isEmpty) {
      resultAVD = [];
    }
    return resultAVD;
  }

  late TabController _tabController;

  @override
  void initState() {
    super.initState();

// Copiar las listas originales en nuevas listas
    // Copiar las listas originales en nuevas listas
    List<ListasMovimiento> hombroAgudaMovimiento = List.from(ListHombroAgudaMovimiento);
    List<ListasMovimiento> hombroCronicoMovimiento = List.from(ListHombroCronicoMovimiento);
    List<ListasMovimiento> codoAgudaMovimiento = List.from(ListCodoAgudaMovimiento);
    List<ListasMovimiento> codoCronicoMovimiento = List.from(ListCodoCronicoMovimiento);
    List<ListasMovimiento> munecaAgudaMovimiento = List.from(ListMunecaAgudaMovimiento);
    List<ListasMovimiento> munecaCronicoMovimiento = List.from(ListMunecaCronicoMovimiento);
    List<ListasMovimiento> manoAgudaMovimiento = List.from(ListManoAgudaMovimiento);
    List<ListasMovimiento> manoCronicoMovimiento = List.from(ListManoCronicoMovimiento);

    // Limpia las listas originales
    ListHombroAgudaMovimiento.clear();
    ListHombroCronicoMovimiento.clear();
    ListCodoAgudaMovimiento.clear();
    ListCodoCronicoMovimiento.clear();
    ListMunecaAgudaMovimiento.clear();
    ListMunecaCronicoMovimiento.clear();
    ListManoAgudaMovimiento.clear();
    ListManoCronicoMovimiento.clear();

    // Asigna las nuevas listas a las originales
    ListHombroAgudaMovimiento = hombroAgudaMovimiento;
    ListHombroCronicoMovimiento = hombroCronicoMovimiento;
    ListCodoAgudaMovimiento = codoAgudaMovimiento;
    ListCodoCronicoMovimiento = codoCronicoMovimiento;
    ListMunecaAgudaMovimiento = munecaAgudaMovimiento;
    ListMunecaCronicoMovimiento = munecaCronicoMovimiento;
    ListManoAgudaMovimiento = manoAgudaMovimiento;
    ListManoCronicoMovimiento = manoCronicoMovimiento;

    // Limpia las listas de fortalecimiento
    // Copiar las listas originales en nuevas listas
    List<ListasMovimiento> hombroAgudaFortalecimiento = List.from(ListHombroAgudaFortalecimiento);
    List<ListasMovimiento> hombroCronicoFortalecimiento = List.from(ListHombroCronicoFortalecimiento);
    List<ListasMovimiento> codoAgudaFortalecimiento = List.from(ListCodoAgudaFortalecimiento);
    List<ListasMovimiento> codoCronicoFortalecimiento = List.from(ListCodoCronicoFortalecimiento);
    List<ListasMovimiento> munecaAgudaFortalecimiento = List.from(ListMunecaAgudaFortalecimiento);
    List<ListasMovimiento> munecaCronicoFortalecimiento = List.from(ListMunecaCronicoFortalecimiento);
    List<ListasMovimiento> manoAgudaFortalecimiento = List.from(ListManoAgudaFortalecimiento);
    List<ListasMovimiento> manoCronicoFortalecimiento = List.from(ListManoCronicoFortalecimiento);

    // Limpia las listas originales
    ListHombroAgudaFortalecimiento.clear();
    ListHombroCronicoFortalecimiento.clear();
    ListCodoAgudaFortalecimiento.clear();
    ListCodoCronicoFortalecimiento.clear();
    ListMunecaAgudaFortalecimiento.clear();
    ListMunecaCronicoFortalecimiento.clear();
    ListManoAgudaFortalecimiento.clear();
    ListManoCronicoFortalecimiento.clear();

    // Asigna las nuevas listas a las originales
    ListHombroAgudaFortalecimiento = hombroAgudaFortalecimiento;
    ListHombroCronicoFortalecimiento = hombroCronicoFortalecimiento;
    ListCodoAgudaFortalecimiento = codoAgudaFortalecimiento;
    ListCodoCronicoFortalecimiento = codoCronicoFortalecimiento;
    ListMunecaAgudaFortalecimiento = munecaAgudaFortalecimiento;
    ListMunecaCronicoFortalecimiento = munecaCronicoFortalecimiento;
    ListManoAgudaFortalecimiento = manoAgudaFortalecimiento;
    ListManoCronicoFortalecimiento = manoCronicoFortalecimiento;

    // Limpia las listas de flexibilidad
    // Copiar las listas originales en nuevas listas
    List<ListasMovimiento> hombroAgudaFlexibilidad = List.from(ListHombroAgudaFlexibilidad);
    List<ListasMovimiento> hombroCronicoFlexibilidad = List.from(ListHombroCronicoFlexibilidad);
    List<ListasMovimiento> codoAgudaFlexibilidad = List.from(ListCodoAgudaFlexibilidad);
    List<ListasMovimiento> codoCronicoFlexibilidad = List.from(ListCodoCronicoFlexibilidad);
    List<ListasMovimiento> munecaAgudaFlexibilidad = List.from(ListMunecaAgudaFlexibilidad);
    List<ListasMovimiento> munecaCronicoFlexibilidad = List.from(ListMunecaCronicoFlexibilidad);
    List<ListasMovimiento> manoAgudaFlexibilidad = List.from(ListManoAgudaFlexibilidad);
    List<ListasMovimiento> manoCronicoFlexibilidad = List.from(ListManoCronicoFlexibilidad);

    // Limpia las listas originales
    ListHombroAgudaFlexibilidad.clear();
    ListHombroCronicoFlexibilidad.clear();
    ListCodoAgudaFlexibilidad.clear();
    ListCodoCronicoFlexibilidad.clear();
    ListMunecaAgudaFlexibilidad.clear();
    ListMunecaCronicoFlexibilidad.clear();
    ListManoAgudaFlexibilidad.clear();
    ListManoCronicoFlexibilidad.clear();

    // Asigna las nuevas listas a las originales
    ListHombroAgudaFlexibilidad = hombroAgudaFlexibilidad;
    ListHombroCronicoFlexibilidad = hombroCronicoFlexibilidad;
    ListCodoAgudaFlexibilidad = codoAgudaFlexibilidad;
    ListCodoCronicoFlexibilidad = codoCronicoFlexibilidad;
    ListMunecaAgudaFlexibilidad = munecaAgudaFlexibilidad;
    ListMunecaCronicoFlexibilidad = munecaCronicoFlexibilidad;
    ListManoAgudaFlexibilidad = manoAgudaFlexibilidad;
    ListManoCronicoFlexibilidad = manoCronicoFlexibilidad;

    // Limpia las listas de dolor
    // Copiar las listas originales en nuevas listas
    List<ListasMovimiento> hombroAgudaDolor = List.from(ListHombroAgudaDolor);
    List<ListasMovimiento> hombroCronicoDolor = List.from(ListHombroCronicoDolor);
    List<ListasMovimiento> codoAgudaDolor = List.from(ListCodoAgudaDolor);
    List<ListasMovimiento> codoCronicoDolor = List.from(ListCodoCronicoDolor);
    List<ListasMovimiento> munecaAgudaDolor = List.from(ListMunecaAgudaDolor);
    List<ListasMovimiento> munecaCronicoDolor = List.from(ListMunecaCronicoDolor);
    List<ListasMovimiento> manoAgudaDolor = List.from(ListManoAgudaDolor);
    List<ListasMovimiento> manoCronicoDolor = List.from(ListManoCronicoDolor);

    // Limpia las listas originales
    ListHombroAgudaDolor.clear();
    ListHombroCronicoDolor.clear();
    ListCodoAgudaDolor.clear();
    ListCodoCronicoDolor.clear();
    ListMunecaAgudaDolor.clear();
    ListMunecaCronicoDolor.clear();
    ListManoAgudaDolor.clear();
    ListManoCronicoDolor.clear();

    // Asigna las nuevas listas a las originales
    ListHombroAgudaDolor = hombroAgudaDolor;
    ListHombroCronicoDolor = hombroCronicoDolor;
    ListCodoAgudaDolor = codoAgudaDolor;
    ListCodoCronicoDolor = codoCronicoDolor;
    ListMunecaAgudaDolor = munecaAgudaDolor;
    ListMunecaCronicoDolor = munecaCronicoDolor;
    ListManoAgudaDolor = manoAgudaDolor;
    ListManoCronicoDolor = manoCronicoDolor;

    // Limpia las listas de reentrenamiento
    // Copiar las listas originales en nuevas listas
    List<zonaMyM> avdAgudaHombro = List.from(botonesListAvdAgudaHombro);
    List<zonaMyM> avdCronicaHombro = List.from(botonesListAvdCronicaHombro);
    List<zonaMyM> avdAgudaCodo = List.from(botonesListAvdAgudaCodo);
    List<zonaMyM> avdCronicaCodo = List.from(botonesListAvdCronicaCodo);
    List<zonaMyM> avdAgudaMuneca = List.from(botonesListAvdAgudaMuneca);
    List<zonaMyM> avdCronicaMuneca = List.from(botonesListAvdCronicaMuneca);
    List<zonaMyM> avdAgudaMano = List.from(botonesListAvdAgudaMano);
    List<zonaMyM> avdCronicaMano = List.from(botonesListAvdCronicaMano);

    // Limpia las listas originales
    botonesListAvdAgudaHombro.clear();
    botonesListAvdCronicaHombro.clear();
    botonesListAvdAgudaCodo.clear();
    botonesListAvdCronicaCodo.clear();
    botonesListAvdAgudaMuneca.clear();
    botonesListAvdCronicaMuneca.clear();
    botonesListAvdAgudaMano.clear();
    botonesListAvdCronicaMano.clear();

    // Asigna las nuevas listas a las originales
    botonesListAvdAgudaHombro = avdAgudaHombro;
    botonesListAvdCronicaHombro = avdCronicaHombro;
    botonesListAvdAgudaCodo = avdAgudaCodo;
    botonesListAvdCronicaCodo = avdCronicaCodo;
    botonesListAvdAgudaMuneca = avdAgudaMuneca;
    botonesListAvdCronicaMuneca = avdCronicaMuneca;
    botonesListAvdAgudaMano = avdAgudaMano;
    botonesListAvdCronicaMano = avdCronicaMano;

    _tabController = TabController(length: 5, vsync: this);

    _tabController.addListener(() {
      int newIndex = _tabController.index;
      setState(() {
        currentTabIndex = newIndex;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        color: AppColor.colorWhite,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 50.h, bottom: 10.h),
              width: screenWidth,
              height: 100.h,
              child: Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back_ios, size: 23.h, color: AppColor.colorBlack),
                      ),
                      Expanded(child: Container()),
                      InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(16.w),
                                  child: ListView(
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Informate",
                                              style: TextStyle(
                                                  fontSize: 18.sp,
                                                  color: AppColor.colorTextOne,
                                                  fontWeight: FontWeight.bold)),
                                          SizedBox(height: 10.h),
                                          Text(
                                              textAlign: TextAlign.justify,
                                              widget.data.itemFaseHombro == 0
                                                  ? "En la fase aguda, se enfoca en aliviar el dolor y evitar más daño. Los ejercicios son suaves y se centran en mantener el movimiento sin empeorar el dolor, donde cada fase tiene un propósito específico de mejora. \n\n"
                                                      "Movilidad: hacer movimientos suaves es muy importante. Ayuda a mantener el hombro en movimiento sin causar más dolor ni daño.\n\n"
                                                      "Fortalecimiento: Durante esta fase, realizar ejercicios suaves para fortalecer los músculos sin forzar la articulación es fundamental. Esto ayuda a mantener el hombro estable y evita problemas futuros.\n\n"
                                                      "Flexibilidad: Hacer estiramientos suaves es crucial, ya que ayuda a mantener los músculos flexibles y evita que el hombro se vuelva rígido.\n\n"
                                                      "Dolor: Controlar y aliviar el dolor es muy importante. Usamos cosas como hielo y medicamentos para reducir el dolor y hacerte sentir mejor.\n\n"
                                                      "Reentrenamiento: Se busca restaurar la independencia y la funcionalidad, permitiendo a la persona recuperar su calidad de vida y la habilidad para realizar tareas esenciales de manera efectiva."
                                                  : "En esta fase, los ejercicios se vuelven más activos y buscan restaurar la funcionalidad normal y prevenir la rigidez en el hombro, donde cada fase tiene un propósito específico de mejora. \n\n"
                                                      "Movilidad: En esta fase, seguir moviendo el hombro es clave. Los ejercicios son un poco más activos y ayudan a que el hombro funcione normalmente sin sentir rigidez.\n\n"
                                                      "Fortalecimiento: En esta fase, hacer ejercicios con resistencia, como pesas o bandas elásticas, es importante. Ayuda a fortalecer los músculos alrededor del hombro y evita lesiones futuras.\n\n"
                                                      "Flexibilidad: La flexibilidad sigue siendo importante en la fase crónica. Los estiramientos mantienen los músculos sueltos y evitan que el hombro se vuelva rígido.\n\n"
                                                      "Dolor: En la fase crónica, aprender a controlar el dolor es clave para tener una mejor calidad de vida. Usamos terapias y masajes para reducir la sensación de dolor y ayudarte a sentirte mejor.\n\n"
                                                      "Reentrenamiento: Se busca restaurar la independencia y la funcionalidad, permitiendo a la persona recuperar su calidad de vida y la habilidad para realizar tareas esenciales de manera efectiva.",
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                              )),
                                          SizedBox(height: 20.h),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('OK',
                                                  style: TextStyle(
                                                      color: AppColor.colorTextOne, fontWeight: FontWeight.bold)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Wrap(
                          children: List.generate(1, (index) {
                            return Icon(
                              Icons.info_outline,
                              size: 23.h,
                              color: AppColor.colorBlack,
                            );
                          }),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            CustomImageCarousel(data: widget.data, products: products),
            SizedBox(
              height: 15.h,
            ),
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: CustomTabBarRow(
                        tabController: _tabController,
                        screenHeight: screenHeight,
                        screenWidth: screenWidth,
                      )),
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        buildListView(_getListForCondition(widget.data.itemPatologia, widget.data.itemFaseHombro),
                            currentTabIndex, data),
                        buildListView(_getListFortalecimiento(widget.data.itemPatologia, widget.data.itemFaseHombro),
                            currentTabIndex, data),
                        buildListView(_getListFlexibilidad(widget.data.itemPatologia, widget.data.itemFaseHombro),
                            currentTabIndex, data),
                        buildListView(_getListDolor(widget.data.itemPatologia, widget.data.itemFaseHombro),
                            currentTabIndex, data),
                        buildListView2(_getLisReentrenamiento(widget.data.itemPatologia, widget.data.itemFaseHombro)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomImageCarousel extends StatefulWidget {
  final zonaMyM data;
  final List<List<String>> products;

  const CustomImageCarousel({
    Key? key,
    required this.data,
    required this.products,
  }) : super(key: key);

  @override
  _CustomImageCarouselState createState() => _CustomImageCarouselState();
}

class _CustomImageCarouselState extends State<CustomImageCarousel> {
  int currentIndex = 0;
  late Timer _autoChangeTimer;

  @override
  void initState() {
    super.initState();
    _startAutoChange();
  }

  @override
  void dispose() {
    _autoChangeTimer.cancel();
    super.dispose();
  }

  void _next() {
    setState(() {
      currentIndex = (currentIndex + 1) % products.length;
    });
  }

  void _preve() {
    setState(() {
      currentIndex = (currentIndex - 1) % products.length;
    });
  }

  void _startAutoChange() {
    const duration = Duration(seconds: 5);
    _autoChangeTimer = Timer.periodic(duration, (timer) {
      _next();
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onHorizontalDragEnd: (DragEndDetails details) {
        if (details.velocity.pixelsPerSecond.dx > 0) {
          _preve();
        } else if (details.velocity.pixelsPerSecond.dx < 0) {
          _next();
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: FadeAnimation(
          .8,
          Container(
            width: double.infinity,
            height: 220.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                image: AssetImage(widget.products[currentIndex][0]),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: AppColor.colorBlack.withOpacity(0.7),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 8,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            widget.data.title,
                            style: TextStyle(
                              fontSize: 22.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColor.colorTextOne,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        SizedBox(
                          width: screenWidth,
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 15.w),
                              child: AutoSizeText(
                                "Restaura tu bienestar y optimiza tu vida diaria superando obstáculos para alcanzar un óptimo desempeño.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: AppColor.colorWhite.withOpacity(0.6),
                                ),
                                maxLines: 3,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: FadeAnimation(
                      1,
                      Container(
                        width: 80.w,
                        margin: EdgeInsets.only(bottom: 20.h),
                        child: Row(
                          children: _buildIndicator(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget _indicator(bool isActive) {
  return Expanded(
    child: Container(
      height: 4.h,
      margin: EdgeInsets.only(right: 5.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50), color: isActive ? AppColor.colorTextOne : AppColor.colorWhite),
    ),
  );
}

List<Widget> _buildIndicator() {
  List<Widget> indicators = [];
  for (int i = 0; i < products.length; i++) {
    if (currentIndex == i) {
      indicators.add(_indicator(true));
    } else {
      indicators.add(_indicator(false));
    }
  }

  return indicators;
}

class CustomTabBarRow extends StatefulWidget {
  final TabController tabController;
  final double screenHeight;
  final double screenWidth;

  const CustomTabBarRow({
    Key? key,
    required this.tabController,
    required this.screenHeight,
    required this.screenWidth,
  }) : super(key: key);

  @override
  _CustomTabBarRowState createState() => _CustomTabBarRowState();
}

class _CustomTabBarRowState extends State<CustomTabBarRow> {
  @override
  void dispose() {
    widget.tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 8,
          child: Container(
            padding: EdgeInsets.only(left: 15.w),
            width: widget.screenWidth,
            height: 40.h,
            child: Align(
              alignment: Alignment.centerLeft,
              child: TabBar(
                indicator: ShapeDecoration(
                  shape: const StadiumBorder(),
                  color: AppColor.colorTextOne,
                ),
                controller: widget.tabController,
                isScrollable: true,
                labelPadding: EdgeInsets.only(left: 13.w, right: 15.w),
                labelColor: AppColor.colorBlack,
                unselectedLabelColor: AppColor.colorfontNoActive,
                labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                tabs: [
                  Tab(
                    child: Text(
                      "Movilidad",
                      style: TextStyle(
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Fortalecimiento",
                      style: TextStyle(
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Flexibilidad",
                      style: TextStyle(
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Dolor",
                      style: TextStyle(
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Reentrenamiento",
                      style: TextStyle(
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Widget buildListView(List<ListasMovimiento> movimientoList, int Cindex, zonaMyM data) {
  print("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ ${Cindex}");
  if (movimientoList.isEmpty) {
    return Center(
      child: Text(
        'No hay videos disponibles',
        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: AppColor.colorBlack.withOpacity(0.5)),
      ),
    );
  } else {
    return ScrollConfiguration(
// Quita el color del listview
      behavior: const ScrollBehavior().copyWith(overscroll: false),
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
        itemCount: movimientoList.length,
        itemBuilder: (context, index) {
          ListasMovimiento movimiento = movimientoList[index];
          String videoId = movimiento.thumbnail;

          return GestureDetector(
            child: InkWell(
              onTap: () {
                CachedNetworkImageProvider('https://img.youtube.com/vi/$videoId/0.jpg').evict();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => reproductorVideos(
                      movimiento: movimiento,
                      Cindex: Cindex,
                      data: data,
                    ),
                  ),
                );
              },
              child: SizedBox(
                height: 110.h,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 145.w,
                          height: 90.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: CachedNetworkImage(
                              placeholder: (context, url) => Container(
                                padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 20.h),
                                width: 40.w,
                                height: 40.h,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.0,
                                  color: AppColor.colorTextOne,
                                ),
                              ),
                              imageUrl: 'https://img.youtube.com/vi/$videoId/0.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15.w,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              movimiento.title,
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF212121),
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: Text(
                                movimiento.time,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.blueGrey,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Expanded(child: Container()),
                        SizedBox(
                          width: 20.w,
                          height: 90.h,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              movimiento.autoDirigido
                                  ? Icon(
                                      Icons.sensors,
                                      size: 13.h,
                                      color: AppColor.colorBlack.withOpacity(0.5),
                                    )
                                  : const SizedBox(),
                              SizedBox(height: 3.h),
                              Icon(
                                Icons.volume_up,
                                size: 13.h,
                                color: AppColor.colorBlack.withOpacity(0.5),
                              ),
                              SizedBox(height: 3.h),
                              Icon(
                                Icons.visibility,
                                size: 13.h,
                                color: AppColor.colorBlack.withOpacity(0.5),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 10.h,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget buildListView2(List<zonaMyM> movimientoList) {
  if (movimientoList.isEmpty) {
    return Center(
      child: Text(
        'No hay videos disponibles',
        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: AppColor.colorBlack.withOpacity(0.5)),
      ),
    );
  } else {
    return ScrollConfiguration(
      behavior: const ScrollBehavior().copyWith(overscroll: false),
      child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
          itemCount: movimientoList.length,
          itemBuilder: (context, index) {
            zonaMyM movimiento = movimientoList[index];
            return GestureDetector(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Material(
                      elevation: 0,
                      borderRadius: BorderRadius.circular(30),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              height: 80.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  image: AssetImage(
                                    movimiento.imageUrl,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: Container(
                              padding: EdgeInsets.only(left: 14.w, right: 10.w),
                              height: 100.h,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 8,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        AutoSizeText(
                                          textAlign: TextAlign.left,
                                          movimiento.title,
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.bold,
                                            color: AppColor.colorBlack,
                                          ),
                                        ),
                                        SizedBox(height: 5.h),
                                        AutoSizeText(
                                          textAlign: TextAlign.left,
                                          movimiento.basicInformation,
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            color: AppColor.colorfontParagraph,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 5.h),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => listaVideosAVD(data: movimiento)),
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 12.w),
                                width: 40.sp,
                                height: 40.sp,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.black,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            alignment: Alignment.center,
                                            child: FittedBox(
                                              fit: BoxFit.cover,
                                              child: Icon(Icons.arrow_forward_ios, color: AppColor.colorWhite),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.h),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
