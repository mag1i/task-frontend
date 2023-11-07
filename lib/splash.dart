import 'package:flutter/material.dart';

import 'home.dart';
import 'main.dart';


class splashy extends StatelessWidget {
  const splashy({Key? key}) : super(key: key);
static getspl(){
  return Scaffold(
      backgroundColor: Colors.blue,
      body:
      Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,// Aligns children to the top
          // crossAxisAlignment: CrossAxisAlignment.stretch, // Centers the children vertically// Aligns children to the center of the Column
          children: [
            Ink.image(image: AssetImage("images/logo.png"), height:80, width:80, fit: BoxFit.fill),
            Padding(
                padding: const EdgeInsets.only(top: 1.0), // Add some space between the image and text
                child: Text(
                  'AHMED',
                  style: TextStyle(color: Colors.white, fontSize: 30),
                  textAlign: TextAlign.center, // Center the text
                )),
            SizedBox(height: 1000,)]
      )
  );

}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue,
      body:
      Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,// Aligns children to the top
          // crossAxisAlignment: CrossAxisAlignment.stretch, // Centers the children vertically// Aligns children to the center of the Column
          children: [
        Ink.image(image: AssetImage("images/logo.png"), height:80, width:80, fit: BoxFit.fill),
            Padding(
                padding: const EdgeInsets.only(top: 1.0), // Add some space between the image and text
                child: Text(
                  'AHMED',
                  style: TextStyle(color: Colors.white, fontSize: 30),
                  textAlign: TextAlign.center, // Center the text
                )),
            SizedBox(height: 1000,)]
      )
    );
  }
}
