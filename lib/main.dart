import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sketch_it/screens/home_screen.dart';
import 'package:sketch_it/screens/splash_screen.dart';
import 'package:sketch_it/screens/username/username.dart';
import 'package:sketch_it/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load();

  await Firebase.initializeApp(
      options: FirebaseOptions(
    apiKey: dotenv.env['apiKey']!,
    appId: dotenv.env['appId']!,
    messagingSenderId: dotenv.env['messagingSenderId']!,
    projectId: dotenv.env['projectId']!,
  ));

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
            home: const Mainpage(),
          );
        });
  }
}

class Mainpage extends StatelessWidget {
  const Mainpage({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore store = FirebaseFirestore.instance;

    return Scaffold(
      body: StreamBuilder<User?>(
          stream: auth.authStateChanges(),
          builder: (context, snapshot) {
            Future<String> checkdata() async {
              var collection = store.collection('username');
              final user = auth.currentUser!;

              var docSnapshot = await collection.doc(user.uid).get();

              return docSnapshot.data()!['username'];
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return const Center(
                child: Text('Something went wrong'),
              );
            }
            if (snapshot.hasData) {
              if (checkdata().isNull) {
                return const Username();
              } else {
                return const HomeScreen();
              }
            } else {
              return const SplashScreen();
            }
          }),
    );
  }
}
