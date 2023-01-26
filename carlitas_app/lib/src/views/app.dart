import 'package:carlitas_app/src/providers/theme.dart';
import 'package:carlitas_app/src/views/home/home_page.dart';
import 'package:flutter/material.dart';

class CarlitasApp extends StatelessWidget {
  final settings = ValueNotifier(
      ThemeSettings(sourceColor: carlitasColor, themeMode: ThemeMode.system));

  CarlitasApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      settings: settings,
      child: NotificationListener<ThemeSettingsChange>(
        onNotification: (notification) {
          settings.value = notification.settings;
          return true;
        },
        child: ValueListenableBuilder<ThemeSettings>(
          valueListenable: settings,
          builder: (context, value, _) {
            final theme = ThemeProvider.of(context);
            return _buildMaterialApp(theme);
          },
        ),
      ),
    );
  }

  MaterialApp _buildMaterialApp(ThemeProvider theme) {
    return MaterialApp(
      title: 'Carlitas App',
      debugShowCheckedModeBanner: false,
      restorationScopeId: 'app',
      theme: theme.light(settings.value.sourceColor),
      darkTheme: theme.dark(settings.value.sourceColor),
      themeMode: theme.themeMode(),
      home: const HomePage(),
    );
  }
}
