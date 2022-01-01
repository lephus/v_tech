import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomColor{
    static Color titleTextColorBlue = Color(0xFF3366CC);
    static Color subTextColorBlue = Color(0xFF61A3FE);
    static Color subTextColorTextCn = Color(0xFF81D4FA);
    static Color ColorBlue = Color(0xFFA4CDFF);
    static Color titleTextColorWhite = Colors.white;
    static Color subTextColorWhite = Colors.white54;

    static Color colorBGComponent = Colors.white;
    static Color pageDarkBackgroundColor = Color(0xFF67748E);
    static Color menuDarkBackgroundColor = Color(0xFF242634);
    static Color blackColor = Colors.black;

    static Color TimKeepingColor = Color(0xFF2697FF);

    static Color colorBG = Color(0xFFF7F7F7);
    static Color clockBG = Color(0xFF444974);
    static Color clockOutline = Color(0xFFEAECFF);
    static Color secHandColor = Colors.orange;
    static Color minHandStatColor = Color(0xFF748EF6);
    static Color minHandEndColor = Color(0xFF77DDFF);
    static Color hourHandStatColor = Color(0xFFC279FB);
    static Color hourHandEndColor = Color(0xFF930000);
    static Color runTimerInside = Color(0xFF61A3FE);
    static Color runTimerOutside = Color(0xFFC279FB);

    static Color primaryColor = Color(0xFF2697FF);
    static Color secondaryColor = Color(0xFF2A2D3E);
    static Color bgColor = Color(0xFF212332);
  }

  class GradientColors{
    static List<Color> sky = [Color(0xFF6448FE), Color(0xFF5FC6FF)];
    static List<Color> sunset = [Color(0xFFFE6197), Color(0xFFFFB463)];
    static List<Color> sea = [Color(0xFF61A3FE), Color(0xFF63FFD5)];
    static List<Color> mango = [Color(0xFFFFA738), Color(0xFFFFE130)];
    static List<Color> fire = [Color(0xFFFF5DCD), Color(0xFFFF8484)];
  }
  class SizeText{
    static double sizeTitleText = 14.0;
    static double sizeSubTitleText = 12.0;
    static double sizeHeaderText = 16.0;
    static double sizeTextButton = 14.0;
    static double superHeaderText = 18.0;
    static double defaultPadding = 16.0;
  }
  class ScreenSize{
  static double height = Get.height;
  static double width = Get.width;
}
class CommonStyle {
  static TextStyle normalTextBlack(BuildContext context) {
    return TextStyle(
        fontSize: 13.0,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w400,
        color: Colors.black87);
  }

  static TextStyle regularTextBlack(BuildContext context) {
    return TextStyle(
        fontSize: 15.0,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w400,
        color: Colors.black87);
  }

  static TextStyle strongTextBlack(BuildContext context) {
    return TextStyle(
        fontSize: 13.0,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w600,
        color: Colors.black);
  }

  static TextStyle bottomTextTitle(BuildContext context) {
    return TextStyle(
        fontSize: 13.0,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w600,
        color: Colors.cyan);
  }

  static TextStyle bottomTextSubTitle(BuildContext context) {
    return TextStyle(
        fontSize: 10.0,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w400,
        color: Colors.blueGrey);
  }

  static TextStyle strongTextBlackTitle(BuildContext context) {
    return TextStyle(
        fontSize: 18.0,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w600,
        color: Colors.black);
  }

  static TextStyle normalTextGrey(BuildContext context) {
    return TextStyle(
        fontSize: 13.0,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w400,
        color: Colors.grey[400]);
  }

  static TextStyle headerTextMainColor(BuildContext context) {
    return TextStyle(
        fontSize: 32.0,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w600,
        color: Colors.cyan);
  }

  static TextStyle regularTextGrey(BuildContext context) {
    return TextStyle(
        fontSize: 13.0,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w400,
        color: Colors.grey[600]);
  }

  static TextStyle buttonText(BuildContext context) {
    return TextStyle(
        fontSize: 13.0,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w700,
        color: Colors.white);
  }

  static TextStyle avatarText(BuildContext context) {
    return TextStyle(
        fontSize: 20.0,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w700,
        color: Colors.white);
  }
}