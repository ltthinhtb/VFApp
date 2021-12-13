import 'package:flutter/material.dart';
import 'package:vf_app/common/app_colors.dart';

import 'app_text_styles.dart';

class AppThemes {
  AppThemes._();

  //Primary
  static const Color _lightPrimaryColor = AppColors.primary;

  //Secondary
  // static const Color _lightSecondaryColor = Color(0xFFd74315);
  // static const Color _darkSecondaryColor = Color(0xFFd74315);

  //Background
  static const Color _lightBackgroundColor = AppColors.backgroundLighter;
  static const Color _darkBackgroundColor = AppColors.backgroundDarker;

  //Text
  static const Color _lightTextColor = AppColors.textBlack;
  static const Color _darkTextColor = AppColors.textWhite;

  //Border
  // static const Color _lightBorderColor = Colors.grey;
  // static const Color _darkBorderColor = Colors.grey;

  //Icon
  static const Color _lightIconColor = AppColors.black;
  static const Color _darkIconColor = AppColors.white;

  //Fill
  static const _lightFillColor = AppColors.black;
  static const _darkFillColor = AppColors.white;

  //Text themes
  static final TextTheme _lightTextTheme = TextTheme(
    headline5: AppTextStyle.H5Bold.copyWith(color: _lightTextColor),
    headline6: AppTextStyle.H6Regular.copyWith(color: _lightTextColor),
    headline4: AppTextStyle.H4Bold.copyWith(color: _lightTextColor),
    headline3: AppTextStyle.H3.copyWith(color: _lightTextColor),
    subtitle1: AppTextStyle.subTitle1.copyWith(color: _lightTextColor),
    subtitle2: AppTextStyle.subTitle2.copyWith(color: _lightTextColor),
    bodyText1: AppTextStyle.bodyText1.copyWith(color: _lightTextColor),
    bodyText2: AppTextStyle.bodyText2.copyWith(color: _lightTextColor),
    button: AppTextStyle.ButtonBold.copyWith(color: _lightTextColor),
    headline1: AppTextStyle.H1.copyWith(color: _lightTextColor),
    headline2: AppTextStyle.H2.copyWith(color: _lightTextColor),
    caption: AppTextStyle.caption.copyWith(color: _lightTextColor),
  );

  static final TextTheme _dartTextTheme = TextTheme(
    headline5: AppTextStyle.H5Bold.copyWith(color: _darkTextColor),
    headline6: AppTextStyle.H6Bold.copyWith(color: _darkTextColor),
    headline4: AppTextStyle.H4Bold.copyWith(color: _darkTextColor),
    headline3: AppTextStyle.H3.copyWith(color: _darkTextColor),
    subtitle1: AppTextStyle.subTitle1.copyWith(color: _darkTextColor),
    subtitle2: AppTextStyle.subTitle2.copyWith(color: _darkTextColor),
    bodyText1: AppTextStyle.bodyText1.copyWith(color: _darkTextColor),
    bodyText2: AppTextStyle.bodyText2.copyWith(color: _darkTextColor),
    button: AppTextStyle.ButtonBold.copyWith(color: _darkTextColor),
    caption: AppTextStyle.caption.copyWith(color: _darkTextColor),
    headline1: AppTextStyle.H1.copyWith(color: _darkTextColor),
    headline2: AppTextStyle.H2.copyWith(color: _darkTextColor),
  );

