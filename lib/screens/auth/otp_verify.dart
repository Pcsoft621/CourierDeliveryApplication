import 'package:easy_go/util/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class OtpVerifyScreen extends StatefulWidget {
  const OtpVerifyScreen({super.key});

  @override
  State<OtpVerifyScreen> createState() => _OtpVerifyScreenState();
}

class _OtpVerifyScreenState extends State<OtpVerifyScreen> {
  String code = "";

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as OtpVerifyScreenArguments;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/phone_authentication.png',
                  width: 150,
                  height: 150,
                ),
                const Text(
                  'Phone Varification',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'We need to register your phone before gettnig started',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                Pinput(
                  length: 6,
                  showCursor: true,
                  onChanged: (value) => setState(() {
                    code = value;
                  }),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 45,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: code.length != 6
                        ? null
                        : () async {
                            try {
                              PhoneAuthCredential credential =
                                  PhoneAuthProvider.credential(
                                      verificationId: args.verificationId,
                                      smsCode: code);
                              FirebaseAuth.instance
                                  .signInWithCredential(credential)
                                  .then((value) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text("Otp Verification Successful"),
                                  ),
                                );
                                if (value.additionalUserInfo != null &&
                                    value.additionalUserInfo!.isNewUser) {
                                  Navigator.pushNamedAndRemoveUntil(context,
                                      AppRoutes.SIGN_UP, (route) => false);
                                } else {
                                  Navigator.pushNamedAndRemoveUntil(context,
                                      AppRoutes.SPLASH, (route) => false);
                                }
                              });
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(e.toString())));
                            }
                          },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30))),
                    child: const Text('Verify'),
                  ),
                ),
                Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Edit Phone number',
                          style: TextStyle(color: Colors.black),
                        )),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}

class OtpVerifyScreenArguments {
  final String verificationId;
  int? resendToken;

  OtpVerifyScreenArguments(this.verificationId, {this.resendToken});
}
