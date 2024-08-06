import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:sketch_it/screens/splash_screen.dart';
import 'package:sketch_it/utils/colors.dart';

void main() {
  runApp(const SketchItApp());
}

class SketchItApp extends StatelessWidget {
  const SketchItApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(393, 852),
        builder: (_, child) {
          return GetMaterialApp(
            title: 'Tap Card',
            theme: ThemeData(colorSchemeSeed: kPrimary),
            debugShowCheckedModeBanner: false,
            home: const SplashScreen(),
          );
        });
  }
}

