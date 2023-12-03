import 'package:get/get.dart';

class PlateController extends GetxController{
  String _plateType = 'شخصي';
  String? _carNumber;

  String get plateType => _plateType;
  String? get carNumber => _carNumber;

  void setPlateTypeWithUpdate(String type){
    _plateType = type;
    update();
  }
  void setCarNumberWithUpdate(String number){
    _carNumber = number;
    update();
  }

  void setPlateTypeWithoutUpdate(String type){
    _plateType = type;
  }
  void setCarNumberWithoutUpdate(String number){
    _carNumber = number;
  }

  void clearOrSetToDefaultPlateTypeWithUpdate() {
    _plateType = 'شخصي';
    update();
  }

  void clearOrSetToDefaultPlateTypeWithoutUpdate() {
    _plateType = 'شخصي';
  }

  void clearOrSetToDefaultCarNumberWithUpdate() {
    _carNumber = null;
    update();
  }

  void clearOrSetToDefaultCarNumberWithoutUpdate() {
    _carNumber = null;
  }
}