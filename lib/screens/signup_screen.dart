
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:we_care/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

// #272B4D
class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String name = '';

  String email = '';

  String password = '';

  String confirmPassword = '';
  String error = '';
  bool showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        opacity: 0.1,
        progressIndicator: SpinKitFadingCircle(
          size: 70.0,
          color: Colors.green,
        ),
        inAsyncCall: showSpinner,
        child: SafeArea(
          child: Container(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 45,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                          icon: Icon(Icons.keyboard_arrow_left,
                              size: 35.0, color: Colors.blueGrey),
                          onPressed: () => Navigator.pop(context)),
                      Container(
                        margin: const EdgeInsets.only(
                          left: 100.0,
                        ),
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 22,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 55,
                  ),
                  Text(
                    'Welcome',
                    style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 29,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Sign up with your email and password',
                    style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                        onChanged: (value) {
                          name = value;
                        },
                        style: TextStyle(color: Colors.blueGrey),
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.person,
                            color: Colors.blueGrey,
                          ),
                          labelText: 'Name',
                          labelStyle:
                              TextStyle(color: Colors.blueGrey, fontSize: 18),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(32.0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blueGrey, width: 1.5),
                            borderRadius: BorderRadius.all(Radius.circular(32.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(0xFF311EBD), width: 3),
                            borderRadius: BorderRadius.all(Radius.circular(32.0)),
                          ),
                        )),
                  ),
                  SizedBox(
                    height: 45,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                        onChanged: (value) {
                          email = value;
                        },
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(color: Colors.blueGrey),
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.email,
                            color: Colors.blueGrey,
                          ),
                          labelText: 'Email',
                          labelStyle:
                              TextStyle(color: Colors.blueGrey, fontSize: 18),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(32.0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blueGrey, width: 1.5),
                            borderRadius: BorderRadius.all(Radius.circular(32.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(0xFF311EBD), width: 3),
                            borderRadius: BorderRadius.all(Radius.circular(32.0)),
                          ),
                        )),
                  ),
                  SizedBox(
                    height: 45,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                        onChanged: (value) {
                          password = value;
                        },
                        style: TextStyle(color: Colors.blueGrey),
                        obscureText: true,
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.lock,
                            color: Colors.blueGrey,
                          ),
                          labelText: 'Password',
                          labelStyle:
                              TextStyle(color: Colors.blueGrey, fontSize: 18),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(32.0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blueGrey, width: 1.5),
                            borderRadius: BorderRadius.all(Radius.circular(32.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(0xFF311EBD), width: 3),
                            borderRadius: BorderRadius.all(Radius.circular(32.0)),
                          ),
                        )),
                  ),
                  SizedBox(
                    height: 45,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                        onChanged: (value) {
                          confirmPassword = value;
                        },
                        style: TextStyle(color: Colors.blueGrey),
                        obscureText: true,
                        decoration: InputDecoration(
                          suffixIcon: Icon(
                            Icons.lock,
                            color: Colors.blueGrey,
                          ),
                          labelText: 'Confirm Password',
                          labelStyle:
                              TextStyle(color: Colors.blueGrey, fontSize: 18),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(32.0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blueGrey, width: 1.5),
                            borderRadius: BorderRadius.all(Radius.circular(32.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(0xFF311EBD), width: 3),
                            borderRadius: BorderRadius.all(Radius.circular(32.0)),
                          ),
                        )),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  GestureDetector(
                    onTap: () async {
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
                        bool verify = await signUp(email, password);
                        if (verify){
                          setState(() {
                            showSpinner = false;
                          });
                          final _auth = FirebaseAuth.instance;


                          Navigator.pushNamedAndRemoveUntil(
                              context, '/newdash', (route) => false);}
                        else {
                          setState(() {
                            showSpinner = false;
                          });
                          print('SignUp Error');
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
                      }
                    },
                    child: Container(
                      height: 50,
                      width: 150,
                      child: Center(
                          child: Text(
                        'Sign Up',
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      )),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.green,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  bool LoginCheck() {
    String s = "";
    if (email != "" && password != "" && confirmPassword != "") {
      if (password == confirmPassword)
        return false;
      else {
        s = "Password and Confirm Password mismatch";
        setState(() {
          error = s;
          print(error);
        });
        return true;
      }
    } else if (email == "" && password != "" && confirmPassword != "") {
      s = "Please Enter a E-mail ID!";
      setState(() {
        error = s;
        print(error);
      });
      return true;
    } else if (email != "" && password == "" && confirmPassword != "") {
      s = "Please Enter a Password!";
      setState(() {
        error = s;
        print(error);
      });
      return true;
    } else if (email == "" && password == "" && confirmPassword != "") {
      s = "Please fill Email and Password!";
      setState(() {
        error = s;
        print(error);
      });
      return true;
    } else if (email != "" && password != "" && confirmPassword == "") {
      s = "Please Enter the Confirm Password!";
      setState(() {
        error = s;
        print(error);
      });
      return true;
    } else {
      s = "Please fill it Properly!";
      setState(() {
        error = s;
        print(error);
      });
      return true;
    }
  }
}
