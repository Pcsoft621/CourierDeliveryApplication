import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_go/screens/consumer/specific_courier_details_scren.dart';
import 'package:easy_go/screens/transporter/track_transporter_curr_trans.dart';
import 'package:easy_go/util/firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:easy_go/screens/transporter/transporter_details.dart';
class RequestsFromTransporters extends StatefulWidget {
  const RequestsFromTransporters({
    super.key,
  });

  @override
  State<RequestsFromTransporters> createState() =>
      _RequestsFromTransportersState();
}

class _RequestsFromTransportersState extends State<RequestsFromTransporters> {
  final storage = FirebaseStorage.instance;
  final uid = FirebaseAuth.instance.currentUser!.uid;
  String? transporterId,transporterName;
  Map<String, dynamic>? user;
  List<Map<String, dynamic>>? couriers;
  
  

  //final Stream<QuerySnapshot> _courierStream =

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('MyRequests '),
        ),
        body: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('courier')
                    .where("courierSenderId", isEqualTo: uid)
                    
                    .where("isRequestedByTransporter", isEqualTo: true)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading");
                  }

                  return ListView(
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;
                      data["id"] = document.id;
                      return ListTile(
                        
                        leading: CircleAvatar(
                          radius: 30.0,
                          backgroundImage: NetworkImage(data[
                                  "courierImageUrl"] ??
                              "https://ptyagicodecamp.github.io/images/profile.jpg"),
                          backgroundColor: Colors.transparent,
                        ),
                        title: Text(data['transporterName'] 
                            ),
                        onTap: () {
                        
                          Navigator.push(
                            //pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  TransporterDetails(
                                courierId: data["id"] as String,
                                transporterId: data["transporterId"],
                                
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  );
                },
              ));
  }
  
}