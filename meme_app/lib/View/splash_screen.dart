import 'package:flutter/material.dart';

// ignore: camel_case_types
class splashscreen extends StatelessWidget {
  const splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      backgroundColor: Colors.white,
      body:  Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
      
        Image(
         image: const AssetImage("assets/images/12862186.jpg"),
                   width: MediaQuery.of(context).size.width,
         height: 300, ),


    //   const  SizedBox(height: 30,), 
       
      const Text("Apna Meme",
        style: TextStyle(fontSize: 40,fontWeight:FontWeight.bold),)      ],

      )
      
        
         

        );

   
  }
}


