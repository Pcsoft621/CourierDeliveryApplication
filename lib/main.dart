import 'package:easy_go/firebase_options.dart';
import 'package:easy_go/screens/auth/company_details.dart';
import 'package:easy_go/screens/auth/otp_verify.dart';
import 'package:easy_go/screens/auth/sign_in.dart';
import 'package:easy_go/screens/auth/sign_up.dart';
import 'package:easy_go/screens/common/splash_screen.dart';
import 'package:easy_go/screens/home/home_screen.dart';
import 'package:easy_go/screens/user/transporter_details_form.dart';
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
      title: 'Easy Go',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: AppRoutes.transporterDetails,
      routes: {
        AppRoutes.splash: (context) => const SplashScreen(),
        AppRoutes.signIn: (context) => const SignInScreen(),
        AppRoutes.signUp: (context) => const SignUpScreen(),
        AppRoutes.otpVerify: (context) => const OtpVerifyScreen(),
        AppRoutes.transporterDetails: (context) =>
            const TransporterDetailsForm(),
        AppRoutes.home: (context) => const HomeScreen(),
      },
    );
  }
}
