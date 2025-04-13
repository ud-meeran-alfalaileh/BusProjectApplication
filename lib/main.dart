import 'package:drive_app/main_app_page.dart';
import 'package:drive_app/src/config/localization/local_strings.dart';
import 'package:drive_app/src/config/localization/locale_constant.dart';
import 'package:drive_app/src/config/theme/theme.dart';
import 'package:drive_app/src/core/api/injection_container.dart' as di;
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(Phoenix(child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final localizationController = Get.put(LocalizationController());

  @override
  void initState() {
    localizationController.loadLanguage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      locale: const Locale('en', 'US'),
      translations: LocalStrings(),
      title: 'Drive app',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const MainAppPage(),
    );
  }
}
