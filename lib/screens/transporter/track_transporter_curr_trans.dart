import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
class Current_tran_Transporter extends StatefulWidget {
  const Current_tran_Transporter({super.key});

  @override
  State<Current_tran_Transporter> createState() => _Current_tran_TransporterState();
}

class _Current_tran_TransporterState extends State<Current_tran_Transporter> {
     int _index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Current Transaction'),),
      body:  Container(
      padding: const EdgeInsets.all(20),
       child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
        if (_index < 4) {
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
          title: const Text('Request Acceptance',
          style: TextStyle(fontSize: 17 ,fontWeight: FontWeight. bold)),
          content: Container(
              alignment: Alignment.centerLeft,
              child:
              ElevatedButton(
                     onPressed: () {
                },
                style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.grey)),
                child: const Text(
                'Request Accept ',
                style: TextStyle(fontSize: 15),
                 ),
              ),
              ),
              isActive:  _index>= 0,state: _index >= 2 ? StepState.complete : StepState.disabled,
        ),
        Step(
          title: const Text('Confirm Deal',
          style: TextStyle(fontSize: 17 ,fontWeight: FontWeight. bold)),
          content: Container(
              alignment: Alignment.centerLeft,
              child: Column(
              children:<Widget>[ 
              Row(
                children: [
                  ElevatedButton(
                         onPressed: () {
                    },
                    style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.grey)),
                    child: const Text(
                    'Deal Accepted',
                    style: TextStyle(fontSize: 15),
                     ),
                  ),
                  const SizedBox(width: 10),
                  const Text('|'),
                  const SizedBox(width: 10),
                  ElevatedButton(
                     onPressed: () {
                },
                style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.grey)),
                child: const Text(
                'Deal Cancel',
                style: TextStyle(fontSize: 15),
                 ),
              ),
                ],
              ),
              ],
              ),
              ),
              isActive:  _index>= 0,state: _index >= 2 ? StepState.complete : StepState.disabled,
        ),
        Step(
          title: const Text('Payment Acceptance',
          style: TextStyle(fontSize: 17 ,fontWeight: FontWeight. bold)),
          content: Container(
              alignment: Alignment.centerLeft,
              child:Column(
              children:<Widget>[ 
              Row(
                children: [
                  ElevatedButton(
                         onPressed: () {
                    },
                    style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.grey)),
                    child: const Text(
                    'Yes, Payment done',
                    style: TextStyle(fontSize: 15),
                     ),
                  ),
                  const SizedBox(width: 10),
                  const Text('|'),
                  const SizedBox(width: 10),
                  ElevatedButton(
                     onPressed: () {
                },
                style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.grey)),
                child: const Text(
                'Not yet.',
                style: TextStyle(fontSize: 15),
                 ),
              ),
                ],
              ),
              ],
              ),
              ),
              isActive:  _index>= 0,state: _index >= 2 ? StepState.complete : StepState.disabled,
        ),

         Step(
          title: const Text('Product received',
          style: TextStyle(fontSize: 17 ,fontWeight: FontWeight. bold)),
          content: Container(
              alignment: Alignment.centerLeft,
              child:Column(
              children:<Widget>[ 
              Row(
                children: [
                  ElevatedButton(
                         onPressed: () {
                    },
                    style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.grey)),
                    child: const Text(
                    'Yes, received.',
                    style: TextStyle(fontSize: 15),
                     ),
                  ),
                  const SizedBox(width: 10),
                  const Text('|'),
                  const SizedBox(width: 10),
                  ElevatedButton(
                     onPressed: () {
                },
                style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.grey)),
                child: const Text(
                'Not yet.',
                style: TextStyle(fontSize: 15),
                 ),
              ),
                ],
              ),
              ],
              ),
              ),
              isActive:  _index>= 0,state: _index >= 2 ? StepState.complete : StepState.disabled,
        ),

        Step(
          title: const Text('Product received',
          style: TextStyle(fontSize: 17 ,fontWeight: FontWeight. bold)),
          content: Container(
              alignment: Alignment.centerLeft,
              child:Column(
              children:<Widget>[ 
              Row(
                children: [
                  ElevatedButton(
                         onPressed: () {
                    },
                    style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.grey)),
                    child: const Text(
                    'Yes',
                    style: TextStyle(fontSize: 15),
                     ),
                  ),
                  const SizedBox(width: 10),
                  const Text('|'),
                  const SizedBox(width: 10),
                  ElevatedButton(
                     onPressed: () {
                },
                style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.grey)),
                child: const Text(
                'Not yet.',
                style: TextStyle(fontSize: 15),
                 ),
              ),
                ],
              ),
              ],
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