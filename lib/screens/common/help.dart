import 'package:flutter/material.dart';
import 'package:easy_go/util/routes.dart';
import 'package:easy_go/screens/common/contact_us.dart';
import 'package:easy_go/util/routes.dart';
import 'package:easy_go/screens/home/home_screen.dart';
class HelpPage extends StatefulWidget {
  const HelpPage({ Key? key }) : super(key: key);

  @override
  State<HelpPage> createState() => _HelpPageState();
}

String? selectone;
class _HelpPageState extends State<HelpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Help"),),
      body:  Container(
      padding: const EdgeInsets.all(20),
       child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          // ignore: prefer_const_literals_to_create_immutables
          children: <Widget>[

          TextButton.icon(
              icon: const Icon(
              IconData(0xe043, fontFamily: 'MaterialIcons'),
              color: Color.fromARGB(255, 87, 86, 86),
              size: 24.0,
               ),
              onPressed: () {
                  Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const Sendmail()),
                             );
                //action
              },
              label: const Text('Contact us',
              style: TextStyle(color: Colors.black, fontWeight: FontWeight. bold)
              )
          ), 


        const SizedBox(height:14.0),
          TextButton.icon(
              icon: const Icon(
              IconData(0xf587, fontFamily: 'MaterialIcons', matchTextDirection: true),
              color: Color.fromARGB(255, 87, 86, 86),
              size: 24.0,
               ),
              onPressed: () {
                //action
              },
              label: const Text('Terms and Privacy Policy',
              style: TextStyle(color: Colors.black, fontWeight: FontWeight. bold)
              )
          ), 


        const SizedBox(height:14.0),
          TextButton.icon(
              icon: const Icon(
              IconData(0xe087, fontFamily: 'MaterialIcons'),
              color: Color.fromARGB(255, 87, 86, 86),
              size: 24.0,
               ),
              onPressed: () {
                //action
              },
              label: const Text('App info',
              style: TextStyle(color: Colors.black, fontWeight: FontWeight. bold))
          ), 
        

  ],
  ),
  ),
  );
    
  }
}
