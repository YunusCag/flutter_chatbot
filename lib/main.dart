import 'package:flame_splash_screen/flame_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutterchatbot/screen/home_screen.dart';
import 'package:flutterchatbot/screen/onboarding_screen.dart';
import 'package:flutterchatbot/utilities/shared_pref.dart';

import 'utilities/strings.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/":(context)=>SplashScreen(),
        "home":(context)=>HomeScreen(),
        "splashscreen":(context)=>SplashScreen(),
        "onboarding":(context)=>OnBoardingScreen()
      },
      title: Strings.chatBotName,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SharedPref sharedPref=SharedPref();
    bool firstTime=true;
    sharedPref.getFirstTime().then((value) => firstTime=value);
    print("First Time"+firstTime.toString());

    return FlameSplashScreen(
      theme: FlameSplashTheme.dark,
      showBefore: (context){
        return Text(
          Strings.chatBotName,
          style: TextStyle(
              fontSize: 28,
              color: Colors.white
          ),
        );
      },
      onFinish: (context){

        if(firstTime){
          Navigator.of(context)
              .pushNamedAndRemoveUntil("onboarding",(route)=>false);
        }else{
          Navigator.of(context)
              .pushNamedAndRemoveUntil("home",(route)=>false);
        }


      },
    );
  }
}

