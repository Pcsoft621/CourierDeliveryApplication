import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:easy_go/models/auth/students_details.dart' as stu;
import 'package:easy_go/storage/Storage.dart' as storg;

class ReciversList extends StatefulWidget {
  const ReciversList({super.key});

  @override
  State<ReciversList> createState() => _ReciversListState();
}

class _ReciversListState extends State<ReciversList> {
 // final Stream<QuerySnapshot> _usersStream =
   //   FirebaseFirestore.instance.collection('users').snapshots();
   final storage = FirebaseStorage.instance;
   final uid = FirebaseAuth.instance.currentUser!.uid;
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('users').snapshots();//.where("isTransporter",isNotEqualTo: true)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Choose Reciver"),),
      body: StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
          data["uid"]=document.id;
            return ListTile(
              leading: CircleAvatar(
                            radius: 30.0,
                            backgroundImage:
                                NetworkImage(data["profileUrl"]??"https://ptyagicodecamp.github.io/images/profile.jpg"),
                            backgroundColor: Colors.transparent,
                          ),
              title: Text(data['firstName']+" "+data['middleName']+" "+data['lastName']),
              subtitle: Text(data['address']),
              onTap: (){
                Navigator.pop(context,data);
              },
            );
          }).toList(),
        );
      },
    )
    );
  }
  
  
}
