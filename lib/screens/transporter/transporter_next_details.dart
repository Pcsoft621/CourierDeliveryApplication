import 'package:easy_go/screens/auth/company_details.dart';
import 'package:easy_go/screens/transporter/student_details_screen.dart';
import 'package:easy_go/screens/transporter/traveling_Details_Screen.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:easy_go/util/routes.dart';
class TransporterNextDeails extends StatefulWidget {
  const TransporterNextDeails({super.key});

  @override
  State<TransporterNextDeails> createState() => _TransporterNextDeailsState();
}

class _TransporterNextDeailsState extends State<TransporterNextDeails> {
     int _index = 0;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text("Profile"),),
      body:  Container(
      padding: const EdgeInsets.all(20),
       child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
          Stepper(
            currentStep: _index,
            onStepCancel: () {
            if (_index > 0) {
                setState(() {
                _index -= 1;
            });
            }
           },
           onStepContinue: () {
              if (_index < 2) {
          setState(() {
            _index += 1;
          });
        }
      },
      onStepTapped: (int index) {
        setState(() {
          _index = index;
        });
      },
      
      steps: <Step>[
        Step(
          title: const Text('Personal Details', style: TextStyle(fontSize: 17 ,fontWeight: FontWeight. bold)),
          content: Container(
              alignment: Alignment.centerLeft,
              child:
              const Text(
                'Yahoo! Personal details already saved while Registration. ', 
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w100 ),
              ),
            ),
              isActive:  _index>= 0,state: _index >= 0 ? StepState.complete : StepState.disabled,
        ),
        Step(
          title: const Text('Orgnization Details', 
          style: TextStyle(fontSize: 17 ,fontWeight: FontWeight. bold)),
          content: Container(
              padding: EdgeInsets.all(0),
              margin: EdgeInsets.zero,
              child: Column(
              
                mainAxisAlignment: MainAxisAlignment.start,
                children:[ 
                Row(
                children: [
                  ElevatedButton(
                         onPressed: () {
                            Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const Student_Details_Screen()),
                             );
                    },
                    style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.grey)),
                    child: const Text(
                    ' Student ',
                    style: TextStyle(fontSize: 15),
                     ),
                  ),

                  const SizedBox(width: 10),

                  const Text('OR'),
                  const SizedBox(width: 10),
                  ElevatedButton(
                     onPressed: () {
                      Navigator.push(
                context,
              MaterialPageRoute(builder: (context) => const CompanyDetails()),
          );
                    },
                    style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.grey)),
                    child: const Text(
                         ' Employee ',
                      style: TextStyle(fontSize: 15),
                   ),
                 ),
                ],
              ),
            ],
          ),
        ),
        isActive:  _index>= 0,state: _index >= 1 ? StepState.complete : StepState.disabled,
        ),

        Step(
          title: const Text('Traveling Details',
          style: TextStyle(fontSize: 17 ,fontWeight: FontWeight. bold)),
          content: Container(
              alignment: Alignment.centerLeft,
              child:
              ElevatedButton(
                     onPressed: () {
                      Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const TravelDetails()),
          );
                },
                style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.grey)),
                child: const Text(
                'Fill details ',
                style: TextStyle(fontSize: 15),
                 ),
              ),
              ),
              isActive:  _index>= 0,state: _index >= 2 ? StepState.complete : StepState.disabled,
        ),
      ],
    ),

   ],
  ),
  ),
  );
  }
}