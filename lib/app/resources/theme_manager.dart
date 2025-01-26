import 'package:google_fonts/google_fonts.dart';
import 'color_manager.dart';
import 'styles_manager.dart';
import 'values_manager.dart';
import 'package:flutter/material.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: ColorManager.background1,
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.lightPrimary,
    primaryColorDark: ColorManager.darkPrimary,
    disabledColor: ColorManager.lightGrey1,
    splashColor: ColorManager.transparent,
    highlightColor: ColorManager.transparent,

    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: const MaterialColor(
          ColorManager.primaryValue, ColorManager.colorSwatch),
    ),
    dividerColor: Colors.transparent,
    // Card Theme
    cardTheme: const CardTheme(
      color: ColorManager.white,
      shadowColor: ColorManager.transparent,
      elevation: AppSize.s4,
    ),
    // AppBar Theme
    appBarTheme: AppBarTheme(
      backgroundColor: ColorManager.background1,
      centerTitle: true,
      elevation: 0,
      scrolledUnderElevation: 0,
      shadowColor: ColorManager.transparent,
      iconTheme: const IconThemeData(
        color: ColorManager.black,
      ),
      titleTextStyle: getRegularStyle(
        color: ColorManager.black,
        fontSize: AppSize.s16,
      ),
    ),
    iconButtonTheme: IconButtonThemeData(
        style: ButtonStyle(
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    )),
    // Button Theme
    buttonTheme: const ButtonThemeData(
      buttonColor: ColorManager.primary,
      splashColor: ColorManager.lightPrimary,
      shape: StadiumBorder(),
      disabledColor: ColorManager.lightGrey1,
    ),
    // Elevated Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: ColorManager.white,
        backgroundColor: ColorManager.primary,
        textStyle: GoogleFonts.poppins(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s8),
        ),
      ),
    ),
    // Text theme
    textTheme: GoogleFonts.poppinsTextTheme(),
    // Input Decoration theme
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(AppPadding.p8),
      hintStyle: getRegularStyle(color: ColorManager.lightGrey),
      labelStyle: getMediumStyle(color: ColorManager.lightGrey),
      errorStyle: getRegularStyle(color: ColorManager.error),
      enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: ColorManager.lightGrey1)),
      focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: ColorManager.lightGrey1)),
      errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: ColorManager.lightGrey1)),
      focusedErrorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: ColorManager.lightGrey1)),
    ),
    dialogTheme: const DialogTheme(backgroundColor: ColorManager.white),
    expansionTileTheme: const ExpansionTileThemeData(
      collapsedBackgroundColor: ColorManager.white,
    ),
  );
}
