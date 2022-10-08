import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_go/models/auth/new_user_info.dart';
import 'package:easy_go/util/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final userInfo = NewUserInfo();
  final List<bool> isSelected = [true, false];

  final _formKey = GlobalKey<FormState>();
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
                              FirebaseFirestore.instance
                                  .collection("users")
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
                              });
                            } else {
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
        ),
      ),
    );
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
