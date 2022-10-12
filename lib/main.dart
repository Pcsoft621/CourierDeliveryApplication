import 'package:easy_go/firebase_options.dart';
import 'package:easy_go/screens/auth/company_details.dart';
import 'package:easy_go/screens/auth/otp_verify.dart';
import 'package:easy_go/screens/auth/sign_in.dart';
import 'package:easy_go/screens/auth/sign_up.dart';
import 'package:easy_go/screens/common/splash_screen.dart';
import 'package:easy_go/screens/home/home_screen.dart';
import 'package:easy_go/screens/location/chooseLocation_screen.dart';
import 'package:easy_go/screens/transporter/student_details_screen.dart';
import 'package:easy_go/util/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Easy Go',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: AppRoutes.SPLASH,
      routes: {
        AppRoutes.SPLASH: (context) => const SplashScreen(),
        AppRoutes.SIGN_IN: (context) => const SignInScreen(),
        AppRoutes.SIGN_UP: (context) => const SignUpScreen(),
        AppRoutes.OTP_VERIFY: (context) => const OtpVerifyScreen(),
        AppRoutes.COMPANY_DETAILS: (context) => const CompanyDetails(),
        AppRoutes.HOME_SCREEN: (context) => const HomeScreen(),
        AppRoutes.CHOOSELOCATION:((context) => const ChooseLocation()),
        AppRoutes.STUSENT_DETAILS:(context) => const Student_Details_Screen(),
      },
    );
  }
}
