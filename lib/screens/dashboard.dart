import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'package:we_care/model/side_menu.dart';
import 'package:share/share.dart';

GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
List<String> content=[
  'Arise Ample',
];
String dummy = 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry ';
List<String> needs=[
  'Blanket Needed For Aged People',
];
final FirebaseAuth _auth = FirebaseAuth.instance;
final dbRef = FirebaseDatabase.instance.reference().child("Waste_Management");
List<Map<dynamic, dynamic>> lists = [];
String uid='-MLXOE1tu_G4EZbCgjom';
Future<Map> UserData() async {
  try
  {
    if (_auth.currentUser != null) {
      Response response = await get('https://cbs-ngo.firebaseio.com/Waste_Management.json');
      Map data = jsonDecode(response.body);
      //uid = _auth.currentUser.uid;
      return data;
    }
  }
  catch(e){
    print(e);
  }
}


class Dashboard extends StatefulWidget {
  List<String> get lists => List.generate(10, (index) => "Text $index");

  @override
  _DashboardState createState() => _DashboardState();
}

//'Electronics','Cultural Heritage'

class _DashboardState extends State<Dashboard> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        key: _scaffoldKey,
        appBar:  AppBar(
          leading: IconButton(
            icon: Icon(Icons.menu, color: Colors.black,size: 30.0,), // set your color here
            onPressed: () { _scaffoldKey.currentState.openDrawer();},
          ),
          title: Text('We Care'),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0.0,
          actions: [
            IconButton(
              onPressed: () {
                // showSearch(context: context, delegate: Search(widget.lists));
              },
              icon: Icon(Icons.search,color: Colors.black,size: 30.0,),
            )
          ],
        ),
      drawer: SideMenu(),
      body: FutureBuilder(
        future: dbRef.once(),
        builder: (context, snapshot) {
          Map content = snapshot.data;
          print(content);
          return  (snapshot.hasData)?GridView.count(
            crossAxisCount: 1,
            scrollDirection:Axis.vertical ,
            children: List.generate(content.length, (index) {
              return GestureDetector(
                onTap: ()=>null,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  margin: EdgeInsets.all(20.0),
                  elevation: 10.0,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius:BorderRadius.circular(20),
                        color: Colors.grey[300]
                    ),
                    margin: EdgeInsets.all(10.0),
                    child: Container(
                      child: Column(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Padding(
                                padding: EdgeInsets.only(top: 10.0,left: 10.0,right: 10.0),
                                child: Text(content[uid]['Condition'],style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,fontFamily: 'Montserrat'),),
                              )),
                          Expanded(
                            flex: 2,
                            child: Container(
                              margin: EdgeInsets.fromLTRB(10.0, 0, 10.0, 8),
                              decoration: BoxDecoration(
                                borderRadius:BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: NetworkImage(content[uid]['Photo']),
                                  fit: BoxFit.fill,
                                ),

                              ),
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child:Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(width: 10.0,),
                                    CircleAvatar(
                                      radius: 30.0,
                                      backgroundImage: AssetImage('assets/user.png'),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10.0,left: 30.0,right: 10.0),
                                      child: Text(content[uid]['Name'],style: TextStyle(fontSize: 18.0,fontFamily: 'Montserrat'),),
                                    ),
                                    Spacer(),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10.0,left: 0.0,right: 20.0),
                                      child: Text('1h ago',style: TextStyle(fontSize: 18.0,fontFamily: 'Montserrat'),),
                                    ),
                                  ],
                                ),
                              )
                          ),
                          Expanded(
                              flex: 1,
                              child:Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *0.20,
                                      padding: EdgeInsets.only(top: 10.0,left: 30.0,right: 10.0),
                                      child: GestureDetector(
                                        onTap: null,
                                        child: Image.asset('assets/donation.png'),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *0.20,
                                      padding: EdgeInsets.only(top: 10.0,left: 30.0,right: 10.0),
                                      child: GestureDetector(
                                        onTap: ()=>Navigator.pushNamed(context, '/map'),
                                        child: Image.asset('assets/location.png'),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width *0.20,
                                      padding: EdgeInsets.only(top: 10.0,left: 30.0,right: 10.0),
                                      child: GestureDetector(
                                        onTap: ()=>share(context, dummy),
                                        child: Image.asset('assets/share.png'),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
          ):Container(
            child: SpinKitFadingCircle(
              size: 70.0,
              color: Colors.green,
            ),
          );
        },
      )
    );
  }

 

  share(BuildContext context,String text) {
    print('Shared Press');
    final RenderBox box = context.findRenderObject();
    Share.share('Sample Text 1',
        subject: 'Sample Text 2',
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }
}

