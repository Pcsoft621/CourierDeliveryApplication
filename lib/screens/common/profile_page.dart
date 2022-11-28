
import 'dart:io';
import 'package:easy_go/screens/widgets/text_field_widget';

import 'package:flutter/material.dart';
import 'package:path/path.dart';


class CheckText extends StatefulWidget {
  const CheckText({super.key});

  @override
  State<CheckText> createState() => _CheckTextState();
}

class _CheckTextState extends State<CheckText> {
  String nm='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            TextFieldWidget(
                  label: 'Full Name',
                  text: 'fnm',
                  onChanged: (name) {
                    nm=name;
                     showDialog(
                         context: context,
                         builder: (context) {
                        return AlertDialog(
                              content: Text( ''+nm),
                        );
                        
                      },
                      
                   );
                  },
                ),
                const SizedBox(height: 24),
                TextFieldWidget(
                  label: 'Email',
                  text: 'email',
                  onChanged: (email) {},
                ),
                TextButton(onPressed: (){
                      showDialog(
                         context: context,
                         builder: (context) {
                        return AlertDialog(
                              content: Text( ''+nm),
                        );
                        
                      },
                      
                   );
                }, child:Text('check it'))
          ],
        ),
      ),
    );
  }
}