import 'package:demoapp/screens/customerhome.dart';
import 'package:demoapp/screens/simplemap.dart';
import 'package:demoapp/screens/splashscreen.dart';
import 'package:demoapp/server/checker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  bool? isCustomer = Checker().isCustomer;
  runApp(MyApp(iscustomer: isCustomer));
}

class MyApp extends StatelessWidget{

  bool? iscustomer;
  MyApp({super.key, required this.iscustomer});

  @override 
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      home: SplashScreen(iscustomer: iscustomer),
    );
  }
}