import 'package:appre/menu_app/arm_rehabilitation/pathologies/types_phases/dimensions.dart';
import 'package:appre/menu_app/arm_rehabilitation/pathologies/types_phases/recovery_type/RecoveryAvd.dart';
import 'package:appre/colors.dart';
import 'package:appre/menu_app/json/recuperamientoJson.dart';
import 'package:appre/menu_app/json/zonaMyMJson.dart';
import 'package:appre/menu_app/textScalefactor/RecoveryTypeScalefactor.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

var currenPageValue = 0.0;

class TypesPhases extends StatefulWidget {
  final recuperamientoHombro data;

  const TypesPhases({Key? key, required this.data}) : super(key: key);

  @override
  State<TypesPhases> createState() => _TypesPhasesState();
}

class _TypesPhasesState extends State<TypesPhases> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        color: AppColor.colorWhite,
        child: Column(
          children: [
            Stack(
              children: [
                ClipPathContainer(screenHeight: screenHeight, screenWidth: screenWidth),
                PositionedContainer(screenHeight: screenHeight, screenWidth: screenWidth, data: widget.data),
              ],
            ),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              color: AppColor.colorfontlight,
                              width: screenWidth,
                              child: Column(
                                children: [
                                  ContainerRow(screenHeight: screenHeight, screenWidth: screenWidth),
                                  SizedBox(height: 5.h),
                                  SizedBoxPageView(
                                      screenHeight: screenHeight, screenWidth: screenWidth, data: widget.data),
                                ],
                              ),
                            ),
                          ],
                        ),
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

class ClipPathContainer extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;

  const ClipPathContainer({Key? key, required this.screenHeight, required this.screenWidth}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: OvalBottomBorderClipper(),
      child: SizedBox(
        width: screenWidth,
        height: 440.h,
        child: ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [AppColor.colorBlack, AppColor.colorBlack.withOpacity(0.15)],
            begin: Alignment.bottomCenter,
            end: Alignment.center,
          ).createShader(bounds),
          blendMode: BlendMode.darken,
          child: Container(
            padding: EdgeInsets.only(top: 50.h, left: 20.w),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage("assets/pageTwo.jpg"),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  AppColor.colorBlack.withOpacity(0.6),
                  BlendMode.darken,
                ),
              ),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        width: 40.w,
                        height: 40.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColor.colorWhite.withOpacity(0.2),
                        ),
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: 22.h,
                          color: AppColor.colorWhite,
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
    );
  }
}

class PositionedContainer extends StatelessWidget {
  final recuperamientoHombro data;
  final double screenHeight;
  final double screenWidth;

