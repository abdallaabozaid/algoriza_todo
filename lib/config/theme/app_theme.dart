import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/config/theme/app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    fontFamily: 'Righteous',
    textTheme: AppTextTheme.textTheme,
    brightness: Brightness.light,
    appBarTheme: _appBarTheme(),
    inputDecorationTheme: _inputDecorationTheme,
  );

  static void setSystemUIOverlayStyle() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
  }

  static final InputDecorationTheme _inputDecorationTheme =
      InputDecorationTheme(
    contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
    hintStyle: TextStyle(
      fontSize: 15.sp,
    ),
    errorStyle: TextStyle(
      fontSize: 14.sp,
      color: Colors.red,
    ),
    filled: true,
    fillColor: Colors.grey.shade200,
    border: _inputBorderDecoration(
      borderWidth: 3,
    ),
    enabledBorder: _inputBorderDecoration(
      color: Colors.transparent,
    ),
    focusedBorder: _inputBorderDecoration(
      color: AppColors.appMainColor,
      borderWidth: 0.6,
    ),
    errorBorder: _inputBorderDecoration(
      color: Colors.red,
      borderWidth: 1,
    ),
  );

  static OutlineInputBorder _inputBorderDecoration(
      {Color? color, double? borderWidth}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(22.r),
      borderSide: color != null
          ? BorderSide(
              color: color,
              width: borderWidth ?? 0,
            )
          : BorderSide(
              width: borderWidth ?? 0,
            ),
    );
  }

  static AppBarTheme _appBarTheme() {
    return AppBarTheme(
      toolbarHeight: 120.h,
      elevation: 0,
      iconTheme: const IconThemeData(
        color: Colors.black,
      ),
      backgroundColor: Colors.transparent,
      titleTextStyle: TextStyle(
        fontSize: 26.sp,
        color: Colors.black,
        fontFamily: 'Righteous',
      ),
    );
  }
}

class AppTextTheme {
  static TextTheme textTheme = TextTheme(
    // label lagre used for elevatedbutton text style
    labelLarge: _labelLargeTextStyle,
    // body medium used for task item text , form field title
    bodyMedium: _bodyMediumTextStyle,
    bodySmall: _bodySmallTextStyle,
  );

  static final TextStyle _labelLargeTextStyle = TextStyle(
    fontSize: 18.sp,
    color: Colors.white,
  );

  static final TextStyle _bodyMediumTextStyle = TextStyle(
    fontSize: 18.sp,
    color: Colors.black,
    fontWeight: FontWeight.w100,
  );
  static final TextStyle _bodySmallTextStyle = TextStyle(
    fontSize: 16.sp,
    color: Colors.grey,
    fontWeight: FontWeight.w100,
  );
}
