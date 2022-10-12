// ignore_for_file: prefer_final_fields

import 'package:flutter/material.dart';

class TransporterDetailsForm extends StatefulWidget {
  const TransporterDetailsForm({super.key});

  @override
  State<TransporterDetailsForm> createState() => _TransporterDetailsFormState();
}

class _TransporterDetailsFormState extends State<TransporterDetailsForm> {
  int _stepIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stepper(
          type: StepperType.horizontal,
          controlsBuilder: (context, details) {
            return Padding(
              padding: const EdgeInsets.only(top: 32),
              child: Row(
                children: <Widget>[
                  ElevatedButton(
                    onPressed: details.stepIndex == 2
                        ? saveDetails()
                        : details.onStepContinue,
                    child: const Text(
                        'Save'), //'Continue to Step ${details.stepIndex + 1}'),
                  ),
                  details.stepIndex != 0
                      ? TextButton(
                          onPressed: details.onStepCancel,
                          child: const Text('Back'),
                        )
                      : const SizedBox(),
                ],
              ),
            );
          },
          currentStep: _stepIndex,
          onStepContinue: () {
            setState(() {
              if (_stepIndex < 2) {
                _stepIndex += 1;
              }
            });
          },
          onStepCancel: () {
            setState(() {
              if (_stepIndex > 0) {
                _stepIndex -= 1;
              }
            });
          },
          steps: const [
            Step(title: Text("Step 1"), content: Text("Step 1")),
            Step(title: Text("Step 2"), content: Text("Step 2")),
            Step(title: Text("Step 3"), content: Text("Step 3")),
          ],
        ),
      ),
    );
  }

  saveDetails() {}
}
