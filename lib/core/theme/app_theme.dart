import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:job_pilot/const/colors/app_colors.dart';

///This class defines light theme and dark theme
///Here we used flex color scheme
class Themes {
  static ThemeData get theme => FlexThemeData.light(
        colors: FlexSchemeColor.from(primary: AppColors.kPrimaryColor),
        scaffoldBackground: AppColors.kwhite,
        appBarBackground: AppColors.kSecondaryBgColor,
        applyElevationOverlayColor: true,
        appBarStyle: FlexAppBarStyle.background,
        scheme: FlexScheme.brandBlue,
        surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
        blendLevel: 20,
        appBarOpacity: 0.95,
        swapColors: true,
        tabBarStyle: FlexTabBarStyle.forBackground,

        subThemesData: const FlexSubThemesData(
          blendOnLevel: 20,
          blendOnColors: false,
          inputDecoratorRadius: 8,
        ),
        keyColors: const FlexKeyColors(
          useSecondary: true,
          useTertiary: true,
        ),
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            // replace default CupertinoPageTransitionsBuilder with this
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          },
        ),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(),

        /// fontFamily: GoogleFonts.getFont('Lato').fontFamily,

        ///
      );
  static ThemeData get darkTheme => FlexThemeData.dark(
        colors: FlexSchemeColor.from(primary: AppColors.kPrimaryColor),
        scaffoldBackground: AppColors.kBlack,
        // appBarBackground: AppColors.kSecondaryBgColor,
        scheme: FlexScheme.brandBlue,
        surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
        blendLevel: 15,
        // appBarStyle: FlexAppBarStyle.background,
        appBarOpacity: 0.90,
        tabBarStyle: FlexTabBarStyle.forBackground,
        subThemesData: const FlexSubThemesData(
          blendOnLevel: 30,
          inputDecoratorRadius: 8,
        ),
        keyColors: const FlexKeyColors(
          useSecondary: true,
          useTertiary: true,
        ),
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            // replace default CupertinoPageTransitionsBuilder with this
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          },
        ),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,
        // To use the playground font, add GoogleFonts package and uncomment
        // fontFamily: GoogleFonts.getFont('Lato').fontFamily,
      );
// If you do not have a themeMode switch, uncomment this line
// to let the device system mode control the theme mode:
// themeMode: ThemeMode.system,
}
