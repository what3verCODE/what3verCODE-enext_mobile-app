import 'package:enext/pages/login.page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  SharedPreferences sharedPreferences;

  @override
  void initState() {
    super.initState();

    checkLoginStatus();
  }

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();

    if(sharedPreferences.getString("token") == null) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginPage(),),
        (Route<dynamic> route) => false
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ENEXT", style: TextStyle(color: Colors.white),),
        actions: <Widget>[
          FlatButton(
            child: Text("Logout", style: TextStyle(color: Colors.white),),
            onPressed: () {
              sharedPreferences.clear();
              sharedPreferences.commit();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => LoginPage(),),
                (Route<dynamic> route) => false
              );
            },
          )
        ],
      ),
      body: Center(
        child: Text("Main Page"),
      ),
      drawer: Drawer(),
    );
  }
}