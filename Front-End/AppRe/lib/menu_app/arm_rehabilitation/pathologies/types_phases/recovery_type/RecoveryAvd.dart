import 'dart:async';
import 'package:appre/menu_app/arm_rehabilitation/pathologies/types_phases/recovery_type/FadeAnimation.dart';
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

class RecoveryAvd extends StatefulWidget {
  const RecoveryAvd({Key? key, required this.data}) : super(key: key);
  final zonaMyM data;

  @override
  State<RecoveryAvd> createState() => _RecoveryAvdState(data);
}

class _RecoveryAvdState extends State<RecoveryAvd> with TickerProviderStateMixin {
  final zonaMyM data;

  _RecoveryAvdState(this.data);

  List<ListasMovimiento> _getListBanarse(int itemPatologia, int itemFaseHombro) {
    List<ListasMovimiento> result = [];
    if (itemPatologia == 0 && itemFaseHombro == 2) {
      result = ListHombroMantenimientoBaniarse;
    } else if (itemPatologia == 1 && itemFaseHombro == 2) {
      result = ListCodoMantenimientoBaniarse;
    } else if (itemPatologia == 2 && itemFaseHombro == 2) {
      result = ListMunecaMantenimientoBaniarse;
    } else if (itemPatologia == 3 && itemFaseHombro == 2) {
      result = ListManoMantenimientoBaniarse;
    }

    if (result.isEmpty) {
      result = [];
    }
    return result;
  }

  List<ListasMovimiento> _getListVestirse(int itemPatologia, int itemFaseHombro) {
    List<ListasMovimiento> result = [];
    if (itemPatologia == 0 && itemFaseHombro == 2) {
      result = ListHombroMantenimientoVestirse;
    } else if (itemPatologia == 1 && itemFaseHombro == 2) {
      result = ListCodoMantenimientoVestirse;
    } else if (itemPatologia == 2 && itemFaseHombro == 2) {
      result = ListMunecaMantenimientoVestirse;
    } else if (itemPatologia == 3 && itemFaseHombro == 2) {
      result = ListManoMantenimientoVestirse;
    }

    if (result.isEmpty) {
      result = [];
    }
    return result;
  }

  List<ListasMovimiento> _getListComer(int itemPatologia, int itemFaseHombro) {
    List<ListasMovimiento> result = [];
    if (itemPatologia == 0 && itemFaseHombro == 2) {
      result = ListHombroMantenimientoComer;
    } else if (itemPatologia == 1 && itemFaseHombro == 2) {
      result = ListCodoMantenimientoComer;
    } else if (itemPatologia == 2 && itemFaseHombro == 2) {
      result = ListMunecaMantenimientoComer;
    } else if (itemPatologia == 3 && itemFaseHombro == 2) {
      result = ListManoMantenimientoComer;
    }

    if (result.isEmpty) {
      result = [];
    }
    return result;
  }

  List<ListasMovimiento> _getListAlimentacion(int itemPatologia, int itemFaseHombro) {
    List<ListasMovimiento> result = [];
    if (itemPatologia == 0 && itemFaseHombro == 2) {
      result = ListHombroMantenimientoAlimentacion;
    } else if (itemPatologia == 1 && itemFaseHombro == 2) {
      result = ListCodoMantenimientoAlimentacion;
    } else if (itemPatologia == 2 && itemFaseHombro == 2) {
      result = ListMunecaMantenimientoAlimentacion;
    } else if (itemPatologia == 3 && itemFaseHombro == 2) {
      result = ListManoMantenimientoAlimentacion;
    }

    if (result.isEmpty) {
      result = [];
    }
    return result;
  }

