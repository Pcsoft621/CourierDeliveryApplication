import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PhoneScreen extends StatefulWidget {
  const PhoneScreen({super.key});
  static String varify="";
  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  final phone_controller=TextEditingController();
  var phone_no;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding:const EdgeInsets.all(20) ,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/phone_authentication.png',
              width: 150,
              height: 150,
              ),
              const Text('Phone Varification',style: TextStyle(
                fontSize: 22,fontWeight: FontWeight.bold),),
              const SizedBox(height: 10,),
              const Text('We need to register your phone before gettnig started',
                style: TextStyle(
                fontSize: 16,),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height:30),
               TextField(
                keyboardType: TextInputType.phone,
                maxLength: 10,
                onChanged: (value) => phone_no=value,
                controller: phone_controller,
                decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: const BorderRadius. all(
              const Radius. circular(30.0),
              )
                ),
                
                hintText: 'Enter Mobile Number',
            ),
          ),
              SizedBox(
                
                height:45 ,
                width: double.infinity,
                child: ElevatedButton(onPressed: ()async{
                  await FirebaseAuth.instance.verifyPhoneNumber(
                    phoneNumber: '${"+919359315369"}',
                    verificationCompleted: (PhoneAuthCredential credential) {},
                    verificationFailed: (FirebaseAuthException e) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Failed",
                      )));    
                    },
                    codeSent: (String verificationId, int? resendToken) {
                      PhoneScreen.varify=verificationId;
                    },
                    codeAutoRetrievalTimeout: (String verificationId) {},
);

                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(phone_controller.text,
                      )));
                     Navigator.pushNamed(context, "otp");
                }, 
                child: Text('Send the OTP'),
              style: ElevatedButton.styleFrom(primary: Colors.amber,
              shape:RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)
              ) ),
              
              ),
              )
            ],
          ),
        ),
      )   
       );
  }
}