import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:serahicontroller/home.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Color.fromARGB(255, 28, 31, 56),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.width * 0.16),
                child: Image.asset("assets/serahi.png"),
              ),
              Text("3Rahi Controller",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 30),
                  textAlign: TextAlign.center),
              SizedBox(height: 15),
              Text("Welcome",
                  style: TextStyle(color: Colors.white30, fontSize: 24)),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(left: 36.0, right: 36.0),
                child: TextFormField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    labelText: "Username or email",
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(30.0),
                      ),
                    ),
                    prefixIcon: Icon(Icons.account_circle),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 36.0, right: 36.0),
                child: TextFormField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    labelText: "Password",
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(30.0),
                      ),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    prefixIcon: Icon(Icons.vpn_key),
                  ),
                ),
              ),
              SizedBox(height: 25),
              Container(
                width: 140,
                height: 55,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      side: BorderSide(color: Colors.red)),
                  color: Color.fromARGB(255, 251, 51, 83),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => HomeScreen()));
                  },
                  child: Text("Login", style: TextStyle(fontSize: 16)),
                ),
              )
            ],
          ),
        ),
      );
}
