import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:easy_go/screens/consumer/current_tran_sender.dart';

class TransporterDetails extends StatefulWidget {
  final String courierId;
  final String transporterId;
  const TransporterDetails(
      {super.key, required this.courierId, required this.transporterId});


  @override
  State<TransporterDetails> createState() => _TransporterDetailsState();
}

class _TransporterDetailsState extends State<TransporterDetails> {
  final String name="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Transporter Details") ,),
      body: Container(
        child: Column(
          children: [
            Text(name),
             ElevatedButton(
              onPressed: (){
            transcationCreate();
            Navigator.push(
                            //pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  TrackSenderTransaction(
                                courierId: widget.courierId as String,
                                transporterId: widget.transporterId,
                                
                              ),
                            ),
                          );
          },
          child: Text('Conform This Transporter'),
          ),
        
          ],
        ),
      ),
    );
  }
  void transcationCreate()
  {

  }
}