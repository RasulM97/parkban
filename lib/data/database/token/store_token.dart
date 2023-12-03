import 'package:get_storage/get_storage.dart';

class StoreToken{
  static final _tokenBox = GetStorage('unique token');

  static writeInBox(String token){
    StoreToken._tokenBox.write('token', token);
  }

  static readFromBox(){
    return StoreToken._tokenBox.read('token') ?? '';
  }

  static eraseBox()=> StoreToken._tokenBox.erase();
}