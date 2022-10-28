import 'package:easy_go/screens/consumer/reciversList_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:easy_go/models/auth/courier_details.dart' as c;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:easy_go/models/auth/company_details.dart' as cd;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_go/util/routes.dart';

class CourierDetails extends StatefulWidget {
  const CourierDetails({super.key});

  @override
  State<CourierDetails> createState() => _Courier_DetailsState();
}

class _Courier_DetailsState extends State<CourierDetails> {
  @override
  final storage = FirebaseStorage.instance;
  final courierDetails = c.Courier_Details();
  final productName = TextEditingController();
  final productWeight = TextEditingController();
  final locationFrom = TextEditingController();
  final locationTo = TextEditingController();
  final productReceiver = TextEditingController();
  final productCharges = TextEditingController();
  final productDescription = TextEditingController();
  String courierReciverName = "";
  String imageUrl = "";
  List type = [
    {"title": "Box", "value": "1"},
    {"title": "Bag", "value": "2"},
    {"title": "Document", "value": "3"},
    {"title": "Other", "value": "4"},
  ];
  String couriertype = "";

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Post Courier Deatails'),),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Material(
              elevation: 4.0,
              shadowColor: Colors.grey,
              child: TextField(
                controller: productName,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  fillColor: Colors.black,
                  labelText: 'Courier Name',
                ),
              ),
            ),
            const SizedBox(height: 12.0),
            Material(
              elevation: 4.0,
              shadowColor: Colors.grey,
              child: InputDecorator(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.all(10),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: couriertype,
                    isDense: true,
                    isExpanded: true,
                    menuMaxHeight: 400,
                    items: [
                      const DropdownMenuItem(
                          child: Text(
                            "Select Courier Type",
                            style: TextStyle(
                                color: Color.fromARGB(255, 119, 118, 118)),
                          ),
                          value: ""),
                      ...type.map<DropdownMenuItem<String>>((e) {
                        return DropdownMenuItem(
                            child: Text(e['title']), value: e['title']);
                      }).toList(),
                    ],
                    onChanged: (String? newValue) {
                      setState(() {
                        couriertype = newValue!;
                      });
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Material(
              elevation: 4.0,
              shadowColor: Colors.grey,
              child: TextField(
                keyboardType: TextInputType.number,
                controller: productWeight,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  fillColor: Colors.black,
                  labelText: 'Courier Weight',
                ),
              ),
            ),
            const SizedBox(height: 12.0),
            Material(
              elevation: 4.0,
              shadowColor: Colors.grey,
              child: TextField(
                keyboardType: TextInputType.number,
                controller: productCharges,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  fillColor: Colors.black,
                  labelText: 'Max. Affordable Charges (Rs.)',
                ),
              ),
            ),
            const SizedBox(height: 12.0),
            Material(
              elevation: 4.0,
              shadowColor: Colors.grey,
              child: TextField(
                controller: locationFrom,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  fillColor: Colors.black,
                  labelText: 'Location From:',
                ),
              ),
            ),
            const SizedBox(height: 12.0),
            Material(
              elevation: 4.0,
              shadowColor: Colors.grey,
              child: Text(
                courierReciverName
              ),
            ),
            const SizedBox(height: 12.0),
            Material(
              elevation: 4.0,
              shadowColor: Colors.grey,
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    child: const Text("Choose Reciver",
                        style: TextStyle(
                            color: Color.fromARGB(255, 241, 242, 243),
                            fontWeight: FontWeight.bold,
                            fontSize: 15)),
                    onPressed: () async {
                      final user = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ReciversList(),
                          )) as Map<String, dynamic>;
                          setState(() {
                            courierReciverName=user["uid"];
                          });
                    }),
              ),
            ),
            const SizedBox(height: 12.0),
            Material(
              elevation: 4.0,
              shadowColor: Colors.grey,
              child: TextField(
                controller: locationTo,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  fillColor: Colors.black,
                  labelText: 'Choosed Reciver:',
                ),
              ),
            ),
            const SizedBox(height: 12.0),
            Material(
              elevation: 4.0,
              shadowColor: Colors.grey,
              child: TextFormField(
                controller: productDescription,
                minLines: 3,
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                    hintText: 'Courier Description (Optional)',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    )),
              ),
            ),
            const SizedBox(height: 12.0),
            Material(
              elevation: 4.0,
              shadowColor: Colors.grey,
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    child: const Text("Upload Product Image",
                        style: TextStyle(
                            color: Color.fromARGB(255, 241, 242, 243),
                            fontWeight: FontWeight.bold,
                            fontSize: 15)),
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
            ),
            const SizedBox(height: 12.0),
            Material(
              elevation: 4.0,
              shadowColor: Colors.grey,
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    courierDetails.courierName = productName.text;
                    courierDetails.courierWeight = productWeight.text;
                    courierDetails.courierImageUrl = imageUrl;
                    courierDetails.courierCharges = productCharges.text;
                    courierDetails.courierType = couriertype;
                    courierDetails.courierReceiver = courierReciverName;
                    courierDetails.locationFrom = locationFrom.text;
                    courierDetails.locationTo = locationTo.text;
                    courierDetails.courierDescription = productDescription.text;
                    saveCourierDetails(courierDetails);
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Text(productName.text +
                              " " +
                              couriertype +
                              " " +
                              productWeight.text +
                              " " +
                              productCharges.text +
                              " " +
                              locationFrom.text +
                              " " +
                              locationTo.text +
                              " " +
                              productReceiver.text +
                              " " +
                              productDescription.text),
                        );
                      },
                    );
                  },
                  child: const Text(
                    'SUBMIT',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void saveCourierDetails(c.Courier_Details courierDetails) {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final ref = storage.ref("images/courierdetails/").child("$uid/");
    final uploadTask = ref.putFile(File(imageUrl));
    uploadTask.then((p0) async {
      courierDetails.courierImageUrl = await p0.ref.getDownloadURL();
      FirebaseFirestore.instance.collection("courier").doc(uid).set(
          {"courierDetails": courierDetails.json},
          SetOptions(merge: true)).then((value) {
        Navigator.pop(context);
        Navigator.popAndPushNamed(context, AppRoutes.HOME_SCREEN);
      });
    });
  }
}
