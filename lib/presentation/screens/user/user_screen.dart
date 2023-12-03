import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parkban/core/share_controller/settings_controller.dart';
import 'package:parkban/data/database/token/store_token.dart';
import 'package:parkban/data/models/signin/signin.dart';
import 'package:parkban/presentation/screens/home/controller/home_controller.dart';
import 'package:parkban/presentation/screens/home/controller/plate_controller.dart';
import 'package:parkban/presentation/screens/login/login_screen.dart';

import '../../../data/database/park_id/park_id.dart';
import '../../../data/database/plate/store_plate.dart';
import '../../../data/database/reserve/store_reserve.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);
  static String routeName = '/user';

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  late Timer timer;
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        padding: EdgeInsetsDirectional.zero,
        automaticallyImplyLeading: false,
        trailing: CupertinoButton(
          onPressed: () => Get.back(),
          padding: EdgeInsets.zero,
          child: const Icon(CupertinoIcons.forward),
        ),
        middle: const Text('ایمن پارک آذر'),
      ),
      child: SafeArea(
          child: Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      GetBuilder<HomeController>(
                          builder: (homeController) {
                            return Container(
                              margin: const EdgeInsets.all(8.0),
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15), color: Get.find<SettingsController>().darkTheme.value ? CupertinoColors.secondaryLabel : CupertinoColors.extraLightBackgroundGray),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CupertinoListTile(
                                    title: Row(
                                      children: [
                                        const Text('نام و نام خانوادگی : '),
                                        Expanded(child: Text(homeController.singInModel!.user!.fullname!.toString())),
                                      ],
                                    ),
                                  ),
                                  const Divider(),
                                  CupertinoListTile(
                                    title: Row(
                                      children: [
                                        const Text('کدملی : '),
                                        Expanded(child: Text(homeController.singInModel!.user!.nationalNumber.toString())),
                                      ],
                                    ),
                                  ),
                                  const Divider(),
                                  CupertinoListTile(
                                    title: Row(
                                      children: [
                                        const Text('نام کاربری : '),
                                        Expanded(child: Text(homeController.singInModel!.user!.username.toString())),
                                      ],
                                    ),
                                  ),
                                  const Divider(),
                                  CupertinoListTile(
                                    title: Row(
                                      children: [
                                        const Text('تعداد جایگاه های فعال : '),
                                        Expanded(child: Text(homeController.parkSpaces.length.toString())),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                      ),

                    ],
                  ),
                  Container(
                      margin: const EdgeInsets.all(8.0),
                      width: double.infinity,
                      child: GestureDetector(
                        onTap: null,
                        onLongPressDown: (_) { //Detect when you click the element
                          timer = Timer(
                            const Duration(seconds: 5),
                                () {
                                  StoreParkId.eraseBox();
                                  StorePlate.eraseBox();
                                  StoreReserve.eraseBox();
                                  StoreToken.eraseBox();
                                  timer.cancel();
                                  Get.find<HomeController>().onClose();
                                  Get.find<PlateController>().onClose();
                                  Get.offAllNamed(LoginScreen.routeName);
                            },
                          );
                          debugPrint('timer is started.');
                        },
                        onLongPressUp: () { // Detect and cancel when you lift the click
                          timer.cancel();
                          debugPrint('timer is canceled.');
                        },
                        child: CupertinoButton(
                          onPressed: () {
                            List fullItem = [];
                            List<ParkSpaces?> spaces = Get.find<HomeController>().parkSpaces;
                            if(spaces.isNotEmpty){
                              for(int i = 0; i < spaces.length; i++){
                                String id = StoreReserve.readFromBox(spaces[i]!.number.toString());
                                if(id.isNotEmpty){
                                  fullItem.add(i);
                                }else{
                                  continue;
                                }
                              }
                              if(fullItem.isNotEmpty){
                                timer.cancel();
                                debugPrint('timer is canceled.');
                                Get.dialog(
                                    CupertinoAlertDialog(
                                      title: const Text('خطا', style: TextStyle(fontFamily: 'iransans')),
                                      content: Text('شما ${fullItem.length} جای پارک تعیین تکلیف نشده دارید، نمی توانید خارج شوید', style: const TextStyle(fontFamily: 'iransans')),
                                      actions: [
                                        CupertinoButton(
                                            child: const Text('تایید', style: TextStyle(fontFamily: 'iransans')),
                                            onPressed: () {
                                              timer.cancel();
                                              debugPrint('timer is canceled.');
                                              Get.back();
                                            })
                                      ],
                                    ),
                                    barrierDismissible: false
                                );
                              }else{
                                timer.cancel();
                                debugPrint('timer is canceled.');
                                Get.find<HomeController>().onClose();
                                Get.find<PlateController>().onClose();
                                Get.offAllNamed(LoginScreen.routeName);
                              }
                            }else{
                              timer.cancel();
                              debugPrint('timer is canceled.');
                              Get.find<HomeController>().onClose();
                              Get.find<PlateController>().onClose();
                              Get.offAllNamed(LoginScreen.routeName);
                            }
                          },
                          child: const Text('خروج از حساب', style: TextStyle(color: CupertinoColors.systemRed),),
                        ),
                      ))
                ],
              ))),
    );
  }
}
