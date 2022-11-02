import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:easy_go/screens/transporter/traveling_Details_Screen.dart';
import 'package:easy_go/util/firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class SpecificCourierDetails extends StatefulWidget {
  const SpecificCourierDetails({super.key});

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
  Map<String, dynamic>? courier;
  var cid;
  final db=firestore;
  void initState() {
  super.initState();
  final docRef = db.collection("courier").doc(cid);
    docRef.get().then(
      (DocumentSnapshot doc) {
      courier = doc.data() as Map<String, dynamic>;
    // ...
  },
  onError: (e) => print("Error getting document: $e"),
  );
  print(courier!["courierName"]);
  productName.text = 'Pen';
  productType.text = 'box';
  productWeight.text = '45';
  productCharges.text = '12';
  locationFrom.text = 'Pinke Eethe deee fetch value';
  locationTo.text = 'Pinke Eethe deee fetch value';
  productReceiver.text = 'Pinke Eethe deee fetch value';
  productDescription.text = 'Pinke Eethe deee fetch value';
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
                image: const DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/images/pic1.jpg'),
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
