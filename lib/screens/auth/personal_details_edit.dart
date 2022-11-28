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
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_go/util/firebase.dart';
class PersonalInfoEdit extends StatefulWidget {
  const PersonalInfoEdit({super.key});

  @override
  State<PersonalInfoEdit> createState() => _PersonalInfoEditState();
}

class _PersonalInfoEditState extends State<PersonalInfoEdit> {
  final userInfo = u.NewUserInfo();
  Map<String, dynamic>? user;
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final List<bool> isSelected = [true, false];
  var imageUrl = "";
  
  var profileImageUrl="";
  final _formKey = GlobalKey<FormState>();
  final storage = FirebaseStorage.instance;
  String s="";
  final firstNameController=TextEditingController() ;
  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      getCurrentUserDetails();
    
    super.initState();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
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
                    controller: firstNameController,
                    onChanged: (value) => userInfo.firstName = value,
                    autofillHints: [AutofillHints.givenName],
                    decoration:  InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(6.0),
                        ),
                      ),
                      fillColor: Colors.black,
                      labelText:userInfo.firstName,
                      
                    ),
                  ),
                  //Text(userInfo.firstName),


                  const SizedBox(height: 10.0),
                  TextFormField(
                    
                    onChanged: (value) => userInfo.middleName = value,
                    autofillHints: [AutofillHints.middleName],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                        Radius.circular(6.0),
                      )),
                      fillColor: Colors.black,
                      labelText: userInfo.middleName,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  TextFormField(
                    
                    onChanged: (value) => userInfo.lastName = value,
                    keyboardType: TextInputType.name,
                    autofillHints: [AutofillHints.familyName],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                        Radius.circular(6.0),
                      )),
                      fillColor: Colors.black,
                      labelText: userInfo.lastName,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  TextFormField(
                    onChanged: (value) => userInfo.email = value,
                    keyboardType: TextInputType.emailAddress,
                    autofillHints: [AutofillHints.email],
                    validator: validateEmail,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                        Radius.circular(6.0),
                      )),
                      fillColor: Colors.black,
                      labelText: userInfo.email,
                      suffixIcon: Icon(Icons.email),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  TextFormField(
                  
                    validator: (value) {
                      return value != null && value.isEmpty
                          ? "Required Field"
                          : null;
                    },
                    onChanged: (value) => userInfo.address = value,
                    autofillHints: [AutofillHints.postalAddress],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                        Radius.circular(6.0),
                      )),
                      fillColor: Colors.black,
                      labelText: userInfo.address,
                      suffixIcon: Icon(Icons.location_on_outlined),
                    ),
                  ),
                
                  const SizedBox(height: 10.0),
                  TextFormField(
                    validator: (value) {
                      return value != null && value.isEmpty&& value.length<12
                          ? "Required 10 digit mobile No"
                          : null;
                    },
                    maxLength: 10,
                    
                    onChanged: (value) => userInfo.adharNo = value,
                    keyboardType: TextInputType.number,
                    autofillHints: [AutofillHints.birthday],
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                        Radius.circular(6.0),
                      )),
                      fillColor: Colors.black,
                      labelText: 'Contact No',
                    ),
                  ),
                  /******************** */
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                    child: const Text("Change Aadhar Image",
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
                const SizedBox(height: 10.0),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                    child: const Text("Change Profile Image",
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
                  
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            save(userInfo);
                            /*if (userInfo.isValid &&
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
                                  
                            } else {
                              //s=s+userInfo.isValid.toString();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Please fill out all fields",
                                  ),
                                ),
                              );
                            }*/
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
      //update
      //FirebaseFirestore.instance.collection('users').doc(
        //FirebaseAuth.instance.currentUser!.uid).
        //set(userInfo,SetOptions(merge: true));

      //save
     /* FirebaseFirestore.instance.collection("users").
      doc(FirebaseAuth.instance.currentUser!.uid).set(
          userInfo.json,
          SetOptions(merge: true)).then((value) {
        if (userInfo.isTransporter) {
                                  Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      AppRoutes.TRANSPORTER_NEXT_DETAILS,
                                      (route) => false);
                                } else {
                                  Navigator.pushNamedAndRemoveUntil(
                                      context,
                                      AppRoutes.HOME_SCREEN,
                                      (route) => false);
                                }
      });*/
    });


   

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
  void getCurrentUserDetails()
  {
   setState(() {
    firestore.collection("users").doc(uid).get().then((value) {
      user = value.data();
      setState(() {
        
        userInfo.firstName= user!["firstName"];
        userInfo.lastName=user!["lastName"];
        userInfo.middleName=user!["middleName"];
        userInfo.email =user!["email"];
        userInfo.address=user!["address"];
        profileImageUrl=user!["profileUrl"];
        
      });
    });
     
   });
    

  }
}
