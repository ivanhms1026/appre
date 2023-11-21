import 'package:get/get.dart';

class Dimensions {
  static double get screenHeight => Get.height;
  static double get screenWidth => Get.width;

  static double get pageView => screenHeight / 2.64;
  static double get pageViewContainer => screenHeight / 3.84;
  static double get pageViewTextContainer => screenHeight / 7.03;

  static double get height10 => screenHeight / 84.4;
  static double get height15 => screenHeight / 56.27;
  static double get height20 => screenHeight / 42.2;
  static double get height30 => screenHeight / 28.13;
  static double get height40 => screenHeight / 18.73;

  static double get width10 => screenHeight / 84.4;
  static double get width15 => screenHeight / 56.27;
  static double get width20 => screenHeight / 42.2;
  static double get width30 => screenHeight / 28.13;

  static double get font20 => screenHeight / 42.2;

  static double get radius20 => screenHeight / 42.2;
  static double get radius30 => screenHeight / 28.13;
}