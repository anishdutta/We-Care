import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:we_care/model/side_menu.dart';
GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class NewDash extends StatefulWidget {
  @override
  _NewDashState createState() => _NewDashState();
}

class _NewDashState extends State<NewDash> {
  int _selectedItemIndex = 0;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String name ='';
  String email='';
  String img='';
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
  Widget build(BuildContext context) {

    return Scaffold(
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

      bottomNavigationBar: Row(
        children: [
          GestureDetector(
            onTap: (){
              Navigator.pushNamedAndRemoveUntil(
                  context, '/newdash', (route) => false);
            },
              child: buildNavBarItem(Icons.home, 0)),
          GestureDetector(
            onTap: (){
              print("hey");
              Navigator.pushNamedAndRemoveUntil(
                  context, '/map', (route) => false);
            },
              child: buildNavBarItem(Icons.map, 1)),
          GestureDetector(
            onTap: (){
              Navigator.pushNamedAndRemoveUntil(
                  context, '/form_here', (route) => false);
            },
              child: buildNavBarItem(Icons.monetization_on, 2)),
          GestureDetector(
              onTap: (){
                Navigator.pushNamedAndRemoveUntil(
                    context, '/profile', (route) => false);
              },
              child: buildNavBarItem(Icons.person, 3)),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 250,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0XFF00B686), Color(0XFF00838F)]),
                ),
                child: Padding(
                  padding:
                  const EdgeInsets.only(left: 20, right: 20.0, top: 30),
                  child: Column(
                    children: [

                      Row(
                        children: [
                          Container(
                            width: 80.0,
                            height: 80.0,
                            decoration: BoxDecoration(
                              color: Color(0XFF00B686),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(.1),
                                    blurRadius: 8,
                                    spreadRadius: 3)
                              ],
                              border: Border.all(
                                width: 1.5,
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(40.0),
                            ),
                            padding: EdgeInsets.all(5),
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  "https://images.pexels.com/photos/2167673/pexels-photo-2167673.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=750&w=1260"),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          FutureBuilder(
                            future: UserData(),
    builder: (context, snapshot) {
                              if(snapshot.hasData){
                                return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Text(
      "We care NGO",
      style: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: Colors.white),
      ),
      SizedBox(
      height: 10,
      ),
      Row(
      children: [
      Icon(
      Icons.camera_front,
      color: Colors.white,
      ),
      SizedBox(
      width: 10,
      ),
      RichText(
      text: TextSpan(
      text: "$email",
      style: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      ),
      children: [

      ]),
      )
      ],
      )
      ],
      );
                              }
                              else{
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Christopher Summers",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.camera_front,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        RichText(
                                          text: TextSpan(
                                              text: "\$5320",
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              children: [
                                                TextSpan(
                                                    text: ".50",
                                                    style: TextStyle(
                                                        color: Colors.white38))
                                              ]),
                                        )
                                      ],
                                    )
                                  ],
                                );
                              }
    }

                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  color: Colors.grey.shade100,
                  child: ListView(
                    padding: EdgeInsets.only(top: 55),
                    children: [
                      Text(
                        "People Queries",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: (){
                              Navigator.pushNamedAndRemoveUntil(
                                  context, '/dashboard', (route) => false);
                            },
                            child: buildActivityButton(Icons.card_membership, "Women",
                                Colors.blue.withOpacity(0.2), Color(0XFF01579B)),
                          ),
                          buildActivityButton(
                              Icons.transfer_within_a_station,
                              "Waste",
                              Colors.cyanAccent.withOpacity(0.2),
                              Color(0XFF0097A7)),
                          buildActivityButton(
                              Icons.pie_chart,
                              "Poverty",
                              Color(0XFFD7CCC8).withOpacity(0.4),
                              Color(0XFF9499B7)),

                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          buildActivityButton(Icons.supervised_user_circle, "Diseases",
                              Colors.blue.withOpacity(0.2), Color(0XFF01579B)),
                          buildActivityButton(
                              Icons.lightbulb_outline,
                              "Road",
                              Colors.cyanAccent.withOpacity(0.2),
                              Color(0XFF0097A7)),
                          buildActivityButton(
                              Icons.pie_chart,
                              "Others",
                              Color(0XFFD7CCC8).withOpacity(0.4),
                              Color(0XFF9499B7)),

                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Funds Collected",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      buildCategoryCard(Icons.fastfood, "Food for poor", 120, 20),
                      buildCategoryCard(Icons.flash_on, "Flood relief", 430, 17),
                      buildCategoryCard(Icons.fastfood, "Odissa Pandemic", 120, 20),
                    ],
                  ),
                ),
              )
            ],
          ),
          Positioned(
            top: 135,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              width: MediaQuery.of(context).size.width * 0.85,
              height: 160,
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.05),
                      blurRadius: 8,
                      spreadRadius: 3,
                      offset: Offset(0, 10),
                    ),
                  ],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(50),
                  )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Funds Collected",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.arrow_upward,
                                color: Color(0XFF00838F),
                              )
                            ],
                          ),
                          Text(
                            "\$2 170.90",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                                color: Colors.black87),
                          )
                        ],
                      ),
                      Container(width: 1, height: 50, color: Colors.grey),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Total queries",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.arrow_downward,
                                color: Color(0XFF00838F),
                              )
                            ],
                          ),
                          Text(
                            "1 450.10",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                                color: Colors.black87),
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "You visited 567 queries this month",
                    style: TextStyle(
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    "The total queries is based on your the current location of the ngo",
                    style: TextStyle(
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 1,
                    width: double.maxFinite,
                    color: Colors.grey.withOpacity(0.5),
                  ),

                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  GestureDetector buildNavBarItem(IconData icon, int index) {
    return GestureDetector(

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

  Container buildCategoryCard(
      IconData icon, String title, int amount, int percentage) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      height: 85,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    color: Color(0xFF00B686),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "\$$amount",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "($percentage%)",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  )
                ],
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Stack(
            children: [
              Container(
                height: 5,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: Colors.grey.shade300),
              ),
              Container(
                height: 5,
                width: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: Color(0XFF00B686)),
              ),
            ],
          )
        ],
      ),
    );
  }

  GestureDetector buildActivityButton(
      IconData icon, String title, Color backgroundColor, Color iconColor) {
    return GestureDetector(

      child: Container(
        margin: EdgeInsets.all(10),
        height: 90,
        width: 90,
        decoration: BoxDecoration(
            color: backgroundColor, borderRadius: BorderRadius.circular(10.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: iconColor,
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              title,
              style:
              TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}