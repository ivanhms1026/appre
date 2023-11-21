import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:appre/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UsagePolicies extends StatefulWidget {
  const UsagePolicies({Key? key}) : super(key: key);

  @override
  _UsagePoliciesState createState() => _UsagePoliciesState();
}

class _UsagePoliciesState extends State<UsagePolicies> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 55.h,
        leading: BackButton(color: AppColor.colorBlack),
        title: Text(
          "Politicas de Uso",
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
          Container(
            color: AppColor.colorWhite,
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: AutoSizeText(
                      "Agradecemos tu interés en AppRe. Antes de utilizarla, es importante que comprendas y aceptes nuestras políticas de uso. Al usar la Aplicación, se da por entendido que aceptas estas políticas.",
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
                    "Uso de Datos de Registro",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: Colors.black),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: AutoSizeText(
                      "1. Para proporcionarte un ingreso seguro y único a la Aplicación, requerimos ciertos datos de registro, que pueden incluir tu nombre, dirección de correo electrónico y contraseña. Estos datos se recopilan exclusivamente con el propósito de autenticarte y garantizar que solo tú tengas acceso a tu cuenta.",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: AppColor.colorBlack.withOpacity(0.6),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: AutoSizeText(
                      "2. Entendemos la importancia de la privacidad de tus datos y nos comprometemos a protegerlos de acuerdo con nuestras políticas de privacidad.",
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
                    "Responsabilidad del Usuario",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: Colors.black),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: AutoSizeText(
                      "El usuario asume toda la responsabilidad por su uso de la Aplicación y los resultados obtenidos.",
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
                    "Uso sin Supervisión de un Profesional en el campo",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: Colors.black),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: AutoSizeText(
                      "Esta aplicación móvil de rehabilitación de miembros superiores AppRe, está diseñada para proporcionar información y ejercicios de rehabilitación. Sin embargo, es importante tener en cuenta que el uso de esta Aplicación sin la supervisión de un profesional fisioterapeuta puede conllevar riesgos para la salud física \n\nEl usuario reconoce y acepta que:",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: AppColor.colorBlack.withOpacity(0.6),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: AutoSizeText(
                      "La aplicación no reemplaza la evaluación y la atención personalizada de un profesional de la salud, como un fisioterapeuta o un médico",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: AppColor.colorBlack.withOpacity(0.6),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: AutoSizeText(
                      "El uso de la Aplicación implica riesgos inherentes, incluyendo, pero no limitado a, el riesgo de lesiones físicas o agravación de condiciones médicas preexistentes.",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: AppColor.colorBlack.withOpacity(0.6),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: AutoSizeText(
                      "Antes de comenzar cualquier programa de ejercicios o tratamiento utilizando esta Aplicación, se recomienda encarecidamente que el usuario consulte con un profesional fisioterapeuta o médico para evaluar su condición y recibir recomendaciones adecuadas.",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: AppColor.colorBlack.withOpacity(0.6),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: AutoSizeText(
                      "El usuario asume toda la responsabilidad por cualquier daño físico o lesión que pueda resultar del uso de la Aplicación sin la supervisión de un profesional fisioterapeuta.",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: AppColor.colorBlack.withOpacity(0.6),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: AutoSizeText(
                      "La Aplicación y sus desarrolladores no serán responsables de ningún daño físico, pérdida o perjuicio que pueda sufrir el usuario como resultado de su uso de la Aplicación sin supervisión profesional.",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: AppColor.colorBlack.withOpacity(0.6),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: AutoSizeText(
                      "Al usar esta Aplicación, el usuario acepta y comprende los riesgos asociados con el uso no supervisado y libera de responsabilidad a la Aplicación de AppRe y sus desarrolladores de cualquier reclamo, demanda o acción legal relacionada con cualquier daño físico o lesión que pueda sufrir como resultado del uso de la Aplicación.",
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
                    "Uso Apropiado de la Aplicación",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: Colors.black),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: AutoSizeText(
                      "1. La Aplicación está diseñada para proporcionar ejercicios de rehabilitación de miembros superiores. Debes utilizarla solo con fines de rehabilitación y mejora de la salud.",
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: AppColor.colorBlack.withOpacity(0.6),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: AutoSizeText(
                      "2. No se permite el uso de la Aplicación para ningún propósito ilegal o inapropiado.",
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
                  Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: AutoSizeText(
                      "Al utilizar la Aplicación, aceptas todas las políticas y términos establecidos anteriormente. Si no estás de acuerdo con alguna de estas políticas, te recomendamos que no utilices la Aplicación. Gracias por confiar en AppRe para tu rehabilitación de miembros superiores. ¡Esperamos que encuentres nuestra Aplicación beneficiosa para tu salud y bienestar!",
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
