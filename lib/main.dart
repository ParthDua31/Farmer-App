import 'package:flutter/material.dart';
import 'welcome.dart';
import 'login.dart';
import 'signup.dart';
import 'common.dart';
import 'farmer.dart';
import 'driver.dart';
import 'farmerFinal.dart';
import 'pricePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'prevBookings.dart';
import 'setting.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: 'sign-up',
        routes: {
          'welcome' :(context)=> welcome(),
          'login' :(context)=>login(),
          'sign-up' :(context)=>sign_up(),
          'common' :(context)=>common(),
          'farmer' :(context)=>farmer(),
          'driver' :(context)=>driver(),
          'farmerFinal' :(context)=> farmerFinal(),
          'pricePage' :(context)=> pricePage(),
          'prevBookings': (context)=> prevBookings(),
          'setting' : (context)=>setting(),
        },
    );
  }
}
