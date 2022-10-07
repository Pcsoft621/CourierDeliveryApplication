library transporter_details;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TravelDetails extends StatefulWidget {
  const TravelDetails({Key? key}) : super(key: key);

  @override
  State<TravelDetails> createState() => _TravelDetailsState();
}

class _TravelDetailsState extends State<TravelDetails> {
  final enterStartLocation = TextEditingController();
  final chooseStartLocation = TextEditingController();
  final appTimeRequired = TextEditingController();
  final enterEndLocation = TextEditingController();
  final chooseEndLocation = TextEditingController();
  final selectStartTime = TextEditingController();
  final selectEndTime = TextEditingController();

  TimeOfDay? time = TimeOfDay.now();
  List trvelmodeitems = [
    {"title": "Bus", "value": "1"},
    {"title": "Car", "value": "2"},
    {"title": "Cycle", "value": "3"},
    {"title": "Train", "value": "4"},
    {"title": "Bike", "value": "5"},
  ];
  String travelModeValue = "";

  List trvelFrequencyitems = [
    {"title": "Daily", "value": "1"},
    {"title": "Weekly (Day)", "value": "2"},
    {"title": "Holiday", "value": "3"},
    {"title": "Monthly", "value": "4"},
    {"title": "Custom (Date)", "value": "5"},
  ];
  String travelFrequencyValue = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.all(18),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: enterStartLocation,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                fillColor: Colors.black,
                labelText: 'Enter Start Location',
              ),
            ),
            const SizedBox(height: 10.0),
            TextField(
              controller: chooseStartLocation,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  fillColor: Colors.black,
                  labelText: 'Choose Start Location',
                  suffixIcon: Icon(Icons.location_on_outlined)),
            ),
            const SizedBox(height: 10.0),
            TextField(
              controller: enterEndLocation,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                fillColor: Colors.black,
                labelText: 'Enter End Location',
              ),
            ),
            const SizedBox(height: 10.0),
            TextField(
              controller: chooseEndLocation,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                fillColor: Colors.black,
                labelText: 'Choose End Location',
                suffixIcon: Icon(Icons.location_on_outlined),
              ),
            ),
            const SizedBox(height: 10.0),
            TextField(
              keyboardType: TextInputType.number,
              controller: appTimeRequired,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                fillColor: Colors.black,
                labelText: 'Approximate Traveling Time Required ',
              ),
            ),
            const SizedBox(height: 10.0),
            TextField(
              controller: selectStartTime,

              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                fillColor: Colors.black,
                labelText: 'Approximate Start Time ',
                suffixIcon: Icon(Icons.timer),
              ),
              readOnly:
                  true, //set it true, so that user will not able to edit text
              onTap: () async {
                TimeOfDay? pickedTime = await showTimePicker(
                  initialTime: TimeOfDay.now(),
                  context: context,
                );

                if (pickedTime != null) {
                  print(pickedTime.format(context)); //output 10:51 PM
                  String formattedTime = DateFormat.jm().format(DateTime.now());
                  print(formattedTime); //output 14:59:00
                  setState(() {
                    selectStartTime.text =
                        formattedTime; //set the value of text field.
                  });
                } else {
                  print("Time is not selected");
                }
              },
            ),
            const SizedBox(height: 10.0),
            TextField(
              controller: selectEndTime,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                fillColor: Colors.black,
                labelText: 'Approximate End Time ',
                suffixIcon: Icon(Icons.timer),
              ),
              readOnly:
                  true, //set it true, so that user will not able to edit text
              onTap: () async {
                TimeOfDay? pickedTime = await showTimePicker(
                  initialTime: TimeOfDay.now(),
                  context: context,
                );

                if (pickedTime != null) {
                  print(pickedTime.format(context)); //output 10:51 PM
                  String formattedTime = DateFormat.jm().format(DateTime.now());
                  print(formattedTime); //output 14:59:00
                  setState(() {
                    selectEndTime.text =
                        formattedTime; //set the value of text field.
                  });
                } else {
                  print("Time is not selected");
                }
              },
            ),
            const SizedBox(height: 10.0),
            InputDecorator(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(10),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: travelModeValue,
                  isDense: true,
                  isExpanded: true,
                  menuMaxHeight: 400,
                  items: [
                    const DropdownMenuItem(
                        child: Text(
                          "Select Traveling Mode",
                        ),
                        value: ""),
                    ...trvelmodeitems.map<DropdownMenuItem<String>>((e) {
                      return DropdownMenuItem(
                          child: Text(e['title']), value: e['title']);
                    }).toList(),
                  ],
                  onChanged: (String? newValue) {
                    setState(() {
                      travelModeValue = newValue!;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            InputDecorator(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(10),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: travelFrequencyValue,
                  isDense: true,
                  isExpanded: true,
                  menuMaxHeight: 400,
                  items: [
                    const DropdownMenuItem(
                        child: Text(
                          "Select Traveling Frequency",
                        ),
                        value: ""),
                    ...trvelFrequencyitems.map<DropdownMenuItem<String>>((e) {
                      return DropdownMenuItem(
                          child: Text(e['title']), value: e['title']);
                    }).toList(),
                  ],
                  onChanged: (String? newValue) {
                    setState(() {
                      travelFrequencyValue = newValue!;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text(enterStartLocation.text +" " +chooseStartLocation.text +
                          " " +enterEndLocation.text +" " +chooseEndLocation.text +" "+appTimeRequired.text+
                          " " +selectStartTime.text +" " +travelModeValue +" " +travelFrequencyValue),
                    );
                  },
                );
              },
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size(320, 25),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50))),
              child: const Text(
                'SUBMIT',
                style: TextStyle(fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