  const PositionedContainer({super.key, required this.data, required this.screenHeight, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 250.h,
      left: 20.w,
      child: SizedBox(
        width: 375.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                'Fases de Rehabilitación',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 19.sp,
                  color: AppColor.colorWhite,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              width: screenWidth,
              child: Center(
                child: AutoSizeText.rich(
                  TextSpan(
                    text: "de ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp,
                      color: AppColor.colorWhite,
                    ),
                    children: [
                      TextSpan(
                        text: data.tituloPatologia,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColor.colorTextOne,
                        ),
                      ),
                    ],
                  ),
                  maxLines: 1,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            SizedBox(
              width: screenWidth,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                  child: AutoSizeText(
                    data.informacionFases,
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
    );
  }
}

class ContainerRow extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;

  const ContainerRow({super.key, required this.screenHeight, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.colorWhite,
      width: screenWidth,
      child: Column(
        children: [
          Container(
            color: AppColor.colorWhite,
            width: screenWidth,
            height: 50.h,
            child: Row(
              children: [
                Expanded(
                  flex: 9,
                  child: Padding(
                    padding: EdgeInsets.only(left: 15.w, right: 15.w),
                    child: AutoSizeText(
                      "Tipos de fase",
                      style: TextStyle(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColor.colorBlack,
                      ),
                      //minFontSize: 14,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10.w),
                        child: AutoSizeText(
                          "Mas",
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: AppColor.colorBlack,
                          ),
                          //minFontSize: 14,
                        ),
                      ),
                      Icon(Icons.arrow_forward, color: AppColor.colorBlack, size: 20.h),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SizedBoxPageView extends StatefulWidget {
  final double screenHeight;
  final double screenWidth;
  final recuperamientoHombro data;

  const SizedBoxPageView({super.key, required this.data, required this.screenHeight, required this.screenWidth});

  @override
  _SizedBoxPageViewState createState() => _SizedBoxPageViewState();
}

class _SizedBoxPageViewState extends State<SizedBoxPageView> {
  final List<List<zonaMyM>> faseList = [
    faseListZona,
    faseListZonaCodo,
    faseListZonaMuneca,
    faseListZonaMano,
  ];

  PageController pageController = PageController(viewportFraction: 0.85);

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        currenPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      // Quita el color del listview
      behavior: const ScrollBehavior().copyWith(overscroll: false),
      child: SizedBox(
        height: Dimensions.pageView,
        child: PageView.builder(
            controller: pageController,
            itemCount: faseList[widget.data.item].length,
            itemBuilder: (context, index) {
              zonaMyM dolor = faseList[widget.data.item][index];
              List<Widget> routes = [
                RecoveryTypeScalefactor(data: dolor),
                RecoveryTypeScalefactor(data: dolor),
                RecoveryAvd(data: dolor),
              ];
              return Stack(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => routes[index],
                          ));
                    },
                    child: Container(
                      height: Dimensions.pageViewContainer,
                      margin: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius30),
                        color: index.isEven ? AppColor.colorWhite : AppColor.colorWhite,
                        image: DecorationImage(
                          image: AssetImage(dolor.imageUrl),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.1),
                            BlendMode.darken,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: Dimensions.pageViewContainer * 0.6,
                      margin: EdgeInsets.only(
                          left: Dimensions.width30, right: Dimensions.width30, bottom: Dimensions.height30),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radius20),
                          color: AppColor.colorBlack.withOpacity(0.5),
                          boxShadow: [
                            BoxShadow(
                                color: AppColor.colorBlack.withOpacity(0.15),
                                blurRadius: 5.0,
                                offset: const Offset(0, 0)),
                            BoxShadow(color: AppColor.colorBlack.withOpacity(0.15), offset: const Offset(0, 0)),
                            BoxShadow(color: AppColor.colorBlack.withOpacity(0.15), offset: const Offset(0, 0)),
                          ]),
                      child: Container(
                        padding: EdgeInsets.only(
                            top: Dimensions.height15, left: Dimensions.width10, right: Dimensions.width10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: 15.w),
                                    child: AutoSizeText(
                                      dolor.title,
                                      style: TextStyle(
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.colorTextOne,
                                      ),
                                    ),
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
                                                  Text(dolor.title,
                                                      style: TextStyle(
                                                          fontSize: 18.sp,
                                                          color: AppColor.colorTextOne,
                                                          fontWeight: FontWeight.bold)),
                                                  SizedBox(height: Dimensions.height10),
                                                  Text(dolor.basicInformation, style: TextStyle(fontSize: 14.sp)),
                                                  SizedBox(height: Dimensions.height20),
                                                  Align(
                                                    alignment: Alignment.centerRight,
                                                    child: TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context).pop();
                                                      },
                                                      child: Text('OK',
                                                          style: TextStyle(
                                                              color: AppColor.colorTextOne,
                                                              fontWeight: FontWeight.bold)),
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
                                          color: AppColor.colorTextOne,
                                          size: 22.h,
                                        );
                                      }),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: Dimensions.height10),
                            Expanded(
                              flex: 4,
                              child: Column(
                                children: [
                                  AutoSizeText(
                                    textAlign: TextAlign.left,
                                    dolor.information,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: AppColor.colorWhite.withOpacity(0.9),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Wrap(
                                    children: List.generate(1, (index) {
                                      return Icon(Icons.favorite, color: AppColor.colorTextOne, size: 14.h);
                                    }),
                                  ),
                                  SizedBox(width: 5.w),
                                  AutoSizeText(
                                    "5 Tratamientos",
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      color: AppColor.colorWhite.withOpacity(0.6),
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  Wrap(
                                    children: List.generate(1, (index) {
                                      return Icon(Icons.fitness_center_sharp, color: AppColor.colorTextOne, size: 14.h);
                                    }),
                                  ),
                                  SizedBox(width: 5.w),
                                  AutoSizeText(
                                    "24 Ejercicios",
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      color: AppColor.colorWhite.withOpacity(0.6),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
