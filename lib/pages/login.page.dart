import 'dart:convert';
import 'dart:io';
import 'package:enext/services/auth.service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './main.page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  AuthService auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue,
              Colors.teal
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter
          )
        ),
        child: _isLoading ? Center(child: CircularProgressIndicator()) : ListView(
          children: <Widget>[
            headerSection(),
            inputSection(),
            buttonSection(),
          ],
        ),
      ),
    );
  }

  Container headerSection() {
    return Container (
      padding: EdgeInsets.symmetric(
       horizontal: 20.0,
       vertical: 30.0 
      ),
      child: Text("ENEXT", style: TextStyle(color: Colors.white)),
    );
  }

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  Container inputSection() {
    return Container(
      padding: EdgeInsets.symmetric(
       horizontal: 20.0,
       vertical: 30.0 
      ),
      margin: EdgeInsets.only(top: 30.0),
      child: Column(
       children: <Widget>[
         customInput("Email", Icons.email, false, emailController),
         SizedBox(height: 30.0,),
         customInput("Password", Icons.lock, true, passwordController),
       ], 
      ),
    );
  }

  TextFormField customInput(String title, IconData icon, bool obscureText, TextEditingController controller) {
    return TextFormField(
      style: TextStyle(color: Colors.white70),
      decoration: InputDecoration(
        hintText: title,
        hintStyle: TextStyle(color: Colors.white70),
        icon: Icon(icon),
      ),
      obscureText: obscureText,
      controller: controller,
    );
  }

  signIn(String email, password) async {
    var result = await auth.login(email, password);

    if(result) {
      setState(() {
        _isLoading = false;
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => MainPage()),
          (route) => false
        );
      });
    }

    


    //print(reply);

    var jsonData = null;
    
    // if(response.statusCode == 200) {
    //   jsonData = json.decode(response.body);
    //   print(jsonData);
    //   setState(() {
    //     _isLoading = false;
    //     sharedPreferences.setString("token", jsonData['token']);
    //     Navigator.of(context).pushAndRemoveUntil(
    //       MaterialPageRoute(builder: (context) => MainPage()), 
    //       (Route<dynamic> route) => false
    //     );
    //   });
    // } else {
    //   print(response.body);
    // }
  }

  Container buttonSection() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40.0,
      padding: EdgeInsets.symmetric(
       horizontal: 15.0,
      ),
      margin: EdgeInsets.only(top: 15.0),
      child: RaisedButton(
        child: Text("Sign In", style: TextStyle(color: Colors.white70)),
        color: Colors.purple,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0)
        ),
        onPressed: () { 
          setState(() {
            _isLoading = true;
          });
          signIn(emailController.text, passwordController.text);
        },
      ),
    );
  }
}