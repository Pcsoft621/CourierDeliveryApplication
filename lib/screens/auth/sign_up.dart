import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_go/models/auth/new_user_info.dart'  as u;
import 'package:easy_go/util/routes.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_go/util/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final userInfo = u.NewUserInfo();
  final List<bool> isSelected = [true, false];
  var imageUrl = "";
  var profileImageUrl="";
  final _formKey = GlobalKey<FormState>();
  final storage = FirebaseStorage.instance;
  String s="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Title(
          child: Text('SignIn...'),
          color: Colors.black,
        ),
      ),
      body: Scaffold(
        body: Container(
          padding: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    validator: (value) {
                      return value != null && value.isEmpty
                          ? "Required Field"
                          : null;
                    },
                    onChanged: (value) => userInfo.firstName = value,
                    autofillHints: [AutofillHints.givenName],
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(6.0),
                        ),
                      ),
                      fillColor: Colors.black,
                      labelText: 'First Name',
                    ),
                  ),
                  const SizedBox(height: 40.0),
                  TextFormField(
                    validator: (value) {
                      return value != null && value.isEmpty
                          ? "Required Field"
                          : null;
                    },
                    onChanged: (value) => userInfo.middleName = value,
                    autofillHints: [AutofillHints.middleName],
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                        Radius.circular(6.0),
                      )),
                      fillColor: Colors.black,
                      labelText: 'Middle Name',
                    ),
                  ),
                  const SizedBox(height: 40.0),
                  TextFormField(
                    validator: (value) {
                      return value != null && value.isEmpty
                          ? "Required Field"
                          : null;
                    },
                    onChanged: (value) => userInfo.lastName = value,
                    keyboardType: TextInputType.name,
                    autofillHints: [AutofillHints.familyName],
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                        Radius.circular(6.0),
                      )),
                      fillColor: Colors.black,
                      labelText: 'Last Name',
                    ),
                  ),
                  const SizedBox(height: 40.0),
                  TextFormField(
                    onChanged: (value) => userInfo.email = value,
                    keyboardType: TextInputType.emailAddress,
                    autofillHints: [AutofillHints.email],
                    validator: validateEmail,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                        Radius.circular(6.0),
                      )),
                      fillColor: Colors.black,
                      labelText: 'Email',
                      suffixIcon: Icon(Icons.email),
                    ),
                  ),
                  const SizedBox(height: 40.0),
                  TextFormField(
                    validator: (value) {
                      return value != null && value.isEmpty
                          ? "Required Field"
                          : null;
                    },
                    onChanged: (value) => userInfo.address = value,
                    autofillHints: [AutofillHints.postalAddress],
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                        Radius.circular(6.0),
                      )),
                      fillColor: Colors.black,
                      labelText: 'Address',
                      suffixIcon: Icon(Icons.location_on_outlined),
                    ),
                  ),
                
                  const SizedBox(height: 40.0),
                  TextFormField(
                    validator: (value) {
                      return value != null && value.isEmpty
                          ? "Required Field"
                          : null;
                    },
                    onChanged: (value) => userInfo.adharNo = value,
                    keyboardType: TextInputType.number,
                    autofillHints: [AutofillHints.birthday],
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                        Radius.circular(6.0),
                      )),
                      fillColor: Colors.black,
                      labelText: 'Adhar No',
                    ),
                  ),
                  /******************** */
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                    child: const Text("Upload Aadhar Image",
                      style: TextStyle(
                          color: Color.fromARGB(255, 244, 246, 247),
                          fontWeight: FontWeight.bold,
                          fontSize: 17)),
                      onPressed: () async {
                      try {
                        final image = await ImagePicker().pickImage(
                        source: ImageSource.gallery,
                        maxHeight: 400,
                        maxWidth: 400);
                        if (image == null) return;
                        setState(() {
                        imageUrl = image.path;
                        userInfo.adharUrl=image.path;
                        });
                      } on PlatformException catch (e) {
                        print(e);
                      }
                  }),
                ),
                const SizedBox(height: 40.0),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                    child: const Text("Upload Profile Image",
                      style: TextStyle(
                          color: Color.fromARGB(255, 244, 246, 247),
                          fontWeight: FontWeight.bold,
                          fontSize: 17)),
                      onPressed: () async {
                      try {
                        final image = await ImagePicker().pickImage(
                        source: ImageSource.gallery,
                        maxHeight: 400,
                        maxWidth: 400);
                        if (image == null) return;
                        setState(() {
                          userInfo.profileUrl= image.path;
                        profileImageUrl = image.path;
                        //userInfo.adharUrl=image.path;
                        });
                      } on PlatformException catch (e) {
                        print(e);
                      }
                  }),
                ),
                  const SizedBox(height: 40.0),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                    ),
                    // padding: const EdgeInsets.all(6),
                    child: ToggleButtons(
                      fillColor: Theme.of(context).secondaryHeaderColor,
                      selectedColor: Theme.of(context).primaryColor,
                      selectedBorderColor: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(20),
                      onPressed: (int index) {
                        setState(() {
                          for (int i = 0; i < isSelected.length; i++) {
                            isSelected[i] = i == index;
                          }
                          userInfo.isTransporter = index == 1;
                        });
                      },
                      isSelected: isSelected,
                      children: const <Widget>[
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            'Consumer',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            'Transporter',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            if(userInfo.isValid)
                            {
                              //final var v= imageUrl;
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                "valid jiii"      
                                  ),
                                ),
                              );
                            }
                            if (userInfo.isValid &&
                                _formKey.currentState!.validate()) {
                              showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) {
                                    return AlertDialog(
                                      content: Row(
                                        children: [
                                          const CircularProgressIndicator(),
                                          Container(
                                              margin: const EdgeInsets.only(
                                                  left: 7),
                                              child: const Text("Saving...")),
                                        ],
                                      ),
                                    );
                                  });
                                  //here was that
                                  save(userInfo);
                            } else {
                              //s=s+userInfo.isValid.toString();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Please fill out all fields",
                                  ),
                                ),
                              );
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              "Next",
                              style: TextStyle(fontSize: 20),
                            ),
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ),
          )
        ),
      ),
    );
  }


  save(u.NewUserInfo u)
  {

    final uid = FirebaseAuth.instance.currentUser!.uid;
    final ref1 = storage.ref("images/adhardetails/").child("$uid/");
    final uploadTask1= ref1.putFile(File(imageUrl));
    uploadTask1.then((p0) async {
      u.adharUrl = await p0.ref.getDownloadURL();
      
    });
    final ref = storage.ref("images/userprofiledetails/").child("$uid/");
    final uploadTask = ref.putFile(File(profileImageUrl));
    uploadTask.then((p0) async {
      u.profileUrl = await p0.ref.getDownloadURL();
      FirebaseFirestore.instance.collection("users").
      doc(FirebaseAuth.instance.currentUser!.uid).set(
          userInfo.json,
          SetOptions(merge: true)).then((value) {
        if (userInfo.isTransporter) {
                                  Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      AppRoutes.COMPANY_DETAILS,
                                      (route) => false);
                                } else {
                                  Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      AppRoutes.HOME_SCREEN,
                                      (route) => false);
                                }
      });
    });


    /*
    FirebaseFirestore.instance.collection("users")
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .set(userInfo.json, SetOptions(merge: true))
                                  .then((value) {
                                if (userInfo.isTransporter) {
                                  Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      AppRoutes.COMPANY_DETAILS,
                                      (route) => false);
                                } else {
                                  Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      AppRoutes.CONSUMER_DETAILS,
                                      (route) => false);
                                }
                              });*/

  }

  String? validateEmail(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty || !regex.hasMatch(value)) {
      return 'Enter a valid email address';
    } else {
      return null;
    }
  }
}
