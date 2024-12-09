import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:test_prep/modules/gateway/v_gateway_page.dart';

import '_common/data/data_controller.dart';
import '_services/c_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.delayed(const Duration(seconds: 1));
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    injectDependencies();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Test Prep',
      useInheritedMediaQuery: true,
      locale: const Locale('en', 'EN'),
      fallbackLocale: const Locale('en', 'US'),
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const GatewayPage(),
    );
  }

  void injectDependencies() {
    Get.put(DataController());
    Get.put(ThemeController());
  }
}
