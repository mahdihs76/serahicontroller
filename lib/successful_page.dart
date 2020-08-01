import 'package:flutter/material.dart';
import 'package:serahicontroller/chart.dart';
import 'package:serahicontroller/model.dart';

class SuccessfulScreen extends StatefulWidget {

  SuccessfulScreen({Key key}) : super(key: key);

  @override
  _SuccessfulScreenState createState() => _SuccessfulScreenState();
}

class _SuccessfulScreenState extends State<SuccessfulScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 28, 31, 56),
      body: Column(
        children: <Widget>[
          SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Icon(Icons.close, color: Colors.white, size: 40),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 180,
          ),
          Container(
            padding: const EdgeInsets.all(48.0),

              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black38),
                  borderRadius: BorderRadius.all(Radius.circular(100)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  spreadRadius: 8,
                  blurRadius: 10,
                  offset: Offset(0,0)
                )
              ]),
              child: Icon(
                Icons.check,
                color: Colors.white,
                size: 60,
              )),
          SizedBox(height: 40),
          Text("Smart Power Timer\n Enabled", style: TextStyle(color: Colors.white, fontSize: 24),textAlign: TextAlign.center,),
          SizedBox(height: 40),
          Container(
            width: 140,
            height: 55,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  side: BorderSide(color: Color.fromARGB(255, 28, 31, 56))),
              color: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Show History"),
            ),
          ),
        ],
      ),
    );
  }
}
