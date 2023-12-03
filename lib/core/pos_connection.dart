import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:parkban/core/plate_helper.dart';

class PosConnection{
  static Future<String> sendToPay(String amount, String plateNo, String time, String plateType) async {
    String changedPlate = '';
    if(plateType.isNotEmpty){
       changedPlate = changePlateStructureForPrinting(plateType, plateNo);
    }else{
      changedPlate = plateNo;
    }
    debugPrint('plaaateee $changedPlate');
    const platform = MethodChannel('send.flutter.transaction/pos');
    try {
      return await platform.invokeMethod('payment', {'amount': amount, 'plate': changedPlate, 'time': time});
    } on PlatformException catch (e) {
     return "Error";
    }
  }
}