import 'package:get_storage/get_storage.dart';

class StoreParkId{
  static final _parkIdBox = GetStorage('park_id');

  static writeInBox(String number, String id){
    StoreParkId._parkIdBox.write(number, id);
  }

  static readFromBox(String number){
    return StoreParkId._parkIdBox.read(number) ?? '';
  }

  static deleteFromBox(String number){
    return StoreParkId._parkIdBox.remove(number);
  }

  static eraseBox()=> StoreParkId._parkIdBox.erase();
}