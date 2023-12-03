import 'package:get_storage/get_storage.dart';

class StoreReserve{
  static final _reserveBox = GetStorage('reserve');

  static writeInBox(String number, String id){
    _reserveBox.write(number, id);
  }

  static readFromBox(String number){
    return _reserveBox.read(number) ?? '';
  }

  static deleteFromBox(String number){
    return _reserveBox.remove(number);
  }

  static eraseBox()=> StoreReserve._reserveBox.erase();
}