import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'package:appre/colors.dart';
import 'package:appre/menu_app/textScalefactor/PathologiesScalefactor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RehabilitationZone extends StatefulWidget {
  const RehabilitationZone({Key? key}) : super(key: key);

  @override
  State<RehabilitationZone> createState() => _RehabilitationZoneState();
}

class _RehabilitationZoneState extends State<RehabilitationZone> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return _RehabilitationZoneContent();
  }
}

/// Represents the content of the rehabilitation zone in the application.
///
/// - ShaderMask: Applies a mask effect to the background image.
/// - Container: Contains the background image and other elements.
/// - Column: Vertically organizes the widgets in the rehabilitation area.
/// - SizedBox: White space at the top.
/// - ButtonSection: Button sections related to rehabilitation.
/// - SizedBox: White space between buttons and text.
/// - TextSection: Text related to rehabilitation.
/// - ProtocolDescription: Description of the rehabilitation protocol.
///
class _RehabilitationZoneContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        colors: [AppColor.colorBlack, AppColor.colorBlack.withOpacity(0.1)],
        begin: Alignment.bottomCenter,
        end: Alignment.center,
      ).createShader(bounds),
      blendMode: BlendMode.darken,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage("assets/deporte1.jpg"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.darken),
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 400.h),
            ButtonSection(screenHeight: screenHeight, screenWidth: screenWidth),
            SizedBox(height: 10.h),
            TextSection(screenWidth: screenWidth),
            ProtocolDescription(screenWidth: screenWidth),
          ],
        ),
      ),
    );
  }
}

/// ButtonSection class
///
/// Represents a section of buttons in the user interface.
///
/// Provides a stadium-shaped button that initiates a navigation to another screen by
/// be pressed.
///
/// Container: Contains the stadium-shaped button with an attractive visual appearance.
/// MaterialButton: An interactive button that displays an icon and handles navigation.
///
class ButtonSection extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;

  const ButtonSection({super.key, required this.screenHeight, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: Container(
        width: 100.w,
        height: 50.h,
        decoration: ShapeDecoration(
          shape: const StadiumBorder(),
          color: AppColor.colorWhite.withOpacity(0.9),
        ),
        child: MaterialButton(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: const StadiumBorder(),
          child: Icon(
            Icons.east_outlined,
            size: 45.h,
            color: AppColor.colorBlack,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PathologiesScalefactor()),
            );
          },
        ),
      ),
    );
  }
}

/// Displays a title centered on the screen.
class TextSection extends StatelessWidget {
  final double screenWidth;

  const TextSection({super.key, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: AutoSizeText(
        "Rehabilitación a tu alcance",
        style: TextStyle(
          fontSize: 23.sp,
          fontWeight: FontWeight.bold,
          color: AppColor.colorTextOne,
        ),
        maxLines: 1,
      ),
    );
  }
}

/// Displays a description of the rehabilitation protocol.
class ProtocolDescription extends StatelessWidget {
  final double screenWidth;

  const ProtocolDescription({super.key, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 19.w, vertical: 10.h),
      child: Align(
        child: AutoSizeText(
          "Este protocolo tiene como objetivo mejorar la funcionalidad y participación del miembro superior en las actividades de la vida diaria.",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14.sp, color: AppColor.colorWhite, fontWeight: FontWeight.w500),
          maxLines: 4,
        ),
      ),
    );
  }
}
