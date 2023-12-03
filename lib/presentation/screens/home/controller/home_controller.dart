import 'package:get/get.dart';

import '../../../../data/models/end_time/end_time.dart';
import '../../../../data/models/signin/signin.dart';

class HomeController extends GetxController{
  SignInModel? _signInModel;
  SignInModel? get singInModel => _signInModel;
  void setSignInModelWithUpdate(SignInModel? signInModel){
    _signInModel = signInModel;
    update();
  }
  void setSignInModelWithoutUpdate(SignInModel? signInModel){
    _signInModel = signInModel;
    _parkSpaces = _signInModel!.user!.parkSpaces!;
  }

  List<ParkSpaces?> _parkSpaces = [];
  List<ParkSpaces?> get parkSpaces => _parkSpaces;
  void setParkSpaces(List<ParkSpaces?> parkSpaces){
      _parkSpaces = parkSpaces;
  }

  EndTimeModel? _endTimeModel;
  EndTimeModel? get endTimeModel => _endTimeModel;
  void setEndTimeModel(EndTimeModel? endTimeModel){
    _endTimeModel = endTimeModel;
  }

  RxString addPrice = ''.obs;

  void updateHome(){
    update();
  }
}