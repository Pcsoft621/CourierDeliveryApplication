import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Color ?accentColor;
  final Color ?mainColor;
  var text;
  final Function ?onpress;
  CustomButton({this.accentColor, this.text, this.mainColor, this.onpress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){},
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.blueGrey,
            ),
            color: mainColor,
            borderRadius: BorderRadius.circular(50)),
        width: MediaQuery.of(context).size.width * 0.6,
        padding: EdgeInsets.all(15),
        child: Center(
          child: Text(
            ''+text,
            style: TextStyle(fontFamily: 'Poppins', color: accentColor),
          ),
        ),
      ),
    );
  }
}