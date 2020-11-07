import 'dart:convert';
import 'package:we_care/screens/update_profile.dart';
import 'package:we_care/services/auth.dart';
// import 'package:we_care/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:http/http.dart' as http;

int _selectedItemIndex = 3;
Map content;

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

String name = '';
String email = '';
String Contactname = '-';
String Contactno = '-';
String uid = '';
String Gender = '-';

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> UserData() async {
    try {
      if (_auth.currentUser != null) {
        name = _auth.currentUser.displayName;
        print(_auth.currentUser.displayName);
        email = _auth.currentUser.email;
        print(_auth.currentUser.email);

        return true;
      }
    } catch (e) {
      print("User Signed Out Failed! $e");
    }
  }

  Future<void> getapi() async {
    try {
      String api = 'https://ar-core-4073a.firebaseio.com/.json';
      http.Response response = await http.get(api);
      content = json.decode(response.body);
      uid = _auth.currentUser.uid;
      setState(() {
        Contactname = content["$uid"]["ContactName"];
        print(Contactname);
        Contactno = content["$uid"]["EmergencyContact"];
        Gender = content["$uid"]["Gender"];
        print(Gender);
      });
    } catch (e) {
      print(e);
    }
  }

  GestureDetector buildNavBarItem(IconData icon, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedItemIndex = index;
        });
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 4,
        height: 60,
        decoration: index == _selectedItemIndex
            ? BoxDecoration(
                border:
                    Border(bottom: BorderSide(width: 4, color: Colors.green)),
                gradient: LinearGradient(colors: [
                  Colors.green.withOpacity(0.3),
                  Colors.green.withOpacity(0.016),
                ], begin: Alignment.bottomCenter, end: Alignment.topCenter))
            : BoxDecoration(),
        child: Icon(
          icon,
          color: index == _selectedItemIndex ? Color(0XFF00B868) : Colors.grey,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    UserData();
    getapi();
    //readFromDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: UserData(),
        builder: (context, snapshot) {
          // Map content = snapshot.data;
          return (snapshot.hasData)
              ? Scaffold(
                  bottomNavigationBar: Row(
                    children: [
                      buildNavBarItem(Icons.home, 0),
                      buildNavBarItem(Icons.map, 1),
                      buildNavBarItem(Icons.monetization_on, 2),
                      buildNavBarItem(Icons.person, 3),
                    ],
                  ),
                  backgroundColor: Colors.white,
                  body: SingleChildScrollView(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/profileBackgroundDark.png"),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 50),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.chevron_left,
                                    color: Colors.white,
                                    size: 40.0,
                                  ),
                                  onPressed: () =>
                                      Navigator.pushNamedAndRemoveUntil(context,
                                          '/dashboard', (route) => false),
                                ),
                              ),
                              Container(
                                  margin: EdgeInsets.only(left: 10, top: 50),
                                  child: Text(
                                    'We Care',
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                        letterSpacing: 1.2),
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                              margin: EdgeInsets.only(left: 30),
                              child: Text(
                                email,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    letterSpacing: 1.2),
                              )),
                          SizedBox(
                            height: 55,
                          ),
                          Container(
                              margin: EdgeInsets.only(left: 250),
                              child: CircleAvatar(
                                radius: 55,
                                backgroundColor: Color(0xff0A0E21),
                                child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 54.0,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(45.0),
                                      child: image != null
                                          ? Image.file(
                                              image,
                                              fit: BoxFit.fill,
                                            )
                                          : Image.asset('assets/user.png',
                                              fit: BoxFit.fill),
                                    )),
                              )),
                          Container(
                            margin: EdgeInsets.only(top: 70, left: 97),
                            child: Text(
                              'User Name',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                  letterSpacing: 1.2),
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 30),
                                child: CircleAvatar(
                                    backgroundColor: Colors.green,
                                    radius: 25.0,
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.white,
                                    )),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Text(
                                name == null ? "" : name,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                    letterSpacing: 1.2),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 15, left: 97),
                            child: Text(
                              'E-mail',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                  letterSpacing: 1.2),
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 30),
                                child: CircleAvatar(
                                    backgroundColor: Colors.green,
                                    radius: 25.0,
                                    child: Icon(
                                      Icons.people,
                                      color: Colors.white,
                                    )),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Text(
                                email,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                    letterSpacing: 1.2),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 15, left: 97),
                            child: Text(
                              'Phone Number',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                  letterSpacing: 1.2),
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 30),
                                child: CircleAvatar(
                                    backgroundColor: Colors.green,
                                    radius: 25.0,
                                    child: Icon(
                                      Icons.call,
                                      color: Colors.white,
                                    )),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              Text(
                                Contactno,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                    letterSpacing: 1.2),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  if (await DeleteAccount()) {
                                    print('Delete Account Successful');
                                    //deleteFromDatabase(uid);
                                    Navigator.pushNamedAndRemoveUntil(context,
                                        '/login_screen', (route) => false);
                                  } else {
                                    print('Error in Deleting Account');
                                    showDialog(
                                        context: context,
                                        builder: (_) => AssetGiffyDialog(
                                              image: Image.asset(
                                                  'assets/error.gif'),
                                              title: Text(
                                                'Please Login Again',
                                                style: TextStyle(
                                                    fontSize: 22.0,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              description: Text(
                                                '',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(),
                                              ),
                                              entryAnimation:
                                                  EntryAnimation.RIGHT,
                                              onlyOkButton: true,
                                              buttonOkColor: Colors.red,
                                              onOkButtonPressed: () =>
                                                  Navigator.pop(context),
                                            ));
                                  }
                                },
                                child: Container(
                                  height: 45,
                                  width: 110,
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(20),
                                          bottomRight: Radius.circular(20))),
                                  child: Center(
                                      child: Text(
                                    'Delete',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  )),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, '/update_profile');
                                  //update profile functionality
                                },
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  child: Icon(
                                    Icons.create,
                                    size: 28,
                                    color: Colors.white,
                                  ),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.green),
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  if (await signOutGoogle()) {
                                    print('LogOut Successful');
                                    Navigator.pushNamedAndRemoveUntil(context,
                                        '/login_screen', (route) => false);
                                  } else {
                                    print('Error in LogOut');
                                    showDialog(
                                        context: context,
                                        builder: (_) => AssetGiffyDialog(
                                              image: Image.asset(
                                                  'assets/error.gif'),
                                              title: Text(
                                                'Please Login Again',
                                                style: TextStyle(
                                                    fontSize: 22.0,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              description: Text(
                                                '',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(),
                                              ),
                                              entryAnimation:
                                                  EntryAnimation.RIGHT,
                                              onlyOkButton: true,
                                              buttonOkColor: Colors.red,
                                              onOkButtonPressed: () =>
                                                  Navigator.pop(context),
                                            ));
                                  }
                                },
                                child: Container(
                                  height: 45,
                                  width: 110,
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          bottomLeft: Radius.circular(20))),
                                  child: Center(
                                      child: Text(
                                    'Log out',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white),
                                  )),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 30.0,
                          )
                        ],
                      ),
                    ),
                  ),
                )
              : Scaffold(
                  //   bottomNavigationBar: bottomnav(_currentIndex, context),
                  backgroundColor: Colors.white,
                  body: Center(
                      child: SpinKitFadingFour(
                    color: Colors.black,
                    size: 90.0,
                  )),
                );
        });
  }
}
