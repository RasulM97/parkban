class SendPlateModel {
  String? id;
  Car? car;
  String? parkSpace;
  int? time;

  SendPlateModel({this.id, this.car, this.parkSpace});

  SendPlateModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    car = json['car'] != null ? Car.fromJson(json['car']) : null;
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

class Car {
  String? number;
  String? carType;
  String? id;

  Car({this.number, this.carType, this.id});

  Car.fromJson(Map<String, dynamic> json) {
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
