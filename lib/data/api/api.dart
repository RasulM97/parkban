import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:parkban/data/models/find_id/find_id.dart';
import '../database/token/store_token.dart';
import '../models/end_time/end_time.dart';
import '../models/signin/signin.dart';
import '../models/send_plate/send_plate.dart';
import '../models/wallet/wallet_model.dart';

class Api {
  static const _url = "http://api.imenparkazar.ir/api";

  static Future<SignInModel?> authSignIn(String username, String password) async {
    SignInModel? signInModel;
    try {
      final response = await http.post(
        Uri.parse("$_url/auth/signin"),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
        encoding: Encoding.getByName('utf-8'),
        body: {"username": username, "password": password},
      );
      if ((response.statusCode == 201 || response.statusCode == 200) && response.body != null) {
        var data = jsonDecode(response.body);
        signInModel = SignInModel.fromJson(data['data']);
      }
    } catch (e) {
      signInModel = null;
    }
    return signInModel;
  }

  static Future<SendPlateModel?> sendPlate(String carNumber, String parkSapce, String plateType) async {
    SendPlateModel? sendPlateModel;
    try {
      final response = await http.post(
        Uri.parse("$_url/park"),
        headers: {"Content-Type": "application/x-www-form-urlencoded", "Authorization": "Bearer ${StoreToken.readFromBox()}"},
        encoding: Encoding.getByName('utf-8'),
        body: {"carNumber": carNumber, "parkSpace": parkSapce, "carType": plateType},
      );
      if ((response.statusCode == 201 || response.statusCode == 200) && response.body != null) {
        var data = jsonDecode(response.body);
        sendPlateModel = SendPlateModel.fromJson(data['data']);
      }
    } catch (e) {
      sendPlateModel = null;
    }
    return sendPlateModel;
  }

  static Future<FindIdModel?> getPlateInfo(String id) async {
    FindIdModel? findIdModel;
    try {
      final response = await http.get(
        Uri.parse("$_url/park/$id"),
        headers: {"Content-Type": "application/x-www-form-urlencoded", "Authorization": "Bearer ${StoreToken.readFromBox()}"},
      );
      if ((response.statusCode == 201 || response.statusCode == 200) && response.body != null) {
        var data = jsonDecode(response.body);
        findIdModel = FindIdModel.fromJson(data['data']);
      }
    } catch (e) {
      findIdModel = null;
    }
    return findIdModel;
  }

  static Future<EndTimeModel?> endTime(String id) async {
    EndTimeModel? endTimeModel;
    try {
      final response = await http.patch(
        Uri.parse("$_url/park/$id"),
        headers: {"Content-Type": "application/x-www-form-urlencoded", "Authorization": "Bearer ${StoreToken.readFromBox()}"},
      );
      if ((response.statusCode == 201 || response.statusCode == 200) && response.body != null) {
        var data = jsonDecode(response.body);
        endTimeModel = EndTimeModel.fromJson(data['data']);
      }
    } catch (e) {
      endTimeModel = null;
    }
    return endTimeModel;
  }

  static Future<bool> increaseAmount(String id, String amount) async {
    bool success = false;
    try {
      final response = await http.post(
        Uri.parse("$_url/wallet/increase"),
        headers: {"Content-Type": "application/x-www-form-urlencoded", "Authorization": "Bearer ${StoreToken.readFromBox()}"},
        encoding: Encoding.getByName('utf-8'),
        body: {
          "user": id,
          "amount": amount,
        },
      );
      if ((response.statusCode == 201 || response.statusCode == 200) && response.body != null) {
        var data = jsonDecode(response.body);
        if (data['statusCode'] == 200) {
          success = true;
        } else {
          success = false;
        }
      }
    } catch (e) {
      success = false;
    }
    return success;
  }

  static Future<EndTimeModel?> setDebt(String id) async {
    EndTimeModel? endTimeModel;
    try {
      final response = await http.get(
        Uri.parse("$_url/park/debt/$id"),
        headers: {"Content-Type": "application/x-www-form-urlencoded", "Authorization": "Bearer ${StoreToken.readFromBox()}"},
      );
      if ((response.statusCode == 201 || response.statusCode == 200) && response.body != null) {
        var data = jsonDecode(response.body);
        endTimeModel = EndTimeModel.fromJson(data['data']);
      }
    } catch (e) {
      endTimeModel = null;
    }
    return endTimeModel;
  }

  static Future<int> debt(String id) async {
    int debt = 0;
    try {
      final response =
          await http.get(Uri.parse("$_url/wallet/debt/$id"), headers: {"Content-Type": "application/x-www-form-urlencoded", "Authorization": "Bearer ${StoreToken.readFromBox()}"});
      if ((response.statusCode == 201 || response.statusCode == 200) && response.body != null) {
        var data = jsonDecode(response.body);
        if (data['statusCode'] == 200) {
          if (data['data']['debt'] > 0) {
            debt = data['data']['debt'];
          }
        } else {
          debt = 0;
        }
      }
    } catch (e) {
      debt = -1;
    }
    return debt;
  }

  static Future<WalletModel?> getWallet(String id) async {
    WalletModel? walletModel;
    try {
      final response = await http
          .get(Uri.parse("$_url/wallet/admin/byOwner/$id"), headers: {"Content-Type": "application/x-www-form-urlencoded", "Authorization": "Bearer ${StoreToken.readFromBox()}"});
      if ((response.statusCode == 201 || response.statusCode == 200) && response.body != null) {
        var data = jsonDecode(response.body);
        walletModel = WalletModel.fromJson(data['data']);
      } else {
        walletModel = null;
      }
    } catch (e) {
      walletModel = null;
    }
    return walletModel;
  }
}
