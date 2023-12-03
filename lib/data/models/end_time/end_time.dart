class EndTimeModel {
  EndTimePark? park;
  int? payment;

  EndTimeModel({this.park, this.payment});

  EndTimeModel.fromJson(Map<String, dynamic> json) {
    park = json['park'] != null ? EndTimePark.fromJson(json['park']) : null;
    payment = json['payment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (park != null) {
      data['park'] = park!.toJson();
    }
    data['payment'] = payment;
    return data;
  }
}

class EndTimePark {
  String? id;
  EndTimeCar? car;
  String? parkSpace;
  int? time;

  EndTimePark({this.id, this.car, this.parkSpace, this.time});

  EndTimePark.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    car = json['car'] != null ? EndTimeCar.fromJson(json['car']) : null;
    parkSpace = json['parkSpace'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (car != null) {
      data['car'] = car!.toJson();
    }
    data['parkSpace'] = parkSpace;
    data['time'] = time;
    return data;
  }
}

class EndTimeCar {
  String? number;
  String? carType;
  String? id;

  EndTimeCar({this.number, this.carType, this.id});

  EndTimeCar.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    carType = json['carType'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['number'] = number;
    data['carType'] = carType;
    data['id'] = id;
    return data;
  }
}
