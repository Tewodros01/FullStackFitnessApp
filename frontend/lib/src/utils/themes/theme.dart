import 'package:flutter/material.dart';
import 'package:frontend/src/utils/themes/widget_theme/elevated_button_theme.dart';
import 'package:frontend/src/utils/themes/widget_theme/outlined_button_theme.dart';
import 'package:frontend/src/utils/themes/widget_theme/text_field_theme.dart';
import 'widget_theme/txt_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CAppTheme {
  CAppTheme._();
  static ThemeData ligthTheme = ThemeData(
    brightness: Brightness.light,
    textTheme: CTextTheme.ligthTextTheme,
    outlinedButtonTheme: COutlinedButtonTheme.ligthOutlinedButtonTheme,
    elevatedButtonTheme: CElevatedButtonTheme.ligthElevatedButtonTheme,
    inputDecorationTheme: CTextFormFieldTheme.ligthInputDecorationTheme,
  );
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    textTheme: CTextTheme.darkTextTheme,
    outlinedButtonTheme: COutlinedButtonTheme.darkOutlinedButtonTheme,
    elevatedButtonTheme: CElevatedButtonTheme.darkElevatedButtonTheme,
    inputDecorationTheme: CTextFormFieldTheme.darkInputDecorationTheme,
  );
}

const Color greenClr = Color(0XFF40D876);
const Color blueishClr = Color(0XFF4e5ae8);
const Color yellowClr = Color(0XFFFFB746);
const Color pinkClr = Color(0XFFff4667);
const Color whiteClr = Colors.white;
const primaryClr = blueishClr;
const Color darkGreyClr = Color.fromARGB(255, 21, 21, 19);
const Color darkHeaderClr = Color(0XFF424242);

class Themes {
  static final ligth = ThemeData(
    backgroundColor: Colors.white,
    primaryColor: primaryClr,
    brightness: Brightness.light,
  );
  static final dark = ThemeData(
    backgroundColor: darkGreyClr,
    primaryColor: darkHeaderClr,
    brightness: Brightness.dark,
  );
}

TextStyle get subHeadingStyle {
  return TextStyle(
    fontSize: 17.sp,
    fontWeight: FontWeight.bold,
    color: Get.isDarkMode ? Colors.grey[400] : Colors.grey,
  );
}

TextStyle get headingStyle {
  return TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
    color: Get.isDarkMode ? Colors.white : Colors.black,
  );
}

TextStyle get titleStyle {
  return TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: Get.isDarkMode ? Colors.white : Colors.black,
  );
}

TextStyle get subTitleStyle {
  return TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Get.isDarkMode ? Colors.grey[100] : Colors.grey[400],
  );
}
