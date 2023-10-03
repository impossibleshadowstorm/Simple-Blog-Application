import 'package:blog_app/controllers/main_application_controller.dart';
import 'package:blog_app/services/global.dart';
import 'package:blog_app/views/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

Future<void> main() async {
  await Global.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final mainApplicationController = Get.put(MainApplicationController());

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (orientation, type, context) {
      return GetMaterialApp(
        title: 'Blog App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      );
    });
  }
}