  List<ListasMovimiento> _getListHigienePersonal(int itemPatologia, int itemFaseHombro) {
    List<ListasMovimiento> result = [];
    if (itemPatologia == 0 && itemFaseHombro == 2) {
      result = ListHombroMantenimientoHigienePersonal;
    } else if (itemPatologia == 1 && itemFaseHombro == 2) {
      result = ListCodoMantenimientoHigienePersonal;
    } else if (itemPatologia == 2 && itemFaseHombro == 2) {
      result = ListMunecaMantenimientoHigienePersonal;
    } else if (itemPatologia == 3 && itemFaseHombro == 2) {
      result = ListManoMantenimientoHigienePersonal;
    }

    if (result.isEmpty) {
      result = [];
    }
    return result;
  }

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    List<ListasMovimiento> hombroMantenimientoBaniarse = List.from(ListHombroMantenimientoBaniarse);
    List<ListasMovimiento> codoMantenimientoBaniarse = List.from(ListCodoMantenimientoBaniarse);
    List<ListasMovimiento> munecaMantenimientoBaniarse = List.from(ListMunecaMantenimientoBaniarse);
    List<ListasMovimiento> manoMantenimientoBaniarse = List.from(ListManoMantenimientoBaniarse);

// Limpia las listas originales
    ListHombroMantenimientoBaniarse.clear();
    ListCodoMantenimientoBaniarse.clear();
    ListMunecaMantenimientoBaniarse.clear();
    ListManoMantenimientoBaniarse.clear();

// Usa las nuevas listas
    ListHombroMantenimientoBaniarse = hombroMantenimientoBaniarse;
    ListCodoMantenimientoBaniarse = codoMantenimientoBaniarse;
    ListMunecaMantenimientoBaniarse = munecaMantenimientoBaniarse;
    ListManoMantenimientoBaniarse = manoMantenimientoBaniarse;

    List<ListasMovimiento> hombroMantenimientoVestirse = List.from(ListHombroMantenimientoVestirse);
    List<ListasMovimiento> codoMantenimientoVestirse = List.from(ListCodoMantenimientoVestirse);
    List<ListasMovimiento> munecaMantenimientoVestirse = List.from(ListMunecaMantenimientoVestirse);
    List<ListasMovimiento> manoMantenimientoVestirse = List.from(ListManoMantenimientoVestirse);

// Limpia las listas originales
    ListHombroMantenimientoVestirse.clear();
    ListCodoMantenimientoVestirse.clear();
    ListMunecaMantenimientoVestirse.clear();
    ListManoMantenimientoVestirse.clear();

// Usa las nuevas listas
    ListHombroMantenimientoVestirse = hombroMantenimientoVestirse;
    ListCodoMantenimientoVestirse = codoMantenimientoVestirse;
    ListMunecaMantenimientoVestirse = munecaMantenimientoVestirse;
    ListManoMantenimientoVestirse = manoMantenimientoVestirse;

    List<ListasMovimiento> hombroMantenimientoComer = List.from(ListHombroMantenimientoComer);
    List<ListasMovimiento> codoMantenimientoComer = List.from(ListCodoMantenimientoComer);
    List<ListasMovimiento> munecaMantenimientoComer = List.from(ListMunecaMantenimientoComer);
    List<ListasMovimiento> manoMantenimientoComer = List.from(ListManoMantenimientoComer);

// Limpia las listas originales
    ListHombroMantenimientoComer.clear();
    ListCodoMantenimientoComer.clear();
    ListMunecaMantenimientoComer.clear();
    ListManoMantenimientoComer.clear();

// Usa las nuevas listas
    ListHombroMantenimientoComer = hombroMantenimientoComer;
    ListCodoMantenimientoComer = codoMantenimientoComer;
    ListMunecaMantenimientoComer = munecaMantenimientoComer;
    ListManoMantenimientoComer = manoMantenimientoComer;

    List<ListasMovimiento> hombroMantenimientoAlimentacion = List.from(ListHombroMantenimientoAlimentacion);
    List<ListasMovimiento> codoMantenimientoAlimentacion = List.from(ListCodoMantenimientoAlimentacion);
    List<ListasMovimiento> munecaMantenimientoAlimentacion = List.from(ListMunecaMantenimientoAlimentacion);
    List<ListasMovimiento> manoMantenimientoAlimentacion = List.from(ListManoMantenimientoAlimentacion);

// Limpia las listas originales
    ListHombroMantenimientoAlimentacion.clear();
    ListCodoMantenimientoAlimentacion.clear();
    ListMunecaMantenimientoAlimentacion.clear();
    ListManoMantenimientoAlimentacion.clear();

// Usa las nuevas listas
    ListHombroMantenimientoAlimentacion = hombroMantenimientoAlimentacion;
    ListCodoMantenimientoAlimentacion = codoMantenimientoAlimentacion;
    ListMunecaMantenimientoAlimentacion = munecaMantenimientoAlimentacion;
    ListManoMantenimientoAlimentacion = manoMantenimientoAlimentacion;

