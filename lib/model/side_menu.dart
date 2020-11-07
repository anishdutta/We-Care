import 'package:we_care/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';

String name ='';
String email='';
String img='';

class SideMenu extends StatefulWidget {
  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> UserData() async {
    try
    {
      if (_auth.currentUser != null) {
        name = _auth.currentUser.displayName;
        print(_auth.currentUser.displayName);
        email = _auth.currentUser.email;
        print(_auth.currentUser.email);
        img = _auth.currentUser.photoURL;
        print(_auth.currentUser.photoURL);

        return true;
      }
    }
    catch(e){
      print("Error =  $e");
    }
  }

  @override
  void initState() {
    super.initState();
    UserData();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                UserAccountsDrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.green,
                    ),
                  margin: EdgeInsets.only(bottom: 10.0,),
                    accountName: Padding(
                      padding: const EdgeInsets.only(top:20.0),
                      child: Text('',style: TextStyle(fontSize: 18.0)),
                    ),
                    accountEmail: Text(email,style: TextStyle(fontSize: 18.0)),
                    currentAccountPicture: CircleAvatar(
                      radius: 55,
                      backgroundColor: Color(0xff0A0E21),
                      child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 54.0,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(45.0),
                            child: img==''?Image.asset('assets/profile-user.png',fit: BoxFit.fill):Image.network('$img'),
                          )
                      ),
                    )
                ),
                ListTile(
                  onTap:()=> Navigator.pop(context),
                  title: Text('Home',style: TextStyle(fontSize: 18.0,color: Colors.green,fontFamily: 'Montserrat')),
                  trailing:Icon(Icons.home,size: 30.0,color: Colors.green,) ,
                ),
                ListTile(
                  onTap:()=> Navigator.pushNamedAndRemoveUntil(context, '/about', (route) => false),
                  title: Text('About Us',style: TextStyle(fontSize: 18.0,color: Colors.green,fontFamily: 'Montserrat')),
                  trailing:Icon(Icons.description,size: 30.0,color: Colors.green,) ,
                ),
                ListTile(
                  onTap:()=> Navigator.pushNamedAndRemoveUntil(context, '/form_here', (route) => false),
                  title: Text('Ask To Donate',style: TextStyle(fontSize: 18.0,color: Colors.green,fontFamily: 'Montserrat')),
                  trailing:Icon(Icons.monetization_on,size: 30.0,color: Colors.green,) ,
                ),
                ListTile(
                  onTap:()=> Navigator.pushNamedAndRemoveUntil(context, '/contact', (route) => false),
                  title: Text('Contact Us',style: TextStyle(fontSize: 18.0,color: Colors.green,fontFamily: 'Montserrat')),
                  trailing:Icon(Icons.phone_android,size: 30.0,color: Colors.green,) ,
                ),
              ],
            ),
          ),

          Container(
            // This align moves the children to the bottom
              child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  // This container holds all the children that will be aligned
                  // on the bottom and should not scroll with the above ListView
                  child: Container(
                      child: Column(
                        children: <Widget>[
                          Divider(),
                          ListTile(
                            onTap: () async{
                              if(await signOutGoogle()){
                              print('LogOut Successful');
                              Navigator.pushNamedAndRemoveUntil(
                              context, '/login_screen', (route) => false);
                              }
                              else{
                              print('Error in LogOut');
                              showDialog(
                              context: context,
                              builder: (_) => AssetGiffyDialog(
                              image: Image.asset('assets/error.gif'),
                              title: Text(
                              'Please Login Again',
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
                              }
                            },
                              leading: Icon(Icons.assignment_return,color: Colors.red,size: 30.0,),
                              title: Text('Logout',style: TextStyle(fontSize: 18.0,fontFamily: 'Montserrat')))
                        ],
                      )
                  )
              )
          ),
        ],
      ),
    );
  }
}
