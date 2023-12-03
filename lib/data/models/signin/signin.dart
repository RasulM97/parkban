class SignInModel {
  User? user;
  String? token;
  String? message;
  int? statusCode;

  SignInModel({this.user, this.token, this.message, this.statusCode});

  SignInModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    token = json['token'];
    message = json['message'];
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['token'] = token;
    data['message'] = message;
    data['statusCode'] = statusCode;
    return data;
  }
}

class User {
  String? id;
  int? createAt;
  bool? isDeleted;
  int? updateAt;
  String? firstname;
  String? lastname;
  String? fullname;
  String? username;
  String? nationalNumber;
  Wallet? wallet;
  List<ParkSpaces>? parkSpaces;

  User(
      {this.id,
        this.createAt,
        this.isDeleted,
        this.updateAt,
        this.firstname,
        this.lastname,
        this.fullname,
        this.username,
        this.nationalNumber,
        this.wallet,
        this.parkSpaces});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createAt = json['createAt'];
    isDeleted = json['isDeleted'];
    updateAt = json['updateAt'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    fullname = json['fullname'];
    username = json['username'];
    nationalNumber = json['nationalNumber'];
    wallet =
    json['wallet'] != null ? Wallet.fromJson(json['wallet']) : null;
    if (json['parkSpaces'] != null) {
      parkSpaces = <ParkSpaces>[];
      json['parkSpaces'].forEach((v) {
        parkSpaces!.add(ParkSpaces.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['createAt'] = createAt;
    data['isDeleted'] = isDeleted;
    data['updateAt'] = updateAt;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['fullname'] = fullname;
    data['username'] = username;
    data['nationalNumber'] = nationalNumber;
    if (wallet != null) {
      data['wallet'] = wallet!.toJson();
    }
    if (parkSpaces != null) {
      data['parkSpaces'] = parkSpaces!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Wallet {
  String? id;
  int? createAt;
  bool? isDeleted;
  int? updateAt;
  int? money;

  Wallet({this.id, this.createAt, this.isDeleted, this.updateAt, this.money});

  Wallet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createAt = json['createAt'];
    isDeleted = json['isDeleted'];
    updateAt = json['updateAt'];
    money = json['money'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['createAt'] = createAt;
    data['isDeleted'] = isDeleted;
    data['updateAt'] = updateAt;
    data['money'] = money;
    return data;
  }
}

class ParkSpaces {
  String? id;
  int? number;
  String? description;

  ParkSpaces({this.id, this.number, this.description});

  ParkSpaces.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    number = json['number'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['number'] = number;
    data['description'] = description;
    return data;
  }
}
