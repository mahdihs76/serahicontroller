class ServerResponse {
  List<History> history0;
  List<History> history1;
  List<History> history2;

  ServerResponse({this.history0, this.history1, this.history2});

  ServerResponse.fromJson(Map<String, dynamic> json) {
    if (json['0'] != null) {
      history0 = new List<History>();
      json['0'].forEach((v) {
        history0.add(new History.fromJson(v));
      });
    }
    if (json['1'] != null) {
      history1 = new List<History>();
      json['1'].forEach((v) {
        history1.add(new History.fromJson(v));
      });
    }
    if (json['2'] != null) {
      history2 = new List<History>();
      json['2'].forEach((v) {
        history2.add(new History.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.history0 != null) {
      data['history0'] = this.history0.map((v) => v.toJson()).toList();
    }
    if (this.history1 != null) {
      data['history1'] = this.history1.map((v) => v.toJson()).toList();
    }
    if (this.history2 != null) {
      data['history2'] = this.history2.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class History {
  String time;
  String value;

  History({this.time, this.value});

  History.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    value = json['value'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    data['value'] = this.value;
    return data;
  }
}