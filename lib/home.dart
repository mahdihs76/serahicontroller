import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:serahicontroller/cache.dart';
import 'package:serahicontroller/chart.dart';
import 'package:serahicontroller/successful_page.dart';

import 'model.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
          body: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Color.fromARGB(255, 28, 31, 56),
          appBar: AppBar(
            title: Center(
                child: Column(
              children: <Widget>[
                Text("Timer"),
                Text(
                  "Enabling Power",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                )
              ],
            )),
            backgroundColor: Color.fromARGB(255, 21, 24, 45),
            bottom: TabBar(
              indicatorColor: Colors.red,
              tabs: [
                Tab(
                    icon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset("assets/timer.png"),
                )),
                Tab(
                    icon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset("assets/history.png"),
                )),
                Tab(
                    icon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset("assets/setting.png"),
                )),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              _timerWidget(),
              _historyWidget(),
              Text(""),
            ],
          ),
        ),
      ));

  final items = ['Branch A', 'Branch B', 'Branch C'];
  String selectedItem;

  _historyWidget() => Container(
      padding: const EdgeInsets.only(top: 100),child: LineChartSample2());

  _timerWidget() => Container(
        child: Column(
          children: <Widget>[
            SizedBox(height: 40),
            Container(
              padding: EdgeInsets.only(right: 12, left: 12),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Color.fromARGB(255, 21, 24, 45),
                  borderRadius: BorderRadius.all(Radius.circular(40))),
              child: DropdownButton(
                underline: SizedBox(),
                dropdownColor: Color.fromARGB(255, 21, 24, 45),
                onChanged: (value) {
                  setState(() {
                    selectedItem = value;
                  });
                },
                value: selectedItem == null ? items[0] : selectedItem,
                items: items
                    .map((String value) => DropdownMenuItem(
                          value: value,
                          child: new Text(
                            value,
                            style: TextStyle(color: Colors.white30),
                          ),
                        ))
                    .toList(),
              ),
            ),
            _timerIndicatorWidget(),
            SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 80,
                    height: 55,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          side: BorderSide(color: Colors.red)),
                      color: Color.fromARGB(255, 251, 51, 83),
                      onPressed: () {_doConfig(context, true); },
                      child: Icon(Icons.highlight),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 80,
                    height: 55,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          side: BorderSide(color: Colors.red)),
                      color: Color.fromARGB(255, 251, 51, 83),
                      onPressed: () {_doConfig(context, false); },
                      child: Icon(Icons.highlight_off),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      );

  String prepareInput(bool isOn){
    if(isOn){
      switch(selectedItem){
        case "Branch A":
          return "1 $selectedTime\n0\n0\n20";
        case "Branch B":
          return "0\n1 $selectedTime\n0\n20";
        case "Branch C":
          return "0\n0\n1 $selectedTime\n20";
        default:
          return "1\n1\n1\n20";
      }
    } else {
      switch(selectedItem){
        case "Branch A":
          return "0 $selectedTime\n0\n0\n20";
        case "Branch B":
          return "0\n0 $selectedTime\n0\n20";
        case "Branch C":
          return "0\n0\n0 $selectedTime\n20";
        default:
          return "0\n0\n0\n20";
      }
    }

  }

  void _doConfig(BuildContext context, bool isOn) async {
    try {
      final response = await config(prepareInput(isOn));
      cachedResponse = response;
      Navigator.push(context, MaterialPageRoute(builder: (context) => SuccessfulScreen()));
    } on Exception catch(_){
      print("exception");
    }

  }

  Future<ServerResponse> config(String input)async{
    final response = await http.post("https://cm8g6.sse.codesandbox.io/configs/", body: input);
    if (response.statusCode == 200) {
      return ServerResponse.fromJson(json.decode(response.body));
    }else{
      throw Exception('Failed to load post');
    }
  }

  Offset tapPoint = Offset.zero;
  int selectedTime = 25;

  _timerIndicatorWidget() => GestureDetector(
        onTapDown: (details) {
          setState(() {
            tapPoint = details.localPosition;
            Offset origin = Offset(100, 180);
            double value;
            final tapTeta =
                atan((origin.dy - tapPoint.dy) / (tapPoint.dx - origin.dx));
            if (tapPoint.dx > 100) {
              value = 270 - tapTeta * 180 / pi;
            } else {
              value = 90 - tapTeta * 180 / pi;
            }
            selectedTime = (value / 360 * 60).floor();
          });
        },
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            CustomPaint(
              size: Size(MediaQuery.of(context).size.width / 2,
                  MediaQuery.of(context).size.height / 2),
              painter: DrawLine(tapPoint: tapPoint),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0, right: 8.0),
              child: Column(
                children: <Widget>[
                  Text(
                    selectedTime != null ? "$selectedTime" : "0",
                    style: TextStyle(fontSize: 32, color: Colors.white),
                  ),
                  Text("second",
                      style: TextStyle(fontSize: 24, color: Colors.white)),
                ],
              ),
            ),
          ],
        ),
      );
}

