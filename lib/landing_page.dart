import 'package:flutter/cupertino.dart';
 import 'package:flutter/material.dart';


class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
  body: Container(

    child: Column(
      children: [
        Image.asset("images/techtimes.jpeg",
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height/1.7,
        fit: BoxFit.cover,
        )
      ],
    ),
  ),


    );
  }
}
