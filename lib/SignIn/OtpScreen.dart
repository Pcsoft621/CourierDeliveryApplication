import 'package:deliviryapp_v1/SignIn/Phone_screen.dart';
import 'package:deliviryapp_v1/SignIn/SignIn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pinput/pinput.dart';
import 'package:deliviryapp_v1/main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OTPScreen extends StatefulWidget {
  //const OTPScreen({super.key});
  final String phone;
  const OTPScreen(this.phone);
  
  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(0),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    var code;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,color: Colors.black,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      
      ),            
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
              Pinput(
                length: 6,
                showCursor: true,
                onChanged: (value) => code=value,
              ),
              SizedBox(height:20),
              SizedBox(

                height:45 ,
                width: double.infinity,
                child: ElevatedButton(onPressed: ()async{
                  try{
                  PhoneAuthCredential credential = 
                  PhoneAuthProvider.credential(verificationId: PhoneScreen.varify, smsCode: code);
                  await auth.signInWithCredential(credential);
                  //Navigator.pushNamedAndRemoveUntil(context, 'signin', (route) => false);
                  //Navigator.push(context, SignIn_Screen());
                  Navigator.push(
                    context, MaterialPageRoute(builder: (context) => PhoneScreen()));
                  Navigator.push(
                    context, MaterialPageRoute(builder: (context) => SignIn_Screen()));
                 }
                 catch(e){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(e.toString())));
                  }
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Varify",
                      )));
                      Navigator.pushNamed(context, "otp");
                      
                }, child: Text('Varify'),
              style: ElevatedButton.styleFrom(primary: Colors.amber,
              shape:RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30)
              ) ),
              
              ),
              ),
              Row(
                children: [TextButton(
                  onPressed: (){
                    Navigator.pushNamedAndRemoveUntil(context, 'phone', (route) => false);
                  }, 
                  child: Text('Edit Phone number',
                    style: TextStyle(color: Colors.black),)),],
              )
            ],
          ),
        ),
      )    

    );
  }
}