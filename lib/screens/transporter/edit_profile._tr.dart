import 'package:easy_go/screens/auth/personal_details_edit.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:easy_go/screens/auth/company_details_edit.dart';
class EditProfileTransporter extends StatefulWidget {
  const EditProfileTransporter({super.key});

  @override
  State<EditProfileTransporter> createState() => _EditProfileTransporterState();
}

class _EditProfileTransporterState extends State<EditProfileTransporter> {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context)=> DefaultTabController(
  length: 3,
  child: Scaffold(
  appBar: AppBar(
    title: const Text('Edit Profile'),
    centerTitle: true,
    bottom: const TabBar(tabs: [
      Tab(text: 'Personal', icon: Icon(Icons.person)),
      Tab(text: 'Orgnization',icon: Icon(Icons.home)),
      Tab(text: 'Travel Details',icon: Icon(Icons.bus_alert)),
    ],
    ),
  ),
  body: TabBarView(children: [
    
    PersonalInfoEdit(),
    CompanyDetailsEdit(),

    //Rating(),
  ],
  ),
  ),
); 
}