import 'package:get_storage/get_storage.dart';

class StorePlate{
  static final _reserveBox = GetStorage('plate');

  static writeInBox(String number, Map<String, String> plateInfo){
    _reserveBox.write(number, plateInfo);
  }

  static readFromBox(String number){
    return _reserveBox.read(number) ?? {"plateType": 'شخصي', 'plateNo': ''};
  }

  static deleteFromBox(String number){
    return _reserveBox.remove(number);
  }

  static eraseBox()=> StorePlate._reserveBox.erase();
}