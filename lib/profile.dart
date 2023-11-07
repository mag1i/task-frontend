import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hypenettask/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:hypenettask/signup.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'home.dart';
class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  Future<Map<String, dynamic>> fetchUserData() async {
    final Uri userUrl = Uri.parse('https://0.0.0.0:8000/taskapp/user');
    // Retrieve the saved token from Step 1
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

    try {
      final response = await http.get(
        userUrl,
        // Include the token in the header
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Token $token',
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        // Now `data` contains the user details
        return data;
      } else {
        throw Exception('Failed to fetch user data');
      }
    } catch (e) {
      throw Exception('Error fetching user data: $e');
    }
  }
  String name='';
  Future<String> fetchUsername() async {
    Map<String, dynamic> userData = await fetchUserData();
    // Access the username using the key 'username' from the userData map
    String username = userData['username'];
    name=username;
    return username;
  }

  Future<void> logoutUser() async {
    final prefs = await SharedPreferences.getInstance();
    // Retrieve the token that you've stored locally
    final token = prefs.getString('token') ?? '';

    final url = Uri.parse('http://192.168.59.2:8000/taskapp/logout');

    try {
      // Send the logout POST request to the server
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Token $token',
        },
      );

      // Check if the logout was successful
      if (response.statusCode == 204) {
        // Clear the stored token and other user info
        await prefs.clear();

        // Navigate to the login screen or handle the UI update accordingly
        // Assuming you're using some navigator function for this
        Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
      } else {
        // Handle any other responses accordingly
        throw Exception('Failed to logout. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle errors such as no internet connection
      throw Exception('Error occurred during logout: $e');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchUserData();
    fetchUsername();
    super.initState();
    fetchUsername();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView( child: Container(
          padding: EdgeInsets.fromLTRB(20, 100, 20, 1),
          child:
          Column(            crossAxisAlignment: CrossAxisAlignment.stretch,
              children:<Widget>[
                Text("Profile", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Color.fromRGBO(84, 114, 230, 1)),textAlign: TextAlign.center,),
                SizedBox(height: 10,),
                Text('welcome '+name, textAlign: TextAlign.center, style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 18),),
                SizedBox(height: 40,),
                Container(
                    width: 300,
                    height: 50,
                    child:
                    ElevatedButton(
                      onPressed: () {
                        logoutUser();
                      },
                      child: Text('Logout', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20 ),),
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

      ]))),
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

