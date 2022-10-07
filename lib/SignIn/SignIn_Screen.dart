import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final firstName=TextEditingController();
  final middleName=TextEditingController();
  final lastName=TextEditingController();
  final email=TextEditingController();
  final address=TextEditingController();
  var choice;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Title(child: Text('SignIn...'),color: Colors.black,),
      ),
      body: Scaffold(
        body: Container(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                controller: firstName,
                decoration:  InputDecoration(
                  border: OutlineInputBorder(
                  borderRadius:  BorderRadius. all(
              Radius. circular(30.0),
              )
                ),
                  fillColor: Colors.black,
                  labelText: 'First Name',
                ),
              ),
               SizedBox(height: 10.0),
              TextField(
                controller: middleName,
                decoration: InputDecoration(
                  border:  OutlineInputBorder(
                  borderRadius:  BorderRadius. all(
                   Radius. circular(30.0),
                )
                ),
                  fillColor: Colors.black,
                  labelText: 'Middle Name',
                  
              ),),
               SizedBox(height: 10.0),
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
               SizedBox(height: 10.0),
              TextField(
                controller: email,
                decoration:  InputDecoration(
                  border:  OutlineInputBorder(
                  borderRadius:  BorderRadius. all(
                     Radius. circular(30.0),
                    )
                ),
                  fillColor: Colors.black,
                  labelText: 'Email',
                  suffixIcon: Icon(Icons.email),
                ),
              ),
              
              const SizedBox(height: 10.0),
              TextField(
              
                controller: address,
                decoration: const InputDecoration(
                  border:  OutlineInputBorder(
                  borderRadius:  BorderRadius. all(
                     Radius. circular(30.0),
                    )
                ),
                  fillColor: Colors.black,
                  labelText: 'Address',
                  suffixIcon: Icon(Icons.location_on_outlined),
                ),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: [
                  Radio(value: 1, groupValue: 1,
                  
                  activeColor: Colors.green,
                  onChanged: (value) => choice=value,
                  ),
                  Radio(value: 0, groupValue: 2,
                  activeColor: Colors.green,
                  onChanged: (value) => choice=value,
                  ),
                ],
              ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}