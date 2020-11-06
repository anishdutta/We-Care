import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:we_care/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = '';

  String password = '';
  bool isselect = true;
  int key = 0;
  String error = '';
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        opacity: 0.1,
        progressIndicator: SpinKitFadingCircle(
          size: 70.0,
          color: Colors.green,
        ),
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.only(left:15.0,right: 10.0),
          child: SafeArea(
            child: Container(
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                   Row(
                     mainAxisAlignment: MainAxisAlignment.start,
                     children: [
                       Padding(
                         padding: const EdgeInsets.fromLTRB(20.0,28.0,20.0,0.0),
                         child: Text(
                           'Sign In',
                           style: TextStyle(
                             fontSize: 30,
                             fontWeight: FontWeight.bold,),
                         ),
                       ),
                     ],
                   ),

                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),

                    Container (
                        padding: const EdgeInsets.fromLTRB(20.0,0.0,20.0,10.0),
                        child: new Container(
                          child:TextFormField(
                            decoration: new InputDecoration(
                              labelText: "Enter Email",
                              fillColor: Colors.white,
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                                borderSide: new BorderSide(
                                ),
                              ),
                              //fillColor: Colors.green
                            ),
                            onChanged: (value) {
                              email = value;
                            },
                            keyboardType: TextInputType.emailAddress,
                            style: new TextStyle(
                              fontFamily: "Poppins",
                            ),
                          ),
                        )
                    ),

                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.07,
                    ),
                    Container (
                        padding: const EdgeInsets.fromLTRB(20.0,0.0,20.0,10.0),
                        child: new Container(
                          child:TextFormField(
                            obscureText: isselect,
                            decoration: new InputDecoration(
                              labelText: "Enter Password",
                              fillColor: Colors.white,
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(25.0),
                                borderSide: new BorderSide(
                                ),
                              ),
                              suffixIcon: IconButton(
                                icon: (key % 2 == 0)
                                    ? Image.asset(
                                  'assets/closed_eye.png',
                                  scale: 8.0,
                                )
                                    : Icon(
                                  Icons.remove_red_eye,
                                ),
                                onPressed: () {
                                  if (key % 2 == 0) {
                                    setState(() {
                                      isselect = false;
                                      key = key + 1;
                                    });
                                  } else {
                                    setState(() {
                                      isselect = true;
                                      key = key + 1;
                                    });
                                  }
                                },
                              ),
                              //fillColor: Colors.green
                            ),
                            onChanged: (value) {
                              password = value;
                            },
                            keyboardType: TextInputType.text,
                            style: new TextStyle(
                              fontFamily: "Poppins",
                            ),
                          ),
                        )
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: (){},
                          child: Text('Forget Password?',style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,color: Colors.blueGrey),),
                        )
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Container(
                      // padding: EdgeInsets.only(left: 20.0),
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.06,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            side: BorderSide(color: Colors.green)),
                        color:  Colors.green,
                        textColor: Colors.white,
                        child: Text("Sign in",
                            style: TextStyle(fontSize: 20,fontFamily: 'Montserrat')),
                        onPressed:() async {
                          setState(() {
                            showSpinner = true;
                          });

                          if (LoginCheck()) {
                            setState(() {
                              showSpinner = false;
                            });
                            showDialog(
                                context: context,
                                builder: (_) => AssetGiffyDialog(
                                  image: Image.asset('assets/error.gif'),
                                  title: Text(
                                    error,
                                    style: TextStyle(
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  description: Text(
                                    '',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(),
                                  ),
                                  entryAnimation: EntryAnimation.RIGHT,
                                  onlyOkButton: true,
                                  buttonOkColor: Colors.red,
                                  onOkButtonPressed: () => Navigator.pop(context),
                                ));
                          } else {
                            print(email);
                            print(password);
                            bool verify = await signIn(email, password);
                            if (verify)
                            {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, '/dashboard', (route) => false);}
                            else {
                              setState(() {
                                showSpinner = false;
                              });
                              print('Login Error');
                              showDialog(
                                  context: context,
                                  builder: (_) => AssetGiffyDialog(
                                    cornerRadius: 50.0,
                                    image: Image.asset('assets/error.gif'),
                                    title: Text(
                                      'Please Try Again!',
                                      style: TextStyle(
                                          fontSize: 22.0,
                                          fontWeight: FontWeight.w600,fontFamily: 'Montserrat'),
                                    ),
                                    description: Text(
                                      '',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(),
                                    ),
                                    entryAnimation: EntryAnimation.RIGHT,
                                    onlyOkButton: true,
                                    buttonOkColor: Colors.red,
                                    onOkButtonPressed: () =>
                                        Navigator.pop(context),
                                  ));
                            }
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Padding(
                      padding:EdgeInsets.only(top: 5.0,bottom: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don\'t have an account?\t  ',
                            style: TextStyle(
                                color: Colors.green,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.pushNamed(context, '/signup_screen'),
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Text(
                      'Or',
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    SignInButton(
                      Buttons.GoogleDark,
                      onPressed: () async {
                        setState(() {
                          showSpinner = true;
                        });
                        bool verify = await signInWithGoogle();
                        if (verify) {
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/dashboard', (route) => false);
                        } else {
                          print('Login Error');
                          setState(() {
                            showSpinner = false;
                          });
                          showDialog(
                              context: context,
                              builder: (_) => AssetGiffyDialog(
                                cornerRadius: 50.0,
                                image: Image.asset('assets/error.gif'),
                                title: Text(
                                  'Please Try Again!',
                                  style: TextStyle(
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.w600),
                                ),
                                description: Text(
                                  '',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(),
                                ),
                                entryAnimation: EntryAnimation.RIGHT,
                                onlyOkButton: true,
                                buttonOkColor: Colors.red,
                                onOkButtonPressed: () =>
                                    Navigator.pop(context),
                              ));
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),

      bottomNavigationBar: null,

    );
  }

  // ignore: non_constant_identifier_names
  bool LoginCheck() {
    String s = "";
    if (email != "" && password != "") {
      return false;
    } else if (email == "" && password != "") {
      s = "Please Enter a E-mail ID!";
      setState(() {
        error = s;
        print(error);
      });
      return true;
    } else if (email != "" && password == "") {
      s = "Please Enter a Password!";
      setState(() {
        error = s;
        print(error);
      });
      return true;
    } else {
      s = "Please fill Email and Password!";
      setState(() {
        error = s;
        print(error);
      });
      return true;
    }
  }
}
