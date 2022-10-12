import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_go/util/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() {
    Future.delayed(const Duration(seconds: 4), () {
      final firestore = FirebaseFirestore.instance;
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        Navigator.popAndPushNamed(context, AppRoutes.SIGN_IN);
      } else {
        firestore.collection("users").doc(user.uid).get().then((value) {
          if (value.exists) {
            Navigator.popAndPushNamed(context, AppRoutes.HOME_SCREEN);
          } else {
            Navigator.popAndPushNamed(context, AppRoutes.SIGN_UP);
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        
        children: [
          Image.asset(
            'assets/images/splas_screen_gif.gif',
            width: 400,
          )
        ],
      ),
    );
  }
}
