import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:rating_dialog/rating_dialog.dart';

class CurrnetTransactionSender extends StatefulWidget {
  const CurrnetTransactionSender({super.key});

  @override
  State<CurrnetTransactionSender> createState() =>
      _CurrnetTransactionSenderState();
}

class _CurrnetTransactionSenderState extends State<CurrnetTransactionSender> {
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Current Transaction'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Stepper(
              currentStep: _index,
              onStepCancel: () {
                if (_index > 0) {
                  //code for deal Cancel
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
                  title: const Text('Discussion',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                  content: Container(
                    alignment: Alignment.centerLeft,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.grey)),
                      child: const Text(
                        'Chat ',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                  isActive: _index >= 0,
                  state: _index >= 2 ? StepState.complete : StepState.disabled,
                ),
                Step(
                  title: const Text('Confirm Deal',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                  content: Container(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.grey)),
                              child: const Text(
                                'Accepted',
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Text('|'),
                            const SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.grey)),
                              child: const Text(
                                'Cancel',
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  isActive: _index >= 0,
                  state: _index >= 2 ? StepState.complete : StepState.disabled,
                ),
                Step(
                  title: const Text('Pay To Transporter',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                  content: Container(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.grey)),
                              child: const Text(
                                'Yes, Payment done',
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Text('|'),
                            const SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.grey)),
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
                  isActive: _index >= 0,
                  state: _index >= 2 ? StepState.complete : StepState.disabled,
                ),
                Step(
                  title: const Text('Courier given to transporter ',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                  content: Container(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.grey)),
                              child: const Text(
                                'Yes, given.',
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Text('|'),
                            const SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.grey)),
                              child: const Text(
                                'Not yet',
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  isActive: _index >= 0,
                  state: _index >= 2 ? StepState.complete : StepState.disabled,
                ),
                Step(
                  title: const Text('Courier Delivered To Reciver',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                  content: Container(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: [
                            Text("delivered or not"),
                            const SizedBox(width: 10),
                            const Text('|'),
                            const SizedBox(width: 10),
                          ],
                        ),
                      ],
                    ),
                  ),
                  isActive: _index >= 0,
                  state: _index >= 2 ? StepState.complete : StepState.disabled,
                ),
                Step(
                  title: const Text('Rate Transporter',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                  content: Container(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: showRatingDialog,
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.grey)),
                              child: const Text(
                                'Rate ',
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  isActive: _index >= 0,
                  state: _index >= 2 ? StepState.complete : StepState.disabled,
                ),
              ],
            ),
            Row(
              children: [
                FloatingActionButton(
                  onPressed: () {},
                  child: Icon(Icons.chat),
                ),
                SizedBox(
                  width: 30,
                ),
                FloatingActionButton(
                  onPressed: () {},
                  child: Icon(Icons.add_location_alt_rounded),
                ),
                SizedBox(
                  width: 30,
                ),
                FloatingActionButton(
                  onPressed: () {},
                  child: Icon(Icons.report),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void showRatingDialog() {
    final ratingDialog = RatingDialog(
      onCancelled: () => print("cancelled"),
      onSubmitted: (response) {
        print("Rate us!: ${response.rating}");
        print("comment: ${response.comment}");
      },
      submitButtonText: 'Submit',
      title: const Text("Rate us!"),
      message: const Text(
          "Would you mind taking a moment to rate our work? Thank you for your support !"),
    );
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => ratingDialog,
    );
  }
}
