import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_color_utilities/material_color_utilities.dart';

class NoAnimationPageTransitionsBuilder extends PageTransitionsBuilder {
  const NoAnimationPageTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
      PageRoute<T> route,
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    return child;
  }
}

class ThemeSettings {
  ThemeSettings({
    required this.sourceColor,
    required this.themeMode,
  });

  final Color sourceColor;
  final ThemeMode themeMode;
}

class ThemeSettingsChange extends Notification {
  ThemeSettingsChange({required this.settings});

  final ThemeSettings settings;
}

class CustomColor {
  const CustomColor({
    required this.name,
    required this.color,
    this.blend = true,
  });

  final String name;
  final Color color;
  final bool blend;

  Color value(ThemeProvider provider) {
    return provider.custom(this);
  }
}

class ThemeProvider extends InheritedWidget {
  const ThemeProvider(
      {super.key, required this.settings, required super.child});

  final ValueNotifier<ThemeSettings> settings;

  final pageTransitionsTheme = const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.linux: NoAnimationPageTransitionsBuilder(),
        TargetPlatform.macOS: NoAnimationPageTransitionsBuilder(),
        TargetPlatform.windows: NoAnimationPageTransitionsBuilder(),
      });

  Color custom(CustomColor custom) {
    if (custom.blend) {
      return blend(custom.color);
    } else {
      return custom.color;
    }
  }

  Color blend(Color targetColour) {
    return Color(
        Blend.harmonize(targetColour.value, settings.value.sourceColor.value));
  }

  Color source(Color? target) {
    Color source = settings.value.sourceColor;
    if (target != null) {
      source = blend(target);
    }
    return source;
  }

  ColorScheme colors(Brightness brightness, Color? targetColor) {
    return ColorScheme.fromSeed(
        seedColor: source(targetColor), brightness: brightness);
  }

  BorderRadius get mediumBorderRadius => BorderRadius.circular(8);

  ShapeBorder get shapeMedium => RoundedRectangleBorder(
        borderRadius: mediumBorderRadius,
      );

  TextTheme textTheme(ColorScheme colors) {
    final colorTheme = colors.brightness == Brightness.dark
        ? typography.white
        : typography.black;
    var abelTextTheme = GoogleFonts.abelTextTheme(colorTheme);
    return GoogleFonts.robotoTextTheme(colorTheme).copyWith(
      displayLarge: abelTextTheme.displayLarge,
      displayMedium: abelTextTheme.displayMedium,
      displaySmall: abelTextTheme.displaySmall,
      headlineLarge:
          abelTextTheme.headlineLarge!.copyWith(fontWeight: FontWeight.bold),
      headlineMedium: abelTextTheme.headlineMedium,
      titleLarge: abelTextTheme.titleLarge,
    );
  }

  Typography get typography => Typography.material2021();

  CardTheme cardTheme() {
    return const CardTheme();
  }

  ListTileThemeData listTileTheme(ColorScheme colors) {
    return const ListTileThemeData();
  }

  AppBarTheme appBarTheme(ColorScheme colors) {
    return AppBarTheme(
      elevation: 4,
      backgroundColor: colors.primaryContainer,
      foregroundColor: colors.onPrimaryContainer,
    );
  }

  TabBarTheme tabBarTheme(ColorScheme colors) {
    return const TabBarTheme();
  }

  BottomAppBarTheme bottomAppBarTheme(ColorScheme colors) {
    return const BottomAppBarTheme();
  }

  BottomNavigationBarThemeData bottomNavigationBarTheme(ColorScheme colors) {
    return const BottomNavigationBarThemeData();
  }

  NavigationBarThemeData navigationBarTheme(ColorScheme colors) {
    return const NavigationBarThemeData();
  }

  NavigationRailThemeData navigationRailTheme(ColorScheme colors) {
    return const NavigationRailThemeData();
  }

  DrawerThemeData drawerTheme(ColorScheme colors) {
    return DrawerThemeData(
      elevation: 4,
      backgroundColor: colors.surface,
    );
  }

  ProgressIndicatorThemeData progressIndicatorTheme(ColorScheme colors) {
    return const ProgressIndicatorThemeData();
  }

  FloatingActionButtonThemeData floatingActionButtonTheme(ColorScheme colors) {
    return const FloatingActionButtonThemeData();
  }

  ElevatedButtonThemeData elevatedButtonTheme(ColorScheme colors) {
    return ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
      backgroundColor: colors.primary,
      foregroundColor: colors.onPrimary,
    ));
  }

  InputDecorationTheme inputDecorationTheme(ColorScheme colors) {
    return const InputDecorationTheme(border: OutlineInputBorder());
  }

  ButtonThemeData buttonTheme(ColorScheme colors) {
    return const ButtonThemeData();
  }

  TextButtonThemeData textButtonTheme(ColorScheme colors) {
    return const TextButtonThemeData();
  }

  IconThemeData iconTheme(ColorScheme colors) {
    return IconThemeData(
      color: colors.onBackground,
    );
  }

  PopupMenuThemeData popupMenuTheme(ColorScheme colors) {
    return const PopupMenuThemeData();
  }

  ThemeData light([Color? targetColor]) {
    final colorScheme = colors(Brightness.light, targetColor);
    return ThemeData.light().copyWith(
      pageTransitionsTheme: pageTransitionsTheme,
      colorScheme: colorScheme,
      appBarTheme: appBarTheme(colorScheme),
      cardTheme: cardTheme(),
      listTileTheme: listTileTheme(colorScheme),
      bottomAppBarTheme: bottomAppBarTheme(colorScheme),
      bottomNavigationBarTheme: bottomNavigationBarTheme(colorScheme),
      navigationBarTheme: navigationBarTheme(colorScheme),
      tabBarTheme: tabBarTheme(colorScheme),
      drawerTheme: drawerTheme(colorScheme),
      navigationRailTheme: navigationRailTheme(colorScheme),
      progressIndicatorTheme: progressIndicatorTheme(colorScheme),
      floatingActionButtonTheme: floatingActionButtonTheme(colorScheme),
      inputDecorationTheme: inputDecorationTheme(colorScheme),
      buttonTheme: buttonTheme(colorScheme),
      textButtonTheme: textButtonTheme(colorScheme),
      elevatedButtonTheme: elevatedButtonTheme(colorScheme),
      popupMenuTheme: popupMenuTheme(colorScheme),
      scaffoldBackgroundColor: colorScheme.background,
      textTheme: textTheme(colorScheme),
      iconTheme: iconTheme(colorScheme),
      typography: typography,
      useMaterial3: true,
    );
  }

  ThemeData dark([Color? targetColor]) {
    final colorScheme = colors(Brightness.dark, targetColor);
    return ThemeData.dark().copyWith(
      pageTransitionsTheme: pageTransitionsTheme,
      colorScheme: colorScheme,
      appBarTheme: appBarTheme(colorScheme),
      cardTheme: cardTheme(),
      listTileTheme: listTileTheme(colorScheme),
      bottomAppBarTheme: bottomAppBarTheme(colorScheme),
      bottomNavigationBarTheme: bottomNavigationBarTheme(colorScheme),
      navigationBarTheme: navigationBarTheme(colorScheme),
      tabBarTheme: tabBarTheme(colorScheme),
      drawerTheme: drawerTheme(colorScheme),
      navigationRailTheme: navigationRailTheme(colorScheme),
      progressIndicatorTheme: progressIndicatorTheme(colorScheme),
      floatingActionButtonTheme: floatingActionButtonTheme(colorScheme),
      inputDecorationTheme: inputDecorationTheme(colorScheme),
      buttonTheme: buttonTheme(colorScheme),
      textButtonTheme: textButtonTheme(colorScheme),
      elevatedButtonTheme: elevatedButtonTheme(colorScheme),
      popupMenuTheme: popupMenuTheme(colorScheme),
      scaffoldBackgroundColor: colorScheme.background,
      textTheme: textTheme(colorScheme),
      iconTheme: iconTheme(colorScheme),
      typography: typography,
      useMaterial3: true,
    );
  }

  ThemeMode themeMode() {
    return settings.value.themeMode;
  }

  ThemeData theme(BuildContext context, [Color? targetColor]) {
    final brightness = MediaQuery.of(context).platformBrightness;
    return brightness == Brightness.light
        ? light(targetColor)
        : dark(targetColor);
  }

  static ThemeProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ThemeProvider>()!;
  }

  @override
  bool updateShouldNotify(covariant ThemeProvider oldWidget) {
    return oldWidget.settings != settings;
  }
}

Color randomColor() {
  return Color(Random().nextInt(0xFFFFFFFF));
}

const carlitasColor = Color.fromARGB(255, 0, 108, 248);
