// ignore_for_file: unused_field

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
// ignore: import_of_legacy_library_into_null_safe
import 'package:shared_preferences/shared_preferences.dart';

class Company extends StatefulWidget {
  const Company({ Key? key }) : super(key: key);
 
  
  @override
  State<Company> createState() => _CompanyState();
}


class _CompanyState extends State<Company> {
  //@override
final nameController=TextEditingController();
final typeController=TextEditingController();
final numberController=TextEditingController();
final addressController=TextEditingController();




List specitems = [
    {"title": "Government", "value": "1"},
    {"title": "Private", "value": "2"},
    {"title": "cooperative ltd. ","value": "3"},
    {"title":  "Orgnization(school/college)","value": "4"},
    {"title": "Other", "value": "5"},
  ];
  String ctype = "";
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('CompanyDetails'),),
        body: SingleChildScrollView(  
    padding: const EdgeInsets.all(20),
     child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[ 
          TextFormField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: "Company Name",
              fillColor: Colors.black,
              contentPadding: const EdgeInsets.all(10),
              border:OutlineInputBorder(
                  borderRadius:  BorderRadius. all(
              Radius. circular(20.0),
              )
                ),
            ),
            style: const TextStyle(fontSize: 17),
          ), 
          const SizedBox(height:12.0),
          TextFormField(
            controller: addressController,
            decoration: InputDecoration(
              labelText: "Company Address",
              fillColor: Colors.black,
              contentPadding: const EdgeInsets.all(10),
              border:OutlineInputBorder(
                  borderRadius:  BorderRadius. all(
              Radius. circular(20.0),
              )
                ),
            ),
            style: const TextStyle(fontSize: 17),
          ),
          const SizedBox(height:12.0),
          TextFormField(
            controller: numberController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Office Number",
              fillColor: Colors.black,
              contentPadding: const EdgeInsets.all(10),
              border:OutlineInputBorder(
              borderRadius:  BorderRadius. all(
              Radius. circular(30.0),
              )
              ),
            ),
            style: const TextStyle(fontSize: 17),
          ),
          const SizedBox(height:14.0),
          InputDecorator(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
              borderRadius:  BorderRadius. all(
              Radius. circular(30.0),
              )
              ),
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
                        child: Text("Select Company Type",),
                        value: ""),
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
        

            const SizedBox(height:12.0),
            
            SizedBox(
              width: double.infinity,
              child: ElevatedButton( 
            child:  Text("Upload Id Image",
            style: TextStyle(color: Color.fromARGB(255, 244, 246, 247), fontWeight: FontWeight.bold, fontSize: 17)),
            //shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(30.0)),
            onPressed: ()async{
                  final results = FilePicker.platform.pickFiles(
                    allowMultiple: false,
                    type: FileType.custom,
                    allowedExtensions: ['png','jpg'],
                  );
                  if(results==null){
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("No file Selected"),
                        ),
                    );
                    return null;
                  }
                  
                  final path=results.files.sinle.path;
                  final fileName=results.files.single.name;
                print(path);
            }
            ),
            ), 

            const SizedBox(height:12.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                     onPressed: () {
                     showDialog(
                         context: context,
                         builder: (context) {
                        return AlertDialog(
                              content: Text(nameController.text +" "+ addressController.text +" "+ numberController.text +" "+ ctype),
                        );
                      },
                   );
                },
                child: const Text(
                'SUBMIT',
                style: TextStyle(fontSize: 17),
                 ),
              ),
            )
     ], 
     ),
    ),
    );
  }
}


