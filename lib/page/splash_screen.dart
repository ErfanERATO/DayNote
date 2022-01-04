import 'dart:async';

import 'package:day_note_/page/note_page.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  startTime(){
    var _duration =  Duration(seconds: 3,);
    return Timer(_duration, navigationPage);
  }

  navigationPage(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>  NotesPage()));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 125,
                height: 125,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/2012642.png"),
                  ),
                ),
              ),
              const SizedBox(
                height: 23,
              ),
              const Text(
                "DayNote",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "assets/fonts/farsi/IRANYekanMobileMedium.ttf",
                    fontWeight: FontWeight.bold,
                    fontSize: 23),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(
              bottom: 30,
            ),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: CircularProgressIndicator(
                valueColor:AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
