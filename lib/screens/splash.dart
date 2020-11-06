import 'dart:async';
import 'package:flutter/material.dart';
import 'package:we_care/services/auth.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Center(
            child: Container(
              margin: EdgeInsets.only(top: 60.0),
              width: MediaQuery.of(context).size.width *0.50,
              height:MediaQuery.of(context).size.height *0.20,
              child: Image.asset('assets/login.png',fit: BoxFit.fill,),
            ),
          )
      ),
    );
  }

  void getUser() async {
    bool verify = await UserAuth();
    if (verify)
      Timer(
          Duration(seconds: 2),
              () => Navigator.pushNamedAndRemoveUntil(
              context, '/dashboard', (route) => false));
    else
      Timer(
          Duration(seconds: 2),
              () => Navigator.pushNamedAndRemoveUntil(
              context, '/login_screen', (route) => false));
  }

}

