import 'package:flutter/material.dart';
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
      body: GridView.count(
      crossAxisCount: 1,
      scrollDirection:Axis.vertical ,
      children: List.generate(content.length, (index) {
        return GestureDetector(
          onTap: ()=>null,
          child: Container(
            decoration: BoxDecoration(
              borderRadius:BorderRadius.circular(10),
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
                        child: Text(needs[index],style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,fontFamily: 'Montserrat'),),
                      )),
                  Expanded(
                    flex: 2,
                    child: Container(
                      margin: EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              'assets/1.jpg'),
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
                             CircleAvatar(
                               radius: 30.0,
                               backgroundImage: AssetImage('assets/user.png'),
                             ),
                             Padding(
                               padding: EdgeInsets.only(top: 10.0,left: 30.0,right: 10.0),
                               child: Text('James Oliver',style: TextStyle(fontSize: 18.0,fontFamily: 'Montserrat'),),
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
                                onTap: null,
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
        );
      }),
    ),
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

