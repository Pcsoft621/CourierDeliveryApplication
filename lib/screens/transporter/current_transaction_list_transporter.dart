import 'package:easy_go/util/firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_go/screens/consumer/specific_courier_details_scren.dart';

class CurrentTransactionsForTr extends StatefulWidget {
  const CurrentTransactionsForTr({super.key});

  @override
  State<CurrentTransactionsForTr> createState() =>
      _CurrentTransactionsForTrState();
}

// claass chya outside variable declare kartyat ka
//karn mg tith initialize nahi hot jr aat kel tr
class _CurrentTransactionsForTrState extends State<CurrentTransactionsForTr> {
  final storage = FirebaseStorage.instance;
  final uid = FirebaseAuth.instance.currentUser!.uid;
  String? from, to;
  Map<String, dynamic>? user;
  List<Map<String, dynamic>>? couriers;
  @override
  void initState() {
    getData();
    getD();
    super.initState();
  }

  //final Stream<QuerySnapshot> _courierStream =

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('MyRequests'),
        ),
        body: from == null
            ? CircularProgressIndicator()
            : StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('courier')
                    .where("locationFrom", isEqualTo: from)
                    .where("locationTo", isEqualTo: to)
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
                      
                      return ListTile(
                        leading: CircleAvatar(
                          radius: 30.0,
                          backgroundImage: NetworkImage(data[
                                  "courierImageUrl"] ??
                              "https://ptyagicodecamp.github.io/images/profile.jpg"),
                          backgroundColor: Colors.transparent,
                        ),
                        title: Text(data['courierName'] +
                            " " +
                            data['locationFrom'] +
                            " " +
                            data['locationTo']),
                       
                        onTap: () {
                           
                          
                        },
                      );
                    }).toList(),
                  );
                },
              ));
  }

  void getD() {
    firestore.collection("users").doc(uid).get().then((value) {
      user = value.data();
      setState(() {
        from =
            (user!["travelDetails"] as Map<String, dynamic>)["startLocation"];
        to = (user!["travelDetails"] as Map<String, dynamic>)["endLocation"];
      });
    });
  }

  void getData() {
    firestore.collection("users").doc(uid).get().then((value) {
      user = value.data();
      final from =
          (user!["travelDetails"] as Map<String, dynamic>)["startLocation"];
      final to =
          (user!["travelDetails"] as Map<String, dynamic>)["endLocation"];
      firestore
          .collection("courier")
          .where("locationFrom", isEqualTo: from)
          .where("locationTo", isEqualTo: to)
          .get()
          .then((value) {
        setState(() {
          couriers = value.docs.map((e) => e.data()).toList();
        });
      });
    });
  }
}
