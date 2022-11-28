import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_go/util/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:easy_go/models/auth/company_details.dart' as cd;
import 'package:easy_go/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:easy_go/util/firebase.dart';

class CompanyDetailsEdit extends StatefulWidget {
  const CompanyDetailsEdit({super.key});
  
  @override
  State<CompanyDetailsEdit> createState() => _CompanyDetailsEditState();
}

class _CompanyDetailsEditState extends State<CompanyDetailsEdit> {
  final nameController = TextEditingController();
  Map<String, dynamic>? user;
  final typeController = TextEditingController();
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final numberController = TextEditingController();
  final addressController = TextEditingController();
   String companyType="";
  var imageUrl = "";
  final storage = FirebaseStorage.instance;
  final companyDetails = cd.CompanyDetails();
  List specitems = [
    {"title": "Government", "value": "1"},
    {"title": "Private", "value": "2"},
    {"title": "cooperative ltd. ", "value": "3"},
    {"title": "Orgnization(school/college)", "value": "4"},
    {"title": "Other", "value": "5"},
  ];
  String ctype = "";
  
  void initState() {
    
    getD();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 12.0),
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Company Name",
                fillColor: Colors.black,
                contentPadding: const EdgeInsets.all(10),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                  Radius.circular(6.0),
                )),
              ),
              style: const TextStyle(fontSize: 17),
            ),
            const SizedBox(height: 24.0),
            TextFormField(
              controller: addressController,
              decoration: const InputDecoration(
                labelText: "Company Address",
                fillColor: Colors.black,
                contentPadding: const EdgeInsets.all(10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(6.0),
                  ),
                ),
              ),
              style: const TextStyle(fontSize: 17),
            ),
            const SizedBox(height: 24.0),
            TextFormField(
              controller: numberController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Office Number",
                fillColor: Colors.black,
                contentPadding: const EdgeInsets.all(10),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                  Radius.circular(6.0),
                )),
              ),
              style: const TextStyle(fontSize: 17),
            ),
            const SizedBox(height: 24.0),
            InputDecorator(
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                  Radius.circular(6.0),
                )),
                contentPadding: EdgeInsets.all(10),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: ctype,
                  isDense: true,
                  isExpanded: true,
                  menuMaxHeight: 400,
                  items: [
                    const DropdownMenuItem(
                      
                        child: Text(
                          "Select Company Type",
                        ),
                        value: ''),
                    ...specitems.map<DropdownMenuItem<String>>((e) {
                      return DropdownMenuItem(
                          child: Text(e['title']), value: e['title']);
                    }).toList(),
                  ],
                  onChanged: (String? newValue) {
                    setState(() {
                      ctype = newValue!;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 24.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  child: const Text("Upload Id Image",
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
                      });
                    } on PlatformException catch (e) {
                      print(e);
                    }
                  }),
            ),
            const SizedBox(height: 12.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  companyDetails.companyName = nameController.text;
                  companyDetails.companyAddress = addressController.text;
                  companyDetails.companyPhoneNumber = numberController.text;
                  companyDetails.companyType = typeController.text;
                  companyDetails.companyIdentityUrl = imageUrl;
                  UpdateCompanyDetails(companyDetails);
                  showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (context) {
                        return AlertDialog(
                          content: Row(
                            children: [
                              const CircularProgressIndicator(),
                              Container(
                                  margin: const EdgeInsets.only(left: 7),
                                  child: const Text("Saving...")),
                            ],
                          ),
                        );
                      });
                },
                child: const Text(
                  'Update',
                  style: TextStyle(fontSize: 17),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void getD() {
    
    setState(() {
      
      firestore.collection("users").doc(uid).get().then((value) {
      user = value.data();
      setState(() {
        nameController.text=
            (user!["travelDetails"] as Map<String, dynamic>)["companyName"];
        addressController.text = (user!["travelDetails"] as Map<String, dynamic>)["companyAddress"];
        numberController.text= (user!["travelDetails"] as Map<String, dynamic>)["companyPhoneNumber"];
        companyType= (user!["travelDetails"] as Map<String, dynamic>)["companyType"];
      });
    });
    });
  }

  void UpdateCompanyDetails(cd.CompanyDetails companyDetails) {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final ref = storage.ref("images/userdetails/").child("$uid/");
    final uploadTask = ref.putFile(File(imageUrl));
    uploadTask.then((p0) async {
      companyDetails.companyIdentityUrl = await p0.ref.getDownloadURL();
      FirebaseFirestore.instance.collection("users").doc(uid).update(
          {"companyDetails": companyDetails.json},
          ).then((value) {
        Navigator.pop(context);
        Navigator.popAndPushNamed(context, AppRoutes.HOME_SCREEN);
      });
    });
  }
}