  static final ElevatedButtonThemeData _elevatedButtonThemeData =
      ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(vertical: 15),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      primary: AppColors.primary,
      onPrimary: AppColors.grayF2,
      textStyle: AppTextStyle.H5Bold,
    ),
  );

  static final TextButtonThemeData _textButtonThemeData = TextButtonThemeData(
    style: TextButton.styleFrom(
      padding: EdgeInsets.zero,
      primary: AppColors.backgroundDarker,
      textStyle: AppTextStyle.H5Bold,
    ),
  );

  static OutlineInputBorder _defaultBorder() {
    return const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(color: AppColors.line, width: 1));
  }

  static final InputDecorationTheme _inputDecorationLightTheme =
      InputDecorationTheme(
    contentPadding: const EdgeInsets.symmetric(vertical: 5),
    labelStyle: AppTextStyle.H6Regular.copyWith(color: AppColors.black),
    filled: true,
    fillColor: AppColors.grayF2,
    hintStyle: AppTextStyle.H6Regular.copyWith(color: AppColors.grayC4),
    errorStyle: AppTextStyle.H6Regular.copyWith(color: AppColors.red),
    border: _defaultBorder(),
    focusedBorder: _defaultBorder().copyWith(
        borderSide: const BorderSide(color: AppColors.primary, width: 1)),
    enabledBorder: _defaultBorder(),
    disabledBorder: _defaultBorder(),
    errorBorder: _defaultBorder().copyWith(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        borderSide: const BorderSide(color: AppColors.red, width: 1)),
  );
  static final ButtonThemeData _buttonDecorationLightTheme = ButtonThemeData(
    height: 40,
    minWidth: 40,
    padding: const EdgeInsets.all(10),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(20.0),
      ),
      side: BorderSide.none,
    ),
    buttonColor: AppColors.grayF2,
    colorScheme: const ColorScheme.light()
        .copyWith(primary: AppColors.grayF2, primaryVariant: AppColors.primary),
  );
  static final ToggleButtonsThemeData _toggleButtonDecorationLightTheme =
      const ToggleButtonsThemeData(
    color: AppColors.grayF2,
    focusColor: AppColors.grayF2,
    hoverColor: AppColors.grayF2,
    splashColor: AppColors.red,
  );

  static final BottomNavigationBarThemeData _bottomNavigationBarThemeData =
      BottomNavigationBarThemeData(
          backgroundColor: AppColors.grayF2,
          unselectedItemColor: AppColors.gray88,
          selectedItemColor: AppColors.primary,
          selectedLabelStyle: AppTextStyle.H8Bold,
          unselectedLabelStyle: AppTextStyle.H8Bold);
  static final TabBarTheme _tabBarTheme = TabBarTheme(
      unselectedLabelStyle: AppTextStyle.H7Regular,
      labelColor: AppColors.white,
      unselectedLabelColor: AppColors.black,
      labelStyle: AppTextStyle.H7Bold,
      indicatorSize: TabBarIndicatorSize.tab,
      labelPadding: const EdgeInsets.symmetric(vertical: 10),
      indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: AppColors.primary));

  static final ColorScheme _lightColorScheme = const ColorScheme(
    primary: AppColors.primary,
    primaryVariant: Color(0xFF117378),
    secondary: AppColors.secondary,
    secondaryVariant: Color(0xFFFAFBFB),
    background: Color(0xFFE6EBEB),
    surface: Color(0xFFFAFBFB),
    onBackground: Colors.white,
    error: _lightFillColor,
    onError: _lightFillColor,
    onPrimary: _lightFillColor,
    onSecondary: Color(0xFF322942),
    onSurface: Color(0xFF241E30),
    brightness: Brightness.light,
  );

  static const ColorScheme _darkColorScheme = ColorScheme(
    primary: Color(0xFFFF8383),
    primaryVariant: Color(0xFF1CDEC9),
    secondary: AppColors.secondary,
    secondaryVariant: Color(0xFF451B6F),
    background: Color(0xFF241E30),
    surface: Color(0xFF1F1929),
    onBackground: Color(0x0DFFFFFF),
    // White with 0.05 opacity
    error: _darkFillColor,
    onError: _darkFillColor,
    onPrimary: _darkFillColor,
    onSecondary: _darkFillColor,
    onSurface: _darkFillColor,
    brightness: Brightness.dark,
  );

  ///Light theme
  static final ThemeData lightTheme = ThemeData(
    inputDecorationTheme: _inputDecorationLightTheme,
    buttonTheme: _buttonDecorationLightTheme,
    toggleButtonsTheme: _toggleButtonDecorationLightTheme,
    toggleableActiveColor: AppColors.grayF2,
    backgroundColor: AppColors.grayF2,
    elevatedButtonTheme: _elevatedButtonThemeData,
    textButtonTheme: _textButtonThemeData,
    brightness: Brightness.light,
    primaryColor: _lightPrimaryColor,
    scaffoldBackgroundColor: _lightBackgroundColor,
    colorScheme: _lightColorScheme,
    bottomNavigationBarTheme: _bottomNavigationBarThemeData,
    tabBarTheme: _tabBarTheme,
    dividerColor: AppColors.line,
    appBarTheme: AppBarTheme(
        iconTheme: const IconThemeData(color: _lightIconColor),
        titleTextStyle:
            AppTextStyle.H5Bold.copyWith(color: AppColors.textBlack),
        backgroundColor: _lightBackgroundColor),
    iconTheme: const IconThemeData(
      color: _lightIconColor,
    ),
    textTheme: _lightTextTheme,
  );

  ///Dark theme
  static final ThemeData darkTheme = ThemeData(
    elevatedButtonTheme: _elevatedButtonThemeData,
    cardColor: AppColors.background,
    brightness: Brightness.dark,
    primaryColor: _lightPrimaryColor,
    scaffoldBackgroundColor: _darkBackgroundColor,
    colorScheme: _darkColorScheme,
    tabBarTheme: _tabBarTheme,
    bottomNavigationBarTheme: _bottomNavigationBarThemeData,
    appBarTheme: AppBarTheme(
        iconTheme: const IconThemeData(color: _darkIconColor),
        titleTextStyle: AppTextStyle.H6Bold,
        backgroundColor: _lightPrimaryColor),
    iconTheme: const IconThemeData(
      color: _lightIconColor,
    ),
    textTheme: _dartTextTheme,
  );
}
