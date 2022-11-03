import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_go/util/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:easy_go/models/auth/students_details.dart' as stu;
//import 'package:shared_preferences/shared_preferences.dart';

class Student_Details_Screen extends StatefulWidget {
  const Student_Details_Screen({super.key});

  @override
  State<Student_Details_Screen> createState() => _Student_Details_ScreenState();
}

class _Student_Details_ScreenState extends State<Student_Details_Screen> {
  final studentDetails = stu.StudentDetails();
  final rollnoController = TextEditingController();
  final clgnameController = TextEditingController();
  final clgaddrController = TextEditingController();
  final passoutController = TextEditingController();
  final storage = FirebaseStorage.instance;

  //File? image;
  String imageUrl = "";

  List specitems = [
    {"title": "H.S.C", "value": "1"},
    {"title": "B.Tech/B.E", "value": "2"},
    {"title": "B.A.", "value": "3"},
    {"title": "B.Sc", "value": "4"},
    {"title": "M.Tech", "value": "5"},
    {"title": "M.Sc", "value": "6"},
    {"title": "M.com", "value": "7"},
    {"title": "Others", "value": "8"},
  ];
  String spec = "";

  List yearitems = [
    {"title": "First Year", "value": "1"},
    {"title": "Second Year", "value": "2"},
    {"title": "Third Year", "value": "3"},
    {"title": "Final Year", "value": "4"},
  ];
  String year = "";

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
              controller: rollnoController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Enrollnment/Roll Number",
                fillColor: Colors.black,
                contentPadding: const EdgeInsets.all(10),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Colors.blueGrey, width: 2.0),
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              style: const TextStyle(fontSize: 17),
            ),
            const SizedBox(height: 12.0),
            TextFormField(
              controller: clgnameController,
              decoration: InputDecoration(
                labelText: "College Name",
                fillColor: Colors.black,
                contentPadding: const EdgeInsets.all(10),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Colors.blueGrey, width: 2.0),
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              style: const TextStyle(fontSize: 17),
            ),
            const SizedBox(height: 12.0),
            TextFormField(
              controller: clgaddrController,
              decoration: InputDecoration(
                labelText: "College Address",
                fillColor: Colors.black,
                contentPadding: const EdgeInsets.all(10),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Colors.blueGrey, width: 2.0),
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              style: const TextStyle(fontSize: 17),
            ),
            const SizedBox(height: 12.0),
            InputDecorator(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(10),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: spec,
                  isDense: true,
                  isExpanded: true,
                  menuMaxHeight: 400,
                  items: [
                    const DropdownMenuItem(
                        child: Text(
                          "Select Specilization",
                        ),
                        value: ""),
                    ...specitems.map<DropdownMenuItem<String>>((e) {
                      return DropdownMenuItem(
                          child: Text(e['title']), value: e['title']);
                    }).toList(),
                  ],
                  onChanged: (String? newValue) {
                    setState(() {
                      spec = newValue!;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            InputDecorator(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(10),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: year,
                  isDense: true,
                  isExpanded: true,
                  menuMaxHeight: 400,
                  items: [
                    const DropdownMenuItem(
                        child: Text(
                          "Select Year/Class",
                        ),
                        value: ""),
                    ...yearitems.map<DropdownMenuItem<String>>((e) {
                      return DropdownMenuItem(
                          child: Text(e['title']), value: e['title']);
                    }).toList(),
                  ],
                  onChanged: (String? newValue) {
                    setState(() {
                      year = newValue!;
                    });
                  },
                ),
              ),
            ),
            TextFormField(
              controller: passoutController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Passout Year",
                fillColor: Colors.black,
                contentPadding: const EdgeInsets.all(10),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Colors.blueGrey, width: 2.0),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                hintStyle: const TextStyle(fontSize: 17),
              ),
            ),
            const SizedBox(height: 12.0),
            const SizedBox(height: 12.0),
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
            ElevatedButton(
              onPressed: () {
                studentDetails.collegeAddress = clgaddrController.text;
                studentDetails.collegeName = clgnameController.text;
                studentDetails.rollNo = rollnoController.text;
                studentDetails.year = year;
                studentDetails.specilization = spec;
                studentDetails.studentIdentityUrl = imageUrl;
                saveStudentDetails(studentDetails);
                /*showDialog(
                         context: context,
                         builder: (context) {
                        return AlertDialog(
                              content: Text( rollnoController.text + " "+
                              clgnameController.text+" " + ""+" "+
                               spec +" "+year),
                        );
                      },
                   );*/
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
                'SAVE',
                style: TextStyle(fontSize: 17),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void saveStudentDetails(stu.StudentDetails companyDetails) {
    isstudent();
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final ref = storage.ref("images/studentdetails/").child("$uid/");
    final uploadTask = ref.putFile(File(imageUrl));
    uploadTask.then((p0) async {
      studentDetails.studentIdentityUrl = await p0.ref.getDownloadURL();
      FirebaseFirestore.instance.collection("users").doc(uid).set(
          {"studentDetails": studentDetails.json},
          SetOptions(merge: true)).then((value) {
        Navigator.pop(context);
        Navigator.popAndPushNamed(context, AppRoutes.HOME_SCREEN);
      });
    });
  }

  void isstudent() {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final data = {"isStudent": true};
    FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .set(data, SetOptions(merge: true))
        .onError((error, stackTrace) => print(error));
  }
}