class DrawLine extends CustomPainter {
  Offset tapPoint;

  DrawLine({this.tapPoint});

  getColorPaint(Color color, bool isSmall) => Paint()
    ..color = color
    ..strokeCap = StrokeCap.round
    ..style = PaintingStyle.fill
    ..strokeWidth = isSmall ? 2 : 3;

  @override
  void paint(Canvas canvas, Size size) {
    final blackPaint = getColorPaint(Colors.black, true);
    final greyPaint = getColorPaint(Colors.white12, true);
    final redPaint = getColorPaint(Color.fromARGB(255, 251, 51, 83), false);
    Offset origin = Offset(100, 180);
    if (tapPoint == null) {
      drawIndicator(origin, pi / 2, 80, 5, canvas, blackPaint, redPaint);
      drawIndicator(origin, pi / 2, 60, 2, canvas, greyPaint, greyPaint);
    } else {
      final tapTeta =
          atan((origin.dy - tapPoint.dy) / (tapPoint.dx - origin.dx));
      drawIndicator(origin, tapTeta, 80, 5, canvas, blackPaint, redPaint);
      drawIndicator(origin, tapTeta, 60, 2, canvas, greyPaint, greyPaint);
    }
  }

  void drawIndicator(Offset origin, double tapTeta, int radius, double distance,
      Canvas canvas, Paint disabledPaint, Paint activePaint) {
    double lastLineAngle = double.negativeInfinity;
    bool lastLineArc = true;

    for (double teta = -pi / 2; teta <= pi / 4; teta += 0.2) {
      List<Offset> line = _calculateLine(radius, distance, teta, true);
      if (tapPoint != null && tapPoint.dx < origin.dx) {
        canvas.drawLine(line[0], line[1], disabledPaint);
      } else if (teta < tapTeta * -1) {
        if (teta > lastLineAngle) {
          lastLineAngle = teta;
          lastLineArc = true;
        }
        canvas.drawLine(line[0], line[1], activePaint);
      } else {
        canvas.drawLine(line[0], line[1], disabledPaint);
      }
    }

    for (double teta = -pi / 4; teta <= pi / 2; teta += 0.2) {
      List<Offset> line = _calculateLine(radius, distance, teta, false);
      if (tapPoint != null && tapPoint.dx > origin.dx) {
        if (-pi / 2 > lastLineAngle) lastLineAngle = -pi / 2;
        canvas.drawLine(line[0], line[1], activePaint);
      } else if (teta < tapTeta * -1) {
        lastLineAngle = teta;
        lastLineArc = false;
        canvas.drawLine(line[0], line[1], activePaint);
      } else {
        canvas.drawLine(line[0], line[1], disabledPaint);
      }
    }

    List<Offset> line =
        _calculateLine(radius, distance * 1.15, lastLineAngle, lastLineArc);
    canvas.drawLine(line[0], line[1], activePaint);
  }

  abs(double x) => x >= 0 ? x : -1 * x;

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  _calculateLine(int radius, double distance, double teta, bool firstArc) {
    double m = tan(teta);
    double x0;
    double x;
    double xBase = 100;
    double yBase = 180;
    if (firstArc) {
      x0 = radius / sqrt(m * m + 1);
      x = x0 + (distance * distance) / sqrt(m * m + 1);
    } else {
      x0 = -radius / sqrt(m * m + 1);
      x = x0 - (distance * distance) / sqrt(m * m + 1);
    }
    double y0 = m * x0;
    double y = m * x;
    return [Offset(x0 + xBase, y0 + yBase), Offset(x + xBase, y + yBase)];
  }
}