    List<ListasMovimiento> hombroMantenimientoHigienePersonal = List.from(ListHombroMantenimientoHigienePersonal);
    List<ListasMovimiento> codoMantenimientoHigienePersonal = List.from(ListCodoMantenimientoHigienePersonal);
    List<ListasMovimiento> munecaMantenimientoHigienePersonal = List.from(ListMunecaMantenimientoHigienePersonal);
    List<ListasMovimiento> manoMantenimientoHigienePersonal = List.from(ListManoMantenimientoHigienePersonal);

// Limpia las listas originales
    ListHombroMantenimientoHigienePersonal.clear();
    ListCodoMantenimientoHigienePersonal.clear();
    ListMunecaMantenimientoHigienePersonal.clear();
    ListManoMantenimientoHigienePersonal.clear();

// Usa las nuevas listas
    ListHombroMantenimientoHigienePersonal = hombroMantenimientoHigienePersonal;
    ListCodoMantenimientoHigienePersonal = codoMantenimientoHigienePersonal;
    ListMunecaMantenimientoHigienePersonal = munecaMantenimientoHigienePersonal;
    ListManoMantenimientoHigienePersonal = manoMantenimientoHigienePersonal;

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
                        child: Icon(Icons.arrow_back_ios, size: 23.sp, color: AppColor.colorBlack),
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
                                  child: Column(
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
                                          "Practicar y mantener las actividades cotidianas como bañarse, vestirse, comer, mantener una alimentación saludable y cuidar la higiene personal es esencial para garantizar la independencia y la calidad de vida. \n\nEstas prácticas promueven el bienestar general, mejoran la autoestima y facilitan la participación en la vida social y profesional, ayudándote en el proceso de mejora de tu miembro superior y en tu búsqueda de una vida más plena y satisfactoria.",
                                          style: TextStyle(fontSize: 14.sp)),
                                      SizedBox(height: 20.h),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('OK',
                                              style:
                                                  TextStyle(color: AppColor.colorTextOne, fontWeight: FontWeight.bold)),
                                        ),
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
                              size: 23.sp,
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
                        buildListView(_getListBanarse(widget.data.itemPatologia, widget.data.itemFaseHombro),
                            currentTabIndex, data),
                        buildListView(_getListVestirse(widget.data.itemPatologia, widget.data.itemFaseHombro),
                            currentTabIndex, data),
                        buildListView(_getListComer(widget.data.itemPatologia, widget.data.itemFaseHombro),
                            currentTabIndex, data),
                        buildListView(_getListAlimentacion(widget.data.itemPatologia, widget.data.itemFaseHombro),
                            currentTabIndex, data),
                        buildListView(_getListHigienePersonal(widget.data.itemPatologia, widget.data.itemFaseHombro),
                            currentTabIndex, data),
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

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onBackButtonPressed;

  const CustomAppBar({required this.onBackButtonPressed, Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios, size: 20.sp, color: AppColor.colorBlack),
        ),
        Expanded(child: Container()),
      ],
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
                        margin: const EdgeInsets.only(bottom: 20),
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
      margin: const EdgeInsets.only(right: 5),
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
                      "Bañarse",
                      style: TextStyle(
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Vestirse",
                      style: TextStyle(
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Comer",
                      style: TextStyle(
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Alimentación",
                      style: TextStyle(
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Higiene y Arreglo",
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
          CachedNetworkImageProvider('https://img.youtube.com/vi/$videoId/0.jpg').evict();
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
                        Expanded(
                          child: Column(
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
                                height: 10.sp,
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
                        ),
                      ],
                    ),
                    SizedBox(
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
