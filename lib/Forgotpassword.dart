import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ForgotPasswordScreen extends StatelessWidget {
   String email='';

  Future<void> sendPasswordResetEmail(String email) async {
    final Uri resetUrl = Uri.parse('https://0.0.0.0:8000/taskapp/forgotpw');
    try {
      final response = await http.post(
        resetUrl,
        body: {'email': email},
      );

      if (response.statusCode == 200) {
       print('yaaaay');
      } else {
        print('whyyy');
      }
    } catch (e) {
      print('Noooo');

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Forgot Password')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            TextFormField(
              decoration: InputDecoration( prefixIcon: Icon(Icons.email_outlined, color: Colors.black54,),
                labelText: 'Your Email',
                // Normal border
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0), // Rounded corners
                  borderSide: BorderSide(
                    color: Colors.blue, // Color of the border
                    width: 2.0, // Thickness of the border
                  ),
                ),
                // Border when TextFormField is enabled
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40.0), // Rounded corners
                  borderSide: BorderSide(
                    color: Color.fromRGBO(84, 114, 230, 1),// Color of the border
                    width: 2.0, // Thickness of the border
                  ),
                ),
                // Border when TextFormField is focused
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40.0), // Rounded corners
                  borderSide: BorderSide(
                    color: Colors.blue, // Color of the border
                    width: 2.0, // Thickness of the border
                  ),
                ),
              ),
              onChanged: (value) {
                email=value;
                // You can use setState or a state management solution to update the email value.
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                } else if (!value.contains('@')) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
              style: TextStyle(height: 0.8),
              // onSaved: (value) => _email = value!,
            ),
            SizedBox(height:20),
            Container(
                width: 300,
                height: 50,
                child:
                ElevatedButton(
                  onPressed: () {
                    sendPasswordResetEmail(email);
                  },
                  child: Text('Send Reset Lin', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20 ),),
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(84, 114, 230, 1), // Button color
                    onPrimary: Colors.white, // Text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30), // Rounded edges
                    ),
                    // padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15), // Button padding
                  ),
                )
            ),

          ],
        ),
      ),
      bottomNavigationBar:  Container(
          width: 140,
          height: 25,

          padding: EdgeInsets.fromLTRB(100, 1, 100, 20),
          child:
          ElevatedButton(
            onPressed: () {
              // Your event code here
            },
            child: Text('',),
            style: ElevatedButton.styleFrom(
              primary: Color.fromRGBO(84, 114, 230, 1), // Button color
              onPrimary: Colors.white, // Text color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30), // Rounded edges
              ),
              // padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15), // Button padding
            ),
          )
      ),

    );
  }
}
