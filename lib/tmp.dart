import 'package:easy_go/screens/transporter/traveling_Details_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:easy_go/screens/home/home_screen.dart';
class Tmp extends StatefulWidget {
  const Tmp({super.key});

  @override
  State<Tmp> createState() => _TmpState();
}

class _TmpState extends State<Tmp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tmp')),
      body: Container(
        child: ElevatedButton(onPressed: (){
          Navigator.push(
                context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        }, child: Text('Travel Details')),
      ),
    );
  }
}