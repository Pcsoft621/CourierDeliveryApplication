import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:easy_go/screens/transporter/traveling_Details_Screen.dart';
import 'package:easy_go/util/firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:easy_go/screens/transporter/track_transporter_curr_trans.dart';
class SpecificCourierDetails extends StatefulWidget {
  final String courierId;
  final String courierTitle;
  final String senderId;
  const SpecificCourierDetails({super.key,
      required this.courierId,
      required this.senderId,
      this.courierTitle = ""});

  @override
  State<SpecificCourierDetails> createState() => _SpecificCourierDetailsState();
}

class _SpecificCourierDetailsState extends State<SpecificCourierDetails> {
  final productName=TextEditingController();
  final productType=TextEditingController();
  final productWeight=TextEditingController();
  final locationFrom=TextEditingController();
  final locationTo=TextEditingController();
  final productReceiver=TextEditingController();
  final productCharges=TextEditingController();
  final productDescription=TextEditingController();
  final uid = FirebaseAuth.instance.currentUser!.uid;
  String productImageUrl="";
  String courierSenderId="";
  String transporterName="";
  late Map<String, dynamic> courier;
  late Map<String, dynamic> user;
  final db=firestore;
  void initState() {
  super.initState();
  initCourier();
  
  }
  /*
  productWeight.text = '45';
  productCharges.text = '12';
  locationFrom.text = 'Pinke Eethe deee fetch value';
  locationTo.text = 'Pinke Eethe deee fetch value';
  productReceiver.text = 'Pinke Eethe deee fetch value';
  productDescription.text = 'Pinke Eethe deee fetch value';*/

  Future<void> initCourier ()async
  {
    
     final docRef = db.collection("courier").doc(widget.courierId);
    docRef.get().then(
      (DocumentSnapshot doc) {
        setState(() {
          courier = doc.data() as Map<String, dynamic>;    
          productName.text = courier["courierName"];
          productWeight.text=courier["courierWeight"];
          productCharges.text=courier["courierCharges"];
          locationFrom.text=courier["locationFrom"];
          locationTo.text=courier["locationTo"];
          productType.text=courier["courierType"];
          productImageUrl=courier["courierImageUrl"];
          courierSenderId=courier["courierSenderId"];
          final d = db.collection("users").doc(courier["courierReceiverId"]);
          d.get().then((DocumentSnapshot doc1){
            setState(() {
              user  =doc1.data() as Map<String,dynamic>;
            productReceiver.text =user["firstName"]+" "+user["lastName"];
            });
            
          });
          final dd = db.collection("users").doc(uid);
          d.get().then((DocumentSnapshot doc2){
            setState(() {
              user  =doc2.data() as Map<String,dynamic>;
            transporterName =user["firstName"]+" "+user["lastName"];
            });
            
          });
        });
      });  

      
    // ...
  
  }
  
  void sendRequest()
      {
        setState(() {
          firestore.collection("courier").doc(widget.courierId).update({'transporterId':uid});
          firestore.collection("courier").doc(widget.courierId).update({'transporterName':transporterName});
          firestore.collection("courier").doc(widget.courierId).update({'isRequestedByTransporter':true});
        });
        
      }
  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: const EdgeInsets.all(20),
       child: Card(
          margin: const EdgeInsets.all(5),
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
           // crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[ 
            const SizedBox(height: 10.0,),
            Container(
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.width / 2,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black,width: 1),
                shape: BoxShape.rectangle,
                image:  DecorationImage(
                  fit: BoxFit.fill,
                  image:NetworkImage(productImageUrl),
                )
              ),
            ),
        const SizedBox(height:15.0),
        const Divider(),
        const SizedBox(height:15.0),
        Row(
        children:[
          const Text("  Courier Name: ",
          style: TextStyle( fontSize: 17)),
          
          Text(productName.text,
          style: const TextStyle( fontSize: 16,fontStyle: FontStyle.italic, fontWeight: FontWeight.bold )),
        ],
        ),

        const SizedBox(height:5.0),
         Row(
        children:[
          const Text("  Courier Type: ",
          style: TextStyle( fontSize: 17)),
          
          Text(productType.text,
          style: const TextStyle( fontSize: 16,fontStyle: FontStyle.italic, fontWeight: FontWeight.bold )),
        ],
        ),

         const SizedBox(height:15.0),
         Row(
        children:[
          const Text("  Courier Weight: ",
          style: TextStyle( fontSize: 17)),
          
          Text(productWeight.text,
          style: const TextStyle( fontSize: 16,fontStyle: FontStyle.italic, fontWeight: FontWeight.bold )),
        ],
        ),
        
         const SizedBox(height:15.0),
         Row(
        children:[
          const Text("  MAx. Affordable Charges: ",
          style: TextStyle( fontSize: 17)),
          
          Text(productCharges.text,
          style: const TextStyle( fontSize: 16,fontStyle: FontStyle.italic, fontWeight: FontWeight.bold )),
        ],
        ),

         const SizedBox(height:15.0),
         Row(
        children:[
          const Text("  Location From: ",
          style: TextStyle( fontSize: 17)),
          
          Text(locationFrom.text,
          style: const TextStyle( fontSize: 16,fontStyle: FontStyle.italic, fontWeight: FontWeight.bold )),
        ],
        ),

         const SizedBox(height:15.0),
         Row(
        children:[
          const Text("  Location To: ",
          style: TextStyle( fontSize: 17)),
          
          Text(locationTo.text,
          style: const TextStyle( fontSize: 16,fontStyle: FontStyle.italic, fontWeight: FontWeight.bold )),
        ],
        ),

        const SizedBox(height:15.0),
         Row(
        children:[
          const Text("  Selected Reciever Name: ",
          style: TextStyle( fontSize: 17)),
          
          Text(productReceiver.text,
          style: const TextStyle( fontSize: 16,fontStyle: FontStyle.italic, fontWeight: FontWeight.bold )),
        ],
        ),
    
         const SizedBox(height:15.0),
         Row(
        children:[
          const Text("  Courier Descrption(Optional): ",
          style: TextStyle( fontSize: 17)),
          
          Text(productDescription.text,
          style: const TextStyle( fontSize: 16,fontStyle: FontStyle.italic, fontWeight: FontWeight.bold )),
        ],
        ),

         const SizedBox(height:15.0), 
         ElevatedButton(
          onPressed: (){
            sendRequest();
            Navigator.push(
                            //pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CurrentTransactionTransporter(
                                courierId: widget.courierId as String,
                                senderId: courierSenderId,
                                courierTitle:
                                    "${productName.text} ${locationFrom} ${locationTo}",
                              ),
                            ),
                          );
          },
          child: Text('Send Request To Sender'),
          ),
         
          ],  
       ),
       ),
    );
  }
  
}
class SpecificCourierScreenArguments {
  final String courierId;
  //int? resendToken;

  //SpecificCourierScreenArguments(this.courierId, {this.resendToken});
  SpecificCourierScreenArguments(this.courierId);
}
