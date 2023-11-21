import 'package:appre/menu_app/arm_rehabilitation/pathologies/types_phases/TypesPhases.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'package:appre/colors.dart';
import 'package:appre/menu_app/json/recuperamientoJson.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Pathologies extends StatefulWidget {
  const Pathologies({Key? key}) : super(key: key);

  @override
  State<Pathologies> createState() => _Pathologies();
}

class _Pathologies extends State<Pathologies> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: Container(
          color: AppColor.colorBlack,
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                floating: true,
                pinned: true,
                expandedHeight: 375.h,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    color: AppColor.colorBlack,
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            SizedBoxContainer(
                              screenWidth: screenWidth,
                              screenHeight: screenHeight,
                            ),
                            PositionedContainer(
                              screenWidth: screenWidth,
                              screenHeight: screenHeight,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  collapseMode: CollapseMode.pin,
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColor.colorWhite,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(40),
                        topLeft: Radius.circular(40),
                      )),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 25.h,
                      ),
                      Column(
                        children: [
                          Container(
                            width: 50.w,
                            height: 8.h,
                            decoration: BoxDecoration(
                              color: AppColor.colorBlack,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          SelectActivityRow(
                            screenWidth: screenWidth,
                            screenHeight: screenHeight,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              ExpandedListView(
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SizedBoxContainer extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;

  const SizedBoxContainer({super.key, required this.screenHeight, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenWidth,
      height: 400.h,
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
              image: const AssetImage("assets/deporte2.jpg"),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.6),
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
                        color: Colors.white.withOpacity(0.2),
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
    );
  }
}

class PositionedContainer extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;

  const PositionedContainer({super.key, required this.screenHeight, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 170.h,
      left: 20.w,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15.h),
        decoration: BoxDecoration(
            color: AppColor.colorWhite.withOpacity(0.1), borderRadius: const BorderRadius.all(Radius.circular(20))),
        width: 370.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10.h,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Rehabilitación de',
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColor.colorWhite,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: 5.h),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Miembro Superior',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColor.colorTextOne,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: 23.h),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Te ayudara a tu',
                style: TextStyle(
                  fontSize: 15.sp,
                  color: AppColor.colorWhite.withOpacity(0.6),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: 10.h),
            Center(
              child: Row(
                children: [
                  Expanded(
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
                          "Salud",
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColor.colorWhite.withOpacity(0.6),
                          ),
                          minFontSize: 12,
                        ),
                        SizedBox(width: 10.w),
                        Wrap(
                          children: List.generate(1, (index) {
                            return Icon(Icons.fitness_center_sharp, color: AppColor.colorTextOne, size: 14.h);
                          }),
                        ),
                        SizedBox(width: 5.w),
                        AutoSizeText(
                          "Fortalecimiento",
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColor.colorWhite.withOpacity(0.6),
                          ),
                          minFontSize: 12,
                        ),
                        SizedBox(width: 10.w),
                        Wrap(
                          children: List.generate(1, (index) {
                            return Icon(Icons.emoji_people, color: AppColor.colorTextOne, size: 14.h);
                          }),
                        ),
                        SizedBox(width: 5.w),
                        AutoSizeText(
                          "Flexibilidad",
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColor.colorWhite.withOpacity(0.6),
                          ),
                          minFontSize: 12,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SelectActivityRow extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;

  const SelectActivityRow({super.key, required this.screenHeight, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        children: [
          SizedBox(
            width: 30.w,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 10.w),
                child: AutoSizeText(
                  textAlign: TextAlign.left,
                  "Seleccione una actividad",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColor.colorBlack,
                  ),
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ExpandedListView extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;

  const ExpandedListView({super.key, required this.screenHeight, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: Container(
          color: AppColor.colorWhite,
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
          child: ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemCount: recuperamientoListHombro.length,
            itemBuilder: (context, index) {
              recuperamientoHombro dolor = recuperamientoListHombro[index];

              return GestureDetector(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Material(
                        borderRadius: BorderRadius.circular(30),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Container(
                          color: AppColor.colorWhite,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  height: 90.h,
                                  width: screenWidth,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(screenHeight / 12),
                                    child: Image.asset(
                                      dolor.imageUrl,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Container(
                                  padding: EdgeInsets.only(left: 8.h, right: 8.h),
                                  height: 102.h,
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
                                              dolor.titulo,
                                              style: TextStyle(
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.bold,
                                                color: AppColor.colorBlack,
                                              ),
                                            ),
                                            SizedBox(height: 5.h),
                                            AutoSizeText(
                                              textAlign: TextAlign.left,
                                              dolor.informacionBasicaDos,
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                color: AppColor.colorfontParagraph,
                                              ),
                                              maxLines: 4,
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
                                      MaterialPageRoute(
                                          builder: (context) => TypesPhases(
                                                data: dolor,
                                              )),
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 12.h),
                                    height: 50.h,
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
                      ),
                      SizedBox(height: 11.h),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
