import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/io_client.dart';
import 'package:http/io_client.dart';
import 'package:hypenettask/profile.dart';
import 'package:hypenettask/signup.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'Forgotpassword.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _passwordVisible = false;
  String email='';
  String pw='';
  http.Client createInsecureHttpClient() {
    var httpClient = HttpClient()
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    return IOClient(httpClient);
  }
  Future<String> login(String email, String password) async {
    var client = createInsecureHttpClient();
    final url = await Uri.parse('https://10.10.61.58:8000/taskapp/login');
    //final response = await http.post(
    final response = await client.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
        'password': password,
      }),
    );
    try{
    if (response.statusCode == 200) {
      final responseData =  json.decode(response.body.toString());
      final prefs = await SharedPreferences.getInstance();
      var token = responseData['token'];
      prefs.setString('token', token);
      Navigator.push(context, MaterialPageRoute(builder: (context)=> Profile()));
      print('Login successful: $token');
      return token;
    } else {
      final responseData = json.decode(response.body);

      print('Response Body: ${response.body}');
      showmsg(responseData['error']);
      print('Login failed: ${responseData['error']}');
      throw Exception('Login failed: ${responseData['error']}');

    }}catch (e) {
      throw Exception('An error occurred: $e');
    }
  }

  showmsg(msg){
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Something went wrong', style: TextStyle(fontSize:20, color:  Color.fromRGBO(84, 114, 230, 1),)),
          content: Text(msg, textAlign: TextAlign.center, style: TextStyle(fontSize:18, color: Colors.red, ),),
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView( child: Container(
        padding: EdgeInsets.fromLTRB(20, 100, 20, 1),
        child:
        Column(            crossAxisAlignment: CrossAxisAlignment.stretch,
            children:<Widget>[
              Text("Login", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Color.fromRGBO(84, 114, 230, 1)),textAlign: TextAlign.center,),
              SizedBox(height: 10,),
              Text('Login and get started', textAlign: TextAlign.center, style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 18),),
              SizedBox(height: 40,),
              TextFormField(
                decoration: InputDecoration( prefixIcon: Icon(Icons.email_outlined, color: Colors.black54,),
                  labelText: 'Email',
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
                      color:  Color.fromRGBO(84, 114, 230, 1), // Color of the border
                      width: 2.0, // Thickness of the border
                    ),
                  ),
                ),
                onChanged: (value) {
                  email=value;

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
              SizedBox(height: 20),
              TextFormField(
                style: TextStyle(height: 0.8),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock_outline, color: Colors.black54,),
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      // Choose the icon based on the state of _passwordVisible
                      _passwordVisible ? Icons.visibility : Icons.visibility_off,color: Colors.black54,
                    ),
                    onPressed: () {
                      // Update the state i.e. toogle the state of passwordVisible variable
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },

                  ),
                  // Normal border
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  // Border when TextFormField is enabled
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40.0),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(84, 114, 230, 1),
                      width: 2.0,
                    ),
                  ),

                  // Border when TextFormField is focused
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40.0),
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2.0,
                    ),
                  ),
                ),
                obscureText: !_passwordVisible,
                onChanged: (value) {
                  pw=value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),

            //  SizedBox(height: 10),
              TextButton(onPressed:(){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> ForgotPasswordScreen()));
              }, child: Text('Forgot Password?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color.fromRGBO(84, 114, 230, 1)), ),),
              SizedBox(height: 20,),
              Container(
                  width: 300,
                  height: 50,
                  child:
                  ElevatedButton(
                    onPressed: () {
                      if(email==''||pw==''){showmsg('Please fill all fields.');}
                       else{login(email, pw);}
                    },
                    child: Text('Login', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20 ),),
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
              SizedBox(height: 40,),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Divider(
                      color: Colors.grey,
                      height: 1.5,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Text(
                      'or login with',
                      style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,

                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.grey,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

              Container(
                width: 50,
              height: 50,
              decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(45), // The same radius as the button
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3), // Shadow color
            blurRadius: 3.0, // Soften the shadow
            spreadRadius: 0.8, // Extend the shadow
            offset: Offset(0, 1), // Position of the shadow
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          // Handle the button press
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.white, // Button color
          /*shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(90), // The same radius as the Container
          ),*/
          elevation: 0,
          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),// Disable default shadow
        ),
        child:Icon(Icons.g_mobiledata, color: Color.fromRGBO(84, 114, 230, 1),),// Text color
        ),
      ),
      SizedBox(width: 20,),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(45), // The same radius as the button
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.3), // Shadow color
                        blurRadius: 3.0, // Soften the shadow
                        spreadRadius: 0.8, // Extend the shadow
                        offset: Offset(0, 1),// Position of the shadow
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle the button press
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white, // Button color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(90), // The same radius as the Container
                      ),
                      elevation: 0,
                      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),// Disable default shadow
                    ),
                    child:Icon(Icons.apple, color: Color.fromRGBO(84, 114, 230, 1),),// Text color
                  ),
                ),
                  SizedBox(width: 20,),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(45), // The same radius as the button
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.3), // Shadow color
                        blurRadius: 3.0, // Soften the shadow
                        spreadRadius: 0.8, // Extend the shadow
                        offset: Offset(0, 1), // Position of the shadow
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle the button press
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white, // Button color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(90), // The same radius as the Container
                      ),
                      elevation: 0,
                      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),// Disable default shadow
                    ),

                    child:Icon(Icons.facebook, color: Color.fromRGBO(84, 114, 230, 1),),// Text color
                  ),
                ),


    ],),
              SizedBox(height: 75,),
              Text('Don\'t have an account?', textAlign: TextAlign.center, style: TextStyle(fontSize: 15, color: Colors.grey), ),
              TextButton(onPressed:(){

                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> SignupScreen()));
              }, child: Text('Sign up', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color.fromRGBO(84, 114, 230, 1)), ),),

              //SizedBox(height: 40,),
            ])
      )),
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

