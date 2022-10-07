// ignore: file_names
// ignore_for_file: avoid_print


import 'dart:io';
// ignore: import_of_legacy_library_into_null_safe
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
class Student extends StatefulWidget {
  const Student({ Key? key }) : super(key: key);
  
  @override
  State<Student> createState() => _StudentState();
}

class _StudentState extends State<Student> {
  final studnameController=TextEditingController();
  final ageController=TextEditingController();
  final rollnoController=TextEditingController();
  final clgnameController=TextEditingController();
  final clgaddrController=TextEditingController();
  final passoutController=TextEditingController();
  
  File? image;
  final String _imagepath="";
  Future pickImage() async{
    try{
      final image=await ImagePicker().pickImage(source:ImageSource.gallery);
      if(image==null) return;
      final imageTemp=File(image.path);
      setState(() => this.image=imageTemp);
    } on PlatformException catch(e)
    {
      print(e);
    }
  }

void saveImage(path) async{
{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('name', ((path != null) ? path : ""));

}
}
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
          TextFormField(
            controller: studnameController,
            decoration: InputDecoration(
              labelText: "Student Name",
              fillColor: Colors.black,
              contentPadding: const EdgeInsets.all(10),
              focusedBorder:OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.blueGrey, width: 2.0),
              borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            style: const TextStyle(fontSize: 17),
          ),
          const SizedBox(height:12.0),

          TextFormField(
            controller: ageController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Student Age",
              fillColor: Colors.black,
              contentPadding: const EdgeInsets.all(10),
              focusedBorder:OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.blueGrey, width: 2.0),
              borderRadius: BorderRadius.circular(5.0),
              ),
              hintStyle: const TextStyle(fontSize: 17),
            ),
          ),
          const SizedBox(height:12.0),

          TextFormField(
            controller: rollnoController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Enrollnment/Roll Number",
              fillColor: Colors.black,
              contentPadding: const EdgeInsets.all(10),
              focusedBorder:OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.blueGrey, width: 2.0),
              borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            style: const TextStyle(fontSize: 17),
          ),
          const SizedBox(height:12.0),

          TextFormField(
            controller: clgnameController,
            decoration: InputDecoration(
              labelText: "College Name",
              fillColor: Colors.black,
              contentPadding: const EdgeInsets.all(10),
              focusedBorder:OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.blueGrey, width: 2.0),
              borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            style: const TextStyle(fontSize: 17),
          ),
          const SizedBox(height:12.0),

          TextFormField(
            controller: clgaddrController,
            decoration: InputDecoration(
              labelText: "College Address",
              fillColor: Colors.black,
              contentPadding: const EdgeInsets.all(10),
              focusedBorder:OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.blueGrey, width: 2.0),
              borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            style: const TextStyle(fontSize: 17),
          ),
          const SizedBox(height:12.0),
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
                        child: Text("Select Specilization",),
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
        

             const SizedBox(height:10.0),
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
                        child: Text("Select Year/Class",),
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
              focusedBorder:OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.blueGrey, width: 2.0),
              borderRadius: BorderRadius.circular(5.0),
              ),
              hintStyle: const TextStyle(fontSize: 17),
            ),
          ),
          const SizedBox(height:12.0),


            const SizedBox(height:12.0),

            const Text(
                "Student ID Card:",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 16),
           ),
           const SizedBox(height:12.0),
            MaterialButton( 
            child: const Text("Upload Id Card",
            style: TextStyle(color: Color.fromARGB(255, 56, 153, 201), fontWeight: FontWeight.bold, fontSize: 17, backgroundColor: Color.fromARGB(255, 221, 233, 236))),
            shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(30.0)),
            onPressed: (){
                  pickImage();
            }
            ), 
            const SizedBox(height:12.0),
            image!=null ? Image.file(image!): const Text("No image Selected"),
            const SizedBox(height:12.0),

             ElevatedButton(
                     onPressed: () {
                     saveImage(_imagepath);
                },
                child: const Text(
                'Save Iamge',
                style: TextStyle(fontSize: 15),
                 ),
              ),

            


            const SizedBox(height:12.0),
            ElevatedButton(
                     onPressed: () {
                     showDialog(
                         context: context,
                         builder: (context) {
                        return AlertDialog(
                              content: Text(studnameController.text +" "+ ageController.text +" "+ rollnoController.text + " "+
                              clgnameController.text+" " + clgaddrController.text+" "+ spec +" "+year),
                        );
                      },
                   );
                },
                child: const Text(
                'SUBMIT',
                style: TextStyle(fontSize: 17),
                 ),
              ),
          ],
       ),
    ),
    );
    
  }
 
} 