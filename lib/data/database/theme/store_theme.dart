import 'package:get_storage/get_storage.dart';

class ThemeStorage{
  static final _themeBox = GetStorage('theme');

  static writeInBox(String name, dynamic value){
    ThemeStorage._themeBox.write(name, value);
  }

  static readFromBox(String name){
    return ThemeStorage._themeBox.read(name) ?? false;
  }
}