import 'package:crud/addproduct.dart';
import 'package:crud/firebase_options.dart';
import 'package:crud/products.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // final SharedPreferences prefs = await SharedPreferences.getInstance();
  // bool isLoggedIn= prefs.getBool("isLoggedIn") ?? false;
  // bool isAdmin= prefs.getBool("isAdmin") ?? false;
  runApp(MyApp(isAdmin: false, isLoggedIn: false));
}

class MyApp extends StatelessWidget {
 final bool isLoggedIn, isAdmin ;

   MyApp({super.key,required this.isAdmin,required this.isLoggedIn});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Products(),
      // routes: {
      //   "/signup":(context)=> Signup(),
      //   "/products":(context)=>  (isLoggedIn) ? Products(): Login(),
      //   "/add":(context)=> (isLoggedIn && isAdmin) ? Addproduct(): Login(),
      //   "/login":(context)=>Login(),
      // },
    );
  }
}