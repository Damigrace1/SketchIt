import 'package:flutter/material.dart';
import 'package:sketch_it/screens/splash_screen.dart';

void main() {
  runApp(const SketchItApp());
}

class SketchItApp extends StatelessWidget {
  const SketchItApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
    );
  }
}

