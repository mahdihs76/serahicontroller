import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:serahicontroller/model.dart';

ServerResponse cachedResponse;

getSpots() {
  List<FlSpot> list = List();
  for (History history in cachedResponse.history0) {
    double x = DateTime.parse(history.time).day * 100.0 +
        DateTime.parse(history.time).second;
    list.add(FlSpot(x, max(double.parse(history.value), 0)));
  }
  list.sort((a, b) => a.x > b.x ? -1 : 1);
  return list;
}
