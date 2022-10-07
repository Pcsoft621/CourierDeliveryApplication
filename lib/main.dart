//import 'dart:js';
import 'package:deliviryapp_v1/SignIn/SignIn.dart';

import 'SignIn/OtpScreen.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'SignIn/Phone_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'phone',
    routes: {
      'phone':(context) => PhoneScreen(),
      'otp':(context) => OTPScreen('12'),
      'signin':(context) => SignIn_Screen(),
    },
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Easy_Go',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomPage(),
    );
  }
  
}
class HomPage extends StatefulWidget {
  const HomPage({super.key});

  @override
  State<HomPage> createState() => _HomPageState();
}

class _HomPageState extends State<HomPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        
    );
  }
}



class SpplashScreen extends StatefulWidget {
  const SpplashScreen({super.key});

  @override
  State<SpplashScreen> createState() => _SpplashScreenState();
}

class _SpplashScreenState extends State<SpplashScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() {
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => OTPScreen("phone"),
        ),
        (route) => true,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/splas_screen_gif.gif',
            width: 400,
          )
        ],
      ),
    );
  }
}
