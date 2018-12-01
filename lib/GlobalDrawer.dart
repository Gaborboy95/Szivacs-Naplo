import 'package:flutter/material.dart';
import 'globals.dart';
import 'Datas/User.dart';

BuildContext ctx;

class GDrawer extends StatefulWidget {

  GDrawerState myState;

  @override
  GDrawerState createState() {
    myState = new GDrawerState();
    return myState;
  }
}

class GDrawerState extends State<GDrawer> {
  @override
  void initState() {
    super.initState();
  }

  void _onSelect(User user) async {
    setState(() {
      selectedUser = user;
    });
    switch (screen) {
      case 0:
        Navigator.pop(context); // close the drawer
        Navigator.pushReplacementNamed(context, "/main");
        break;
      case 1:
        Navigator.pop(context); // close the drawer
        Navigator.pushReplacementNamed(context, "/evaluations");
        break;
      case 2:
        Navigator.pop(context); // close the drawer
        Navigator.pushReplacementNamed(context, "/timetable");
        break;
      case 3:
        Navigator.pop(context); // close the drawer
        Navigator.pushReplacementNamed(context, "/notes");
        break;
      case 5:
        Navigator.pop(context); // close the drawer
        Navigator.pushReplacementNamed(context, "/absents");
        break;
      case 6:
        Navigator.pop(context); // close the drawer
        Navigator.pushReplacementNamed(context, "/statistics");
        break;
      case 8:
        Navigator.pop(context); // close the drawer
        Navigator.pushReplacementNamed(context, "/homework");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Drawer(
      child: new ListView(
        children: <Widget>[
          isLogo ? new Container(
            child: new DrawerHeader(
              child: new Column(
                children: <Widget>[
                  Image.asset(
                    "assets/icon.png",
//                  alignment: new Alignment(-1.0, 1.0),
                    height: 120.0,
                    width: 120.0,
                  ),
                  new Row(
                    children: <Widget>[
                      new Container(
                        child: new Text(
                          "e-Szivacs",
                          style: TextStyle(fontSize: 19.0),
                        ),
//                      alignment: new Alignment(-1.0, 1.0),
                        padding: new EdgeInsets.fromLTRB(16.0, 0.0, 5.0, 0.0),
                      ),
                      new Container(
                        child: new Text(
                          "2.0",
                          style:
                          TextStyle(fontSize: 19.0, color: Colors.blueAccent),
                        ),
//                      alignment: new Alignment(-1.0, 1.0),
                      ),
                    ],
                  ),
                  new Row(
                    children: <Widget>[
                      new Container(
                        child: new Text(
                          "made by:",
                          style: TextStyle(
                            fontSize: 19.0,
                          ),
                        ),
//                      alignment: new Alignment(-1.0, 1.0),
                        padding: new EdgeInsets.fromLTRB(16.0, 0.0, 5.0, 4.0),
                      ),
                      new Container(
                        child: new Text(
                          "BoA",
                          style:
                          TextStyle(fontSize: 19.0, color: Colors.blueAccent),
                        ),
//                      alignment: new Alignment(-1.0, 1.0),
                        padding: new EdgeInsets.fromLTRB(0.0, 0.0, 5.0, 4.0),
                      ),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
              padding: EdgeInsets.all(2.0),
            ),
            height: 190.0,
          ) : new Container(height: 5,),
          selectedUser != null && multiAccount ? new Container(
            child: new DrawerHeader(
              child: new PopupMenuButton<User>(
                child: new Container(
                  child: new Row(
                    children: <Widget>[
                      new Container(child: new Icon(
                        Icons.account_circle, color: selectedUser.color,
                        size: 40,), margin: EdgeInsets.only(right: 5),),
                      new Text(selectedUser.name,
                        style: new TextStyle(color: null, fontSize: 17.0),),
                      new Icon(Icons.arrow_drop_down, color: null,),
                    ],
                  ),
                  padding: EdgeInsets.fromLTRB(10.0, 0.0, 5.0, 6.0),
                ),
                onSelected: _onSelect,
                itemBuilder: (BuildContext context) {
                  return users.map((User user) {
                    return new PopupMenuItem<User>(
                        value: user,
                        child: new Row(
                          children: <Widget>[
                            new Icon(Icons.account_circle, color: user.color,),
                            new Text(user.name),
                          ],
                        )
                    );
                  }).toList();
                },
              ),
              padding: EdgeInsets.all(0),
              margin: EdgeInsets.all(0),
            ),
            height: 50,
            padding: EdgeInsets.all(0),
            margin: EdgeInsets.all(0),
          ) : new Container(),
          new ListTile(
            leading: new Icon(
              Icons.home, color: screen == 0 ? Colors.blueAccent : null,),
            title: new Text("Főoldal",
              style: TextStyle(color: screen == 0 ? Colors.blueAccent : null),),
            onTap: () {
              screen = 0;
              Navigator.pop(context); // close the drawer
              Navigator.pushReplacementNamed(context, "/main");
            },
          ),
          new ListTile(
            leading: new Icon(
              Icons.assignment, color: screen == 1 ? Colors.blueAccent : null,),
            title: new Text("Jegyek",
              style: TextStyle(color: screen == 1 ? Colors.blueAccent : null),),
            onTap: () {
              screen = 1;
              Navigator.pop(context); // close the drawer
              Navigator.pushReplacementNamed(context, "/evaluations");
            },
          ),
          new ListTile(
            leading: new Icon(
              IconData(0xf520, fontFamily: "Material Design Icons"),
              color: screen == 2 ? Colors.blueAccent : null,),
            title: new Text("Órarend",
              style: TextStyle(color: screen == 2 ? Colors.blueAccent : null),),
            onTap: () {
              screen = 2;
              Navigator.pop(context); // close the drawer
              Navigator.pushReplacementNamed(context, "/timetable");
            },
          ),
          new ListTile(
            leading: new Icon(
              IconData(0xf2dc, fontFamily: "Material Design Icons"),
              color: screen == 8 ? Colors.blueAccent : null,),
            title: new Text("Házi feladatok",
              style: TextStyle(color: screen == 8 ? Colors.blueAccent : null),),
            onTap: () {
              screen = 8;
              Navigator.pop(context); // close the drawer
              Navigator.pushReplacementNamed(context, "/homework");
            },
          ),
          new ListTile(
            leading: new Icon(
              IconData(0xf0e5, fontFamily: "Material Design Icons"),
              color: screen == 3 ? Colors.blueAccent : null,),
            title: new Text("Faliújság",
              style: TextStyle(color: screen == 3 ? Colors.blueAccent : null),),
            onTap: () {
              screen = 3;
              Navigator.pop(context); // close the drawer
              Navigator.pushReplacementNamed(context, "/notes");
            },
          ),
          new ListTile(
            leading: new Icon(
              Icons.block, color: screen == 5 ? Colors.blueAccent : null,),
            title: new Text("Hiányzások / Késések",
              style: TextStyle(color: screen == 5 ? Colors.blueAccent : null),),
            onTap: () {
              screen = 5;
              Navigator.pop(context); // close the drawer
              Navigator.pushReplacementNamed(context, "/absents");
            },
          ),
          new ListTile(
            leading: new Icon(
              IconData(0xf127, fontFamily: "Material Design Icons"),
              color: screen == 6 ? Colors.blueAccent : null,),
            title: new Text("Statisztikák",
              style: TextStyle(color: screen == 6 ? Colors.blueAccent : null),),
            onTap: () {
              screen = 6;
              Navigator.pop(context); // close the drawer
              Navigator.pushReplacementNamed(context, "/statistics");
            },
          ),
          new ListTile(
            leading: new Icon(Icons.supervisor_account,
              color: screen == 4 ? Colors.blueAccent : null,),
            title: new Text("Fiókok",
              style: TextStyle(color: screen == 4 ? Colors.blueAccent : null),),
            onTap: () {
              screen = 4;
              Navigator.pop(context); // close the drawer
              Navigator.pushReplacementNamed(context, "/accounts");
            },
          ),
          new ListTile(
            leading: new Icon(
              Icons.settings, color: screen == 7 ? Colors.blueAccent : null,),
            title: new Text("Beállítások",
              style: TextStyle(color: screen == 7 ? Colors.blueAccent : null),),
            onTap: () {
              screen = 7;
              Navigator.pop(context); // close the drawer
              Navigator.pushReplacementNamed(context, "/settings");
//            Navigator.pushNamed(context, "/about");
            },
          ),
        ],
      ),
    );
  }
}
