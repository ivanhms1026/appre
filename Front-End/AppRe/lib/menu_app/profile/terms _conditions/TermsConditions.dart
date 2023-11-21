import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:appre/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TermsConditions extends StatefulWidget {
  const TermsConditions({Key? key}) : super(key: key);

  @override
  _TermsConditionsState createState() => _TermsConditionsState();
}

class _TermsConditionsState extends State<TermsConditions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 55.h,
        leading: BackButton(color: AppColor.colorBlack),
        title: Text(
          "Terminos y Condiciones",
          style: TextStyle(
            fontSize: 17.sp,
            color: AppColor.colorBlack,
          ),
        ),
        centerTitle: false,
        elevation: 0,
        flexibleSpace: Container(
          color: AppColor.colorWhite,
        ),
      ),
      body: ListView(
        children: [
          SizedBox(height: 10.h),
          Container(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Aceptación de los Términos y Condiciones",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: Colors.black),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: AutoSizeText(
                      "Al utilizar la aplicación de rehabilitación de miembros superiores AppRe, usted acepta y se compromete a cumplir con los siguientes Términos y Condiciones. Si no está de acuerdo con estos términos, no utilice la Aplicación.",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: AppColor.colorBlack.withOpacity(0.6),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    "Uso de la Aplicación",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: Colors.black),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: AutoSizeText(
                      "La Aplicación está diseñada para proporcionar información y ejercicios de rehabilitación para el miembro superior. No debe considerarse un sustituto de la atención médica profesional.\n\nAntes de comenzar cualquier programa de ejercicios o tratamiento utilizando esta Aplicación, se recomienda encarecidamente que consulte con un profesional de la salud para evaluar su condición y recibir recomendaciones adecuadas.",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: AppColor.colorBlack.withOpacity(0.6),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    "Privacidad y Datos del Usuario",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: Colors.black),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: AutoSizeText(
                      "La recopilación y el uso de datos del usuario se rigen por nuestra Política de Privacidad, que se encuentra en el documento de Politicas de Uso.",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: AppColor.colorBlack.withOpacity(0.6),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    "Responsabilidad",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: Colors.black),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: AutoSizeText(
                      "La Aplicación y sus desarrolladores no son responsables de ningún daño físico o lesión que pueda resultar del uso de la Aplicación sin supervisión profesional.",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: AppColor.colorBlack.withOpacity(0.6),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
