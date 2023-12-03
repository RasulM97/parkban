class FindIdModel{
  String? id;
  FindCar? car;
  String? parkSpace;
  int? time;
  int? amount;

  FindIdModel({this.id, this.car, this.parkSpace, this.time});

  FindIdModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    car = json['car'] != null ? FindCar.fromJson(json['car']) : null;
    parkSpace = json['parkSpace'];
    time = json['time'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (car != null) {
      data['car'] = car!.toJson();
    }
    data['parkSpace'] = parkSpace;
    data['time'] = time;
    data['amount'] = amount;
    return data;
  }
}

class FindCar {
  String? number;
  String? carType;
  String? id;

  FindCar({this.number, this.carType, this.id});

  FindCar.fromJson(Map<String, dynamic> json) {
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
