import 'package:flutter/material.dart';
import 'package:hypenettask/login.dart';
import 'package:hypenettask/signup.dart';
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 100, 20, 1),
        child: Column(          // This centers the children within the Row.
             children:[
         // SizedBox(height: 100,),
          Text("Welcome", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30, color: Color.fromRGBO(84, 114, 230, 1)),),
          SizedBox(height: 15,),
          Text('Please login or sign up to continue using our application', textAlign: TextAlign.center, style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 18),),

          SizedBox(height: 20,),
    Container(
    width: 300,
    height: 300,
    child: Ink.image(image: AssetImage("images/signinpic.jpg"), height:80, width:80, fit: BoxFit.cover),
   /*  decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: NetworkImage('images/signinpic.png'), // Use NetworkImage for web images
              fit: BoxFit.cover,
            ),
          ),*/
    ),
               SizedBox(height: 30,),
               Container(
                 width: 300,
                   height: 50,
                   child:
               ElevatedButton(
                 onPressed: () {
                   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> SignupScreen()));
                 },
                 child: Text('Sign up', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20 ),),
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
               SizedBox(height: 20,),

               Text('Already have an account?', textAlign: TextAlign.center, style: TextStyle(fontSize: 15, color: Colors.grey), ),
               TextButton(onPressed:(){

                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
               }, child: Text('Login', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color.fromRGBO(84, 114, 230, 1)), ),),

               SizedBox(height: 40,),
             ])
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
    // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
