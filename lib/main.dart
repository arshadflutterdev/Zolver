import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zolver/core/routes/app_pages.dart';
import 'package:zolver/core/routes/app_routes.dart';
import 'package:zolver/core/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  final box = GetStorage();
  final String? storedRole = box.read<String>('user_role');
  final String storedThemeMode = box.read<String>('theme_mode') ?? 'system';

  String initialRoute = AppPages.initial;
  if (storedRole == 'worker') {
    initialRoute = Routes.workerHome;
  } else if (storedRole == 'client') {
    initialRoute = Routes.clientHome;
  }

  final ThemeMode themeMode = switch (storedThemeMode) {
    'light' => ThemeMode.light,
    'dark' => ThemeMode.dark,
    _ => ThemeMode.system,
  };

  runApp(ZolverApp(initialRoute: initialRoute, themeMode: themeMode));
}

class ZolverApp extends StatelessWidget {
  final String initialRoute;
  final ThemeMode themeMode;

  const ZolverApp({super.key, required this.initialRoute, required this.themeMode});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Zolver',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeMode,
      initialRoute: initialRoute,
      getPages: AppPages.routes,
    );
  }
}
