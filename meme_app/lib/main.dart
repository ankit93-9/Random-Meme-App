import 'package:flutter/material.dart';
import 'package:meme_app/View/main_Screen.dart';
// ignore: unused_import
import 'package:meme_app/View/splash_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool showSplash = true;
  showSplashScreen(){
    Future.delayed( const Duration(seconds: 5),(){
setState(() {
  showSplash = false;
});
    });
  }
   @override
    void initState() {
    showSplashScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Apna Meme",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  showSplash ? splashScreen() : const MainScreen(),
    );
  }
  
  splashScreen() {}
  
}
      
        
     