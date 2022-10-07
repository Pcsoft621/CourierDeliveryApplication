import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SignIn_Screen extends StatefulWidget {
  const SignIn_Screen({super.key});

  @override
  State<SignIn_Screen> createState() => _SignIn_ScreenState();
}

class _SignIn_ScreenState extends State<SignIn_Screen> {
  
  final firstName=TextEditingController();
  final middleName=TextEditingController();
  final lastName=TextEditingController();
  final email=TextEditingController();
  final address=TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Title(child: Text('SignIn'),color: Colors.black,),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
            child:  Column(
              
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget> [
              TextField(
                
                controller: firstName,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                  borderRadius: const BorderRadius. all(
              const Radius. circular(30.0),
              )
                ),
                  fillColor: Colors.black,
                  labelText: 'First Name',
                ),
              ),
              const SizedBox(height: 10.0),
              TextField(
                controller: middleName,
                decoration: const InputDecoration(
                  border:  OutlineInputBorder(
                  borderRadius:  BorderRadius. all(
                   Radius. circular(30.0),
                )
                ),
                  fillColor: Colors.black,
                  labelText: 'Middle Name',
                  
              ),),
              const SizedBox(height: 10.0),
              TextField(
                controller: lastName,
                decoration: const InputDecoration(
                  border:  OutlineInputBorder(
                  borderRadius: BorderRadius. all(
              Radius. circular(30.0),
              )
                ),
                  fillColor: Colors.black,
                  labelText: 'Last Name',
              ),),
              const SizedBox(height: 10.0),
              TextField(
                controller: email,
                decoration: const InputDecoration(
                  border:  OutlineInputBorder(
                  borderRadius:  BorderRadius. all(
                     Radius. circular(30.0),
                    )
                ),
                  fillColor: Colors.black,
                  labelText: 'Email',
                  suffixIcon: Icon(Icons.email),
              ),),
              const SizedBox(height: 10.0),
              
              
              
              
              
              
              
              
            ],
          ),
        ),
      ),
    );
  }
}