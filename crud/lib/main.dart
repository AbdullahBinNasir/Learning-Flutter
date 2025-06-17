import 'package:crud/addproduct.dart';
import 'package:crud/firebase_options.dart';
import 'package:crud/login.dart';
import 'package:crud/logout.dart';
import 'package:crud/products.dart';
import 'package:crud/signup.dart';
import 'package:crud/splashScreen.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      // theme: ThemeData(

      //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      //   useMaterial3: true,
      // ),
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: SplashScreen(),
      routes: {
        "/signup": (context) => Signup(),
        "/products": (context) => Products(),
        "/add": (context) => Addproduct(),
        "/login": (context) => Login(),
        // "/logout": (context) => Logout(),
      },
    );
  }
}
