import 'package:easy_go/screens/auth/otp_verify.dart';
import 'package:easy_go/util/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String phone_no = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            TextField(
              keyboardType: TextInputType.phone,
              maxLength: 10,
              onChanged: (value) => setState(() {
                phone_no = value;
              }),
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                  Radius.circular(30.0),
                )),
                hintText: 'Enter Mobile Number',
              ),
            ),
            SizedBox(
              height: 45,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: phone_no.length != 10
                    ? null
                    : () async {
                        await FirebaseAuth.instance.verifyPhoneNumber(
                          phoneNumber: "+91" + phone_no,
                          verificationCompleted:
                              (PhoneAuthCredential credential) {},
                          verificationFailed: (FirebaseAuthException e) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                                    content: Text(
                              "Verification Failed.. Please try again..",
                            )));
                            Future.delayed(const Duration(seconds: 2), () {
                              Navigator.popAndPushNamed(
                                  context, AppRoutes.SIGN_IN);
                            });
                          },
                          codeSent: (String verificationId, int? resendToken) {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.OTP_VERIFY,
                              arguments: OtpVerifyScreenArguments(
                                verificationId,
                                resendToken: resendToken,
                              ),
                            );
                          },
                          codeAutoRetrievalTimeout: (String verificationId) {},
                        );
                        setState(() {
                          phone_no = phone_no.substring(1);
                        });
                      },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
                child: const Text('Send the OTP'),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
