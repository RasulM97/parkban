import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:parkban/core/plate_helper.dart';
import 'package:parkban/core/pos_connection.dart';
import 'package:parkban/data/database/park_id/park_id.dart';
import 'package:parkban/data/database/plate/store_plate.dart';
import 'package:parkban/data/database/reserve/store_reserve.dart';
import 'package:parkban/presentation/Widgets/custom_drop_down.dart';
import 'package:parkban/presentation/screens/home/controller/home_controller.dart';
import 'package:parkban/presentation/screens/home/controller/plate_controller.dart';
import 'package:parkban/core/share_controller/settings_controller.dart';
import 'package:parkban/presentation/screens/home/widget/bottom_container.dart';
import 'package:parkban/presentation/screens/home/widget/grid_item.dart';
import 'package:parkban/presentation/screens/home/widget/status_dialog.dart';
import 'package:parkban/presentation/screens/pay_money/pay_money_screen.dart';
import 'package:parkban/presentation/widgets/plates/__plates_keys.dart';
import '../../../data/api/api.dart';
import '../../../data/models/send_plate/send_plate.dart';
import '../settings/settings_screen.dart';
import '../user/user_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static String routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PlatesKeys pk;
  TextEditingController addPriceController = TextEditingController(text: '0');
  String moneyForWallet = '';
  String parkSpaceID = '';
  String plateForPrint = '';

  @override
  void initState() {
    super.initState();
    pk = PlatesKeys();
  }

  void statusHandler(String status, String amount, String plateNo, String time, String findId, String plateType){
    debugPrint("status : $status,\namount : $amount,\nplateNo : $plateNo,\ntime : $time,\nfindId : $findId");
    switch(status){
      case 'Success':
        Get.dialog(StatusDialog(massage: 'پرداخت با موفقیت انجام شد', onSubmit: () async{
          await Api.endTime(findId).then((endTimeModel) async{
            if (endTimeModel != null) {
              StoreParkId.deleteFromBox(parkSpaceID);
              StoreReserve.deleteFromBox(parkSpaceID);
              StorePlate.deleteFromBox(parkSpaceID);
              Get.find<HomeController>().updateHome();
              Get.find<HomeController>().update();
              if((double.parse(moneyForWallet) > 0)){
                debugPrint('money : $moneyForWallet');
                bool res = await Api.increaseAmount(endTimeModel.park!.car!.id!, moneyForWallet);
                print("message server : $res");
                if(res){
                  Get.snackbar('', '',
                      titleText:  Text('تغییر قیمت', textDirection: TextDirection.rtl, style: TextStyle(fontFamily: 'iransans', color: Get.isDarkMode ? CupertinoColors.white : CupertinoColors.black)),
                      messageText:  Text('اعمال تغییر قیمت یا پرداخت بدهی با موفقیت انجام شد',
                          textDirection: TextDirection.rtl, style: TextStyle(fontFamily: 'iransans', color: Get.isDarkMode ? CupertinoColors.white : CupertinoColors.black)),
                      duration: const Duration(seconds: 5),
                      backgroundColor: const CupertinoDynamicColor.withBrightness(color: CupertinoColors.systemGreen, darkColor: CupertinoColors.systemBlue)
                  );
                }else{
                  Get.snackbar('', '',
                      titleText:  Text('خطا', textDirection: TextDirection.rtl, style: TextStyle(fontFamily: 'iransans', color: Get.isDarkMode ? CupertinoColors.white : CupertinoColors.black)),
                      messageText:  Text('اعمال تغییر قیمت یا پرداخت بدهی با خطا مواجه شد',
                          textDirection: TextDirection.rtl, style: TextStyle(fontFamily: 'iransans', color: Get.isDarkMode ? CupertinoColors.white : CupertinoColors.black)),
                      duration: const Duration(seconds: 5),
                      backgroundColor: const CupertinoDynamicColor.withBrightness(color: CupertinoColors.systemOrange, darkColor: CupertinoColors.systemYellow)
                  );
                }
              }
            }else{
              StoreParkId.deleteFromBox(parkSpaceID);
              StoreReserve.deleteFromBox(parkSpaceID);
              StorePlate.deleteFromBox(parkSpaceID);
              Get.find<HomeController>().updateHome();
            }}).whenComplete(() => Get.back());
        },), barrierDismissible: false);
        break;
      case 'WrongPassword':
        Get.dialog(StatusDialog(massage: 'رمز عبور اشتباه وارد شده است', onSubmitText: 'لغو', onRetryText: 'تلاش مجدد', onRetry: () async{
          String status = await PosConnection.sendToPay(amount, plateNo, time, plateType);
          Get.back();
          statusHandler(status, amount, plateNo, time, findId, plateType);
        },), barrierDismissible: false);
        break;
      case 'TimeOut':
        Get.dialog(StatusDialog(massage: 'پرداخت انجام نشد، زمان پرداخت به اتمام رسیده است', onSubmitText: 'لغو', onRetryText: 'تلاش مجدد', onRetry: () async{
          String status = await PosConnection.sendToPay(amount, plateNo, time, plateType);
          Get.back();
          statusHandler(status, amount, plateNo, time, findId, plateType);
        },), barrierDismissible: false);
        break;
      case 'Canceled':
        Get.dialog(StatusDialog(massage: 'پرداخت لغو گردید', onSubmitText: 'لغو', onRetryText: 'تلاش مجدد', onRetry: () async{
          String status = await PosConnection.sendToPay(amount, plateNo, time, plateType);
          Get.back();
          statusHandler(status, amount, plateNo, time, findId, plateType);
        },), barrierDismissible: false);
        break;
      case 'WentWrong':
        Get.dialog(StatusDialog(massage: 'مشکلی در ارتباط با پرداخت پیش آمده است، ممکن است کاغذ تمام کرده باشید', onSubmitText: 'لغو', onRetryText: 'تلاش مجدد', onRetry: () async{
          String status = await PosConnection.sendToPay(amount, plateNo, time, plateType);
          Get.back();
          statusHandler(status, amount, plateNo, time, findId, plateType);
        },), barrierDismissible: false);
        break;
      case 'Error':
        Get.dialog(StatusDialog(massage: 'مشکلی در دریافت اطلاعات پیش آمده است', onSubmitText: 'لغو', onRetryText: 'تلاش مجدد', onRetry: () async{
          String status = await PosConnection.sendToPay(amount, plateNo, time, plateType);
          Get.back();
          statusHandler(status, amount, plateNo, time, findId, plateType);
        },), barrierDismissible: false);
        break;
      case 'Invalid':
        Get.dialog(StatusDialog(massage: 'قیمت پایین تر از حد مجاز', onSubmitText: 'لغو', onRetryText: 'تلاش مجدد', onRetry: () async{
          String status = await PosConnection.sendToPay(amount, plateNo, time, plateType);
          Get.back();
          statusHandler(status, amount, plateNo, time, findId, plateType);
        },), barrierDismissible: false);
        break;
      case 'Paper':
        Get.dialog(StatusDialog(massage: 'رول کاغذ را چک نمایید', onSubmitText: 'لغو', onRetryText: 'تلاش مجدد', onRetry: () async{
          String status = await PosConnection.sendToPay(amount, plateNo, time, plateType);
          Get.back();
          statusHandler(status, amount, plateNo, time, findId, plateType);
        },), barrierDismissible: false);
        break;
      case 'Range':
        Get.dialog(StatusDialog(massage: 'حداقل مبلغ برای این کارت رعایت نشده است', onSubmitText: 'لغو', onRetryText: 'تلاش مجدد', onRetry: () async{
          String status = await PosConnection.sendToPay(amount, plateNo, time, plateType);
          Get.back();
          statusHandler(status, amount, plateNo, time, findId, plateType);
        },), barrierDismissible: false);
        break;
      case 'Limited':
        Get.dialog(StatusDialog(massage: 'سقف تراکنشات شما تمام شده است', onSubmitText: 'لغو', onRetryText: 'تلاش مجدد', onRetry: () async{
          String status = await PosConnection.sendToPay(amount, plateNo, time, plateType);
          Get.back();
          statusHandler(status, amount, plateNo, time, findId, plateType);
        },), barrierDismissible: false);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop(false);
        return false;
      },
      child: CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            padding: EdgeInsetsDirectional.zero,
            leading: Row(
              children: [
                CupertinoButton(
                  onPressed: () => Get.toNamed(SettingsScreen.routeName),
                  padding: EdgeInsets.zero,
                  child: const Icon(CupertinoIcons.settings),
                ),
                // CupertinoButton(
                //   onPressed: () => Get.toNamed(PayMoneyScreen.routeName),
                //   padding: EdgeInsets.zero,
                //   child: const Icon(CupertinoIcons.creditcard),
                // )
              ],
            ),
            trailing: CupertinoButton(
              onPressed: (){
                Get.toNamed(UserScreen.routeName);
                Get.put<HomeController>(HomeController());
              },
              padding: EdgeInsets.zero,
              child: const Icon(CupertinoIcons.profile_circled),
            ),
            middle: const Text('ایمن پارک آذر'),
          ),
          child: GetBuilder<HomeController>(builder: (homeController) {
            return GridView.builder(
              itemCount: homeController.parkSpaces.length,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 4 / 3),
              itemBuilder: (context, index) {
                return GridItem(
                    item: homeController.parkSpaces[index]!.number.toString(),
                    id: homeController.parkSpaces[index]!.id!,
                    onPress: () async {
                      String storeId = StoreReserve.readFromBox(homeController.parkSpaces[index]!.number.toString());
                      if (storeId == homeController.parkSpaces[index]!.id.toString()) {
                        // Find car by Id
                        await Api.getPlateInfo(StoreParkId.readFromBox(homeController.parkSpaces[index]!.number.toString())).then((findIdModel) async{
                          debugPrint(StoreParkId.readFromBox(homeController.parkSpaces[index]!.number.toString()));
                          if (findIdModel != null) {
                            // Get car's debt
                            await Api.debt(findIdModel.car!.id!).then((debt) async{
                              if(debt != -1){
                                await Api.getWallet(findIdModel.car!.id!).then((walletModel) {
                                  if(walletModel != null){
                                    addPriceController.text = "0";
                                    if(Get.isBottomSheetOpen!){
                                      return;
                                    }
                                    Get.bottomSheet(GetBuilder<PlateController>(builder: (plateController) {
                                      return BottomContainer(children: [
                                        const SizedBox(height: 20),
                                        Text('اطلاعات خودرو پارک شده',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                                fontFamily: 'iransans',
                                                color: CupertinoDynamicColor.resolve(
                                                    const CupertinoDynamicColor.withBrightness(color: CupertinoColors.black, darkColor: CupertinoColors.white), context))),
                                        const Divider(),
                                        Text(findIdModel.car!.carType!,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'iransans',
                                                color: CupertinoDynamicColor.resolve(
                                                    const CupertinoDynamicColor.withBrightness(color: CupertinoColors.black, darkColor: CupertinoColors.white), context))),
                                        const SizedBox(height: 20),
                                        Material(
                                          color: Colors.transparent,
                                          child: makePlate(width: context.width, enable: false, idno: findIdModel.car!.number, plateType: findIdModel.car!.carType),
                                        ),
                                        const SizedBox(height: 20),
                                        Text('زمان پارک خودرو: ${findIdModel.time} دقیقه',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'iransans',
                                                color: CupertinoDynamicColor.resolve(
                                                    const CupertinoDynamicColor.withBrightness(color: CupertinoColors.black, darkColor: CupertinoColors.white), context))),
                                        const SizedBox(height: 20),
                                        Text('مبلغ: ${findIdModel.amount} تومان',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'iransans',
                                                color: CupertinoDynamicColor.resolve(
                                                    const CupertinoDynamicColor.withBrightness(color: CupertinoColors.black, darkColor: CupertinoColors.white), context))),
                                        const SizedBox(height: 20),
                                        Text('بدهی: $debt تومان',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'iransans',
                                                color: CupertinoDynamicColor.resolve(
                                                    const CupertinoDynamicColor.withBrightness(color: CupertinoColors.black, darkColor: CupertinoColors.white), context))),
                                        const SizedBox(height: 20),
                                        Text('کیف پول: ${walletModel.money} تومان',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'iransans',
                                                color: CupertinoDynamicColor.resolve(
                                                    const CupertinoDynamicColor.withBrightness(color: CupertinoColors.black, darkColor: CupertinoColors.white), context))),
                                        const SizedBox(height: 20),
                                        const Divider(),
                                        CupertinoActionSheetAction(
                                          onPressed: () async {
                                            Get.back();
                                            // Dialog of exit from park
                                            Get.dialog(CupertinoAlertDialog(
                                              title: const Text('هشدار', style: TextStyle(fontFamily: 'iransans')),
                                              content: const Text('آیا از خروج خودرو مطمئن می باشید؟', style: TextStyle(fontFamily: 'iransans')),
                                              actions: [
                                                CupertinoActionSheetAction(onPressed: () async{
                                                  Get.back();
                                                  homeController.addPrice.value = "${int.parse("${findIdModel.amount}") + debt}";
                                                  // Dialog of accept
                                                  Get.dialog(
                                                      CupertinoAlertDialog(
                                                        title: const Text('خارج از پارک', style: TextStyle(fontFamily: 'iransans')),
                                                        content: Directionality(
                                                          textDirection: TextDirection.rtl,
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              const SizedBox(height: 15),
                                                              Row(
                                                                children: [
                                                                  const Text('زمان: ', style: TextStyle(fontFamily: 'iransans')),
                                                                  Expanded(child: Text(findIdModel.time.toString(), style: const TextStyle(fontFamily: 'iransans'))),
                                                                  const Text('دقیقه', style: TextStyle(fontFamily: 'iransans')),
                                                                ],
                                                              ),
                                                              const Divider(),
                                                              Row(
                                                                children: [
                                                                  const Text('قیمت: ', style: TextStyle(fontFamily: 'iransans')),
                                                                  Expanded(child: Text("${findIdModel.amount}", style: const TextStyle(fontFamily: 'iransans'))),
                                                                  const Text('تومان', style: TextStyle(fontFamily: 'iransans')),
                                                                ],
                                                              ),
                                                              const Divider(),
                                                              Row(
                                                                children: [
                                                                  const Text('بدهی: ', style: TextStyle(fontFamily: 'iransans')),
                                                                  Expanded(child: Text("$debt", style: const TextStyle(fontFamily: 'iransans'))),
                                                                  const Text('تومان', style: TextStyle(fontFamily: 'iransans')),
                                                                ],
                                                              ),
                                                              const Divider(),
                                                              SizedBox(
                                                                width: context.width * .9,
                                                                child: CupertinoTextField(
                                                                  controller: addPriceController,
                                                                  maxLines: 1,
                                                                  style: const TextStyle(fontFamily: 'iransans'),
                                                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                                                  textDirection: TextDirection.ltr,
                                                                  keyboardType: TextInputType.number,
                                                                  suffix: const Padding(
                                                                    padding: EdgeInsets.all(3.0),
                                                                    child: Text('تومان', style: TextStyle(fontFamily: 'iransans')),
                                                                  ),
                                                                  prefix: CupertinoButton(
                                                                    onPressed: () {
                                                                      addPriceController.text = "0";
                                                                    },
                                                                    padding: EdgeInsets.zero,
                                                                    minSize: 40,
                                                                    child: const Icon(CupertinoIcons.clear_circled),
                                                                  ),
                                                                  onTap: (){
                                                                    addPriceController.clear();
                                                                  },
                                                                  onChanged: (value){
                                                                    if(value.isNotEmpty && value != ""){
                                                                      homeController.addPrice.value = "${int.parse("${findIdModel.amount}") + debt + int.parse(value)}";
                                                                    }else{
                                                                      value = '0';
                                                                      addPriceController.text = "0";
                                                                      homeController.addPrice.value = "${int.parse("${findIdModel.amount}") + debt + int.parse(value)}";
                                                                    }
                                                                    print(homeController.addPrice.value);
                                                                  },
                                                                ),
                                                              ),
                                                              const SizedBox(height: 10),
                                                              Obx(() => Directionality(textDirection: TextDirection.ltr, child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  const Text(' تومان ', style: TextStyle(fontFamily: 'iransans')),
                                                                  Text("${findIdModel.amount}", style: const TextStyle(fontFamily: 'iransans')),
                                                                  const Text(" + ", style: TextStyle(fontFamily: 'iransans')),
                                                                  Text("$debt", style: const TextStyle(fontFamily: 'iransans')),
                                                                  const Text(" + ", style: TextStyle(fontFamily: 'iransans')),
                                                                  Text(addPriceController.text, style: const TextStyle(fontFamily: 'iransans')),
                                                                  const Text(" = ", style: TextStyle(fontFamily: 'iransans')),
                                                                  Text(homeController.addPrice.value, style: const TextStyle(fontFamily: 'iransans')),
                                                                ],
                                                              ))),
                                                              const Directionality(textDirection: TextDirection.ltr, child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  Text('قیمت', style: TextStyle(fontFamily: 'iransans')),
                                                                  Text(" + ", style: TextStyle(fontFamily: 'iransans')),
                                                                  Text("بدهی", style: TextStyle(fontFamily: 'iransans')),
                                                                  Text(" + ", style: TextStyle(fontFamily: 'iransans')),
                                                                  Text('کیف پول', style: TextStyle(fontFamily: 'iransans')),
                                                                  Text(" = ", style: TextStyle(fontFamily: 'iransans')),
                                                                  Text('قیمت نهایی', style: TextStyle(fontFamily: 'iransans')),
                                                                ],
                                                              ))
                                                            ],
                                                          ),
                                                        ),
                                                        actions: [
                                                          CupertinoButton(
                                                              child: const Text('ارسال به صفحه پرداخت', style: TextStyle(fontFamily: 'iransans')),
                                                              onPressed: () async{
                                                                String finalAmount = "${homeController.addPrice.value}0";
                                                                parkSpaceID = homeController.parkSpaces[index]!.number.toString();
                                                                  moneyForWallet = (debt.toDouble() + double.parse(addPriceController.text)).toString();
                                                                  debugPrint(moneyForWallet);
                                                                if(double.parse(finalAmount) <= 0 && findIdModel.time! <= 30 && addPriceController.text == '0') {
                                                                  Get.back();
                                                                  statusHandler('Success', finalAmount, findIdModel.car!.number!, findIdModel.time.toString(), findIdModel.id!, findIdModel.car!.carType!);
                                                                  addPriceController.clear();
                                                                  homeController.addPrice.value = "0";
                                                                  homeController.updateHome();
                                                                }else{
                                                                  String status = await PosConnection.sendToPay(finalAmount, findIdModel.car!.number!, findIdModel.time.toString(), findIdModel.car!.carType!);
                                                                  Get.back();
                                                                  statusHandler(status, finalAmount, findIdModel.car!.number!, findIdModel.time.toString(), findIdModel.id!, findIdModel.car!.carType!);
                                                                  addPriceController.clear();
                                                                  homeController.addPrice.value = "0";
                                                                  homeController.updateHome();
                                                                }
                                                              }),
                                                          if(walletModel.money! < findIdModel.amount!)
                                                            CupertinoButton(
                                                                child: const Text('ثبت و ذخیره بدهی', style: TextStyle(fontFamily: 'iransans')),
                                                                onPressed: () async{
                                                                  debugPrint(findIdModel.id!);
                                                                  await Api.setDebt(findIdModel.id!).then((endTimeModel){
                                                                    debugPrint(endTimeModel?.park?.id);
                                                                    if(endTimeModel != null){
                                                                      StoreParkId.deleteFromBox(homeController.parkSpaces[index]!.number.toString());
                                                                      StoreReserve.deleteFromBox(homeController.parkSpaces[index]!.number.toString());
                                                                      StorePlate.deleteFromBox(homeController.parkSpaces[index]!.number.toString());
                                                                      Get.find<HomeController>().updateHome();
                                                                      Get.find<HomeController>().update();
                                                                      Get.back();
                                                                      Get.snackbar('', '',
                                                                          titleText:  Text('موفقیت', textDirection: TextDirection.rtl, style: TextStyle(fontFamily: 'iransans', color: Get.isDarkMode ? CupertinoColors.white : CupertinoColors.black)),
                                                                          messageText:  Text('بدهی با موفقیت برای این خودرو ثبت گردید',
                                                                              textDirection: TextDirection.rtl, style: TextStyle(fontFamily: 'iransans', color: Get.isDarkMode ? CupertinoColors.white : CupertinoColors.black)),
                                                                          duration: const Duration(seconds: 5),
                                                                          backgroundColor: const CupertinoDynamicColor.withBrightness(color: CupertinoColors.systemGreen, darkColor: CupertinoColors.systemBlue)
                                                                      );
                                                                    }else{
                                                                      Get.snackbar('', '',
                                                                          titleText: Text('خطا', textDirection: TextDirection.rtl, style: TextStyle(fontFamily: 'iransans', color: Get.isDarkMode ? CupertinoColors.white : CupertinoColors.black)),
                                                                          messageText: Text('ثبت بدهی با خطا مواجه شد، دوباره تلاش نمایید',
                                                                              textDirection: TextDirection.rtl, style: TextStyle(fontFamily: 'iransans', color: Get.isDarkMode ? CupertinoColors.white : CupertinoColors.black)),
                                                                          duration: const Duration(seconds: 5),
                                                                          backgroundColor: const CupertinoDynamicColor.withBrightness(color: CupertinoColors.systemOrange, darkColor: CupertinoColors.systemYellow)
                                                                      );
                                                                    }
                                                                  });
                                                                }),
                                                          if(walletModel.money != 0 && findIdModel.amount != 0 && walletModel.money! >= findIdModel.amount!)
                                                            CupertinoButton(
                                                                child: const Text('پرداخت از کیف پول', style: TextStyle(fontFamily: 'iransans')),
                                                                onPressed: () async{
                                                                  debugPrint(findIdModel.id!);
                                                                  await Api.setDebt(findIdModel.id!).then((endTimeModel){
                                                                    debugPrint(endTimeModel?.park?.id);
                                                                    if(endTimeModel != null){
                                                                      StoreParkId.deleteFromBox(homeController.parkSpaces[index]!.number.toString());
                                                                      StoreReserve.deleteFromBox(homeController.parkSpaces[index]!.number.toString());
                                                                      StorePlate.deleteFromBox(homeController.parkSpaces[index]!.number.toString());
                                                                      Get.find<HomeController>().updateHome();
                                                                      Get.find<HomeController>().update();
                                                                      Get.back();
                                                                      Get.snackbar('', '',
                                                                          titleText:  Text('موفقیت', textDirection: TextDirection.rtl, style: TextStyle(fontFamily: 'iransans', color: Get.isDarkMode ? CupertinoColors.white : CupertinoColors.black)),
                                                                          messageText:  Text('با موفقیت از کیف پول پرداخت شد',
                                                                              textDirection: TextDirection.rtl, style: TextStyle(fontFamily: 'iransans', color: Get.isDarkMode ? CupertinoColors.white : CupertinoColors.black)),
                                                                          duration: const Duration(seconds: 5),
                                                                          backgroundColor: const CupertinoDynamicColor.withBrightness(color: CupertinoColors.systemGreen, darkColor: CupertinoColors.systemBlue)
                                                                      );
                                                                    }else{
                                                                      Get.snackbar('', '',
                                                                          titleText: Text('خطا', textDirection: TextDirection.rtl, style: TextStyle(fontFamily: 'iransans', color: Get.isDarkMode ? CupertinoColors.white : CupertinoColors.black)),
                                                                          messageText: Text('پرداخت از کیف پول با خطا مواجه شد، دوباره تلاش نمایید',
                                                                              textDirection: TextDirection.rtl, style: TextStyle(fontFamily: 'iransans', color: Get.isDarkMode ? CupertinoColors.white : CupertinoColors.black)),
                                                                          duration: const Duration(seconds: 5),
                                                                          backgroundColor: const CupertinoDynamicColor.withBrightness(color: CupertinoColors.systemOrange, darkColor: CupertinoColors.systemYellow)
                                                                      );
                                                                    }
                                                                  });
                                                                }),
                                                        ],
                                                      ),
                                                      barrierDismissible: false
                                                  );
                                                }, child: const Text('تایید', style: TextStyle(fontFamily: 'iransans'))),
                                                CupertinoActionSheetAction(
                                                    isDestructiveAction: true,
                                                    onPressed: () {
                                                      Get.back();
                                                    }, child: const Text('صرف نظر', style: TextStyle(fontFamily: 'iransans'))),
                                              ],
                                            ));
                                          },
                                          child: const Text(
                                            'خارج از پارک',
                                            style: TextStyle(fontFamily: 'iransans'),
                                          ),
                                        ),
                                        const Divider(),
                                        CupertinoActionSheetAction(
                                          isDestructiveAction: true,
                                          onPressed: () {
                                            debugPrint(homeController.singInModel!.token);
                                            Navigator.pop(context);
                                          },
                                          child: const Text('صرف نظر', style: TextStyle(fontFamily: 'iransans')),
                                        ),
                                      ]);
                                    }), isScrollControlled: true,);
                                  }else{
                                    Get.snackbar('', '',
                                        titleText:  Text('خطا', textDirection: TextDirection.rtl, style: TextStyle(fontFamily: 'iransans', color: Get.isDarkMode ? CupertinoColors.white : CupertinoColors.black)),
                                        messageText:  Text('در انجام دریافت اطلاعات خودرو اشکالی پیش آمده، دوباره تلاش نمایید.',
                                            textDirection: TextDirection.rtl, style: TextStyle(fontFamily: 'iransans', color: Get.isDarkMode ? CupertinoColors.white : CupertinoColors.black)),
                                        duration: const Duration(seconds: 5),
                                      backgroundColor: const CupertinoDynamicColor.withBrightness(color: CupertinoColors.systemOrange, darkColor: CupertinoColors.systemYellow)
                                    );
                                  }
                                });
                              }else{
                                Get.snackbar('', '',
                                    titleText:  Text('خطا', textDirection: TextDirection.rtl, style: TextStyle(fontFamily: 'iransans', color: Get.isDarkMode ? CupertinoColors.white : CupertinoColors.black)),
                                    messageText:  Text('در انجام دریافت اطلاعات خودرو اشکالی پیش آمده، دوباره تلاش نمایید.',
                                        textDirection: TextDirection.rtl, style: TextStyle(fontFamily: 'iransans', color: Get.isDarkMode ? CupertinoColors.white : CupertinoColors.black)),
                                    duration: const Duration(seconds: 5),
                                    backgroundColor: const CupertinoDynamicColor.withBrightness(color: CupertinoColors.systemOrange, darkColor: CupertinoColors.systemYellow)
                                );
                              }
                            }
                            );
                          }
                        });
                      } else {
                        if(Get.isBottomSheetOpen!){
                          return;
                        }
                        Get.bottomSheet(GetBuilder<PlateController>(builder: (plateController) {
                          return BottomContainer(children: [
                            const SizedBox(height: 20),
                            Text('وارد کردن پلاک',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    fontFamily: 'iransans',
                                    color: CupertinoDynamicColor.resolve(
                                        const CupertinoDynamicColor.withBrightness(color: CupertinoColors.black, darkColor: CupertinoColors.white), context))),
                            const Divider(),
                            Material(
                              color: Colors.transparent,
                              child: CustomDropDown(
                                value: plateTypes[0],
                                items: plateTypes,
                                hint: plateController.plateType,
                                onChanged: (selectedItem) {
                                  plateController.clearOrSetToDefaultCarNumberWithUpdate();
                                  plateController.setPlateTypeWithUpdate(selectedItem);
                                },
                              ),
                            ),
                            const SizedBox(height: 20),
                            Material(
                              color: Colors.transparent,
                              child: makePlate(
                                  width: context.width,
                                  enable: true,
                                  idno: (plateController.carNumber != null && plateController.carNumber!.trim().isNotEmpty) ? plateController.carNumber : null,
                                  plateType: plateController.plateType,
                                  key: getPlateKey(plateController.plateType, pk)),
                            ),
                            if(homeController.parkSpaces[index]!.description!.isNotEmpty) Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(homeController.parkSpaces[index]!.description!, style: const TextStyle(fontSize: 16, fontFamily: 'iransans',), textDirection: TextDirection.rtl, textAlign: TextAlign.justify,),
                            ),
                            const SizedBox(height: 20),
                            const Divider(),
                            CupertinoActionSheetAction(
                              onPressed: () async {
                                String carNumber = getPlateNo(plateController.plateType, pk);
                                plateController.setCarNumberWithoutUpdate(carNumber);
                                await Api.sendPlate(carNumber, homeController.parkSpaces[index]!.id!, plateController.plateType).then((sendPlateModel) {
                                  if (sendPlateModel != null) {
                                    StoreReserve.writeInBox(homeController.parkSpaces[index]!.number.toString(), homeController.parkSpaces[index]!.id!.toString());
                                    StoreParkId.writeInBox(homeController.parkSpaces[index]!.number.toString(), sendPlateModel.id!);
                                    StorePlate.writeInBox(homeController.parkSpaces[index]!.number.toString(), {"plateType": plateController.plateType, 'plateNo': carNumber});
                                    homeController.updateHome();
                                    Get.back();
                                  } else {
                                    Get.back();
                                    Get.snackbar('', '',
                                        titleText:  Text('خطا', textDirection: TextDirection.rtl, style: TextStyle(fontFamily: 'iransans',color: Get.isDarkMode ? CupertinoColors.white : CupertinoColors.black)),
                                        messageText: Text('در انجام ثبت خودرو اشکالی به وجود آمده است ممکن است شماره پلاک قبلا ثبت شده باشد',
                                            textDirection: TextDirection.rtl, style: TextStyle(fontFamily: 'iransans', color: Get.isDarkMode ? CupertinoColors.white : CupertinoColors.black)),
                                      duration: const Duration(seconds: 5),
                                        backgroundColor: const CupertinoDynamicColor.withBrightness(color: CupertinoColors.systemOrange, darkColor: CupertinoColors.systemYellow)
                                    );
                                  }
                                });
                              },
                              child: const Text(
                                'تایید',
                                style: TextStyle(fontFamily: 'iransans'),
                              ),
                            ),
                            const Divider(),
                            CupertinoActionSheetAction(
                              isDestructiveAction: true,
                              onPressed: () {
                                debugPrint(homeController.singInModel!.token);
                                Navigator.pop(context);
                              },
                              child: const Text('صرف نظر', style: TextStyle(fontFamily: 'iransans')),
                            ),
                          ]);
                        }), isScrollControlled: true, );
                      }
                    });
              },
            );
          })),
    );
  }
}
