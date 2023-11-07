import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hypenettask/home.dart';
import 'package:provider/provider.dart';
import 'auth.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: MyApp(),
    ),
  );
}
//void main() => runApp(new MyApp());
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // Set status bar color to transparent
        statusBarIconBrightness: Brightness.light, // Status bar icons' brightness
      ),
    );

    // Optionally hide the status bar during the splash screen
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    return MaterialApp(
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor:  Color.fromRGBO(84, 114, 230, 1),),
        useMaterial3: true,
      ),
      home:
      AnimatedSplashScreen(
        splash: Column(
            mainAxisAlignment: MainAxisAlignment.start,
       // crossAxisAlignment: CrossAxisAlignment.stretch,// Aligns children to the top
           // crossAxisAlignment: CrossAxisAlignment.stretch, // Centers the children vertically// Aligns children to the center of the Column
        children: [
    Container(
    width: 100,
    height: 100,
    decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/ahme.png'), // Use NetworkImage for web images
              fit: BoxFit.fill,
            ),
          ),),
           Text('AHMED', style: TextStyle(color: Colors.white, fontSize: 30), ),
       // SizedBox(height: 1000,)
        ]
      //Text('AHMED', style: TextStyle(color: Colors.white, fontSize: 30),),]

        //child:Text('\n\n\nAHMED', style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),)
      ), nextScreen: MyHomePage(),
        duration: 3000,
        splashTransition: SplashTransition.fadeTransition, backgroundColor: Color.fromRGBO(84, 114, 230, 1),
      ),

    //  home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
