class WalletModel {
  String? id;
  int? createAt;
  bool? isDeleted;
  int? updateAt;
  int? money;

  WalletModel(
      {this.id, this.createAt, this.isDeleted, this.updateAt, this.money});

  WalletModel.fromJson(Map<String, dynamic> json) {
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
