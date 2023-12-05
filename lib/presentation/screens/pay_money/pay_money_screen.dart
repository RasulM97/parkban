import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parkban/core/pos_connection.dart';
import 'package:parkban/presentation/Widgets/custom_button.dart';
import 'package:parkban/presentation/screens/pay_money/controller/pay_controller.dart';

import '../home/widget/status_dialog.dart';

class PayMoneyScreen extends StatefulWidget {
  const PayMoneyScreen({Key? key}) : super(key: key);
  static String routeName = '/pay_money';

  @override
  State<PayMoneyScreen> createState() => _PayMoneyScreenState();
}

class _PayMoneyScreenState extends State<PayMoneyScreen> {
  TextEditingController payTextController = TextEditingController();

  void statusHandler(String status) {
    switch (status) {
      case 'Success':
        Get.dialog(const StatusDialog(massage: 'پرداخت با موفقیت انجام شد'), barrierDismissible: false);
        payTextController.clear();
        break;
      case 'WrongPassword':
        Get.dialog(const StatusDialog(massage: 'رمز عبور اشتباه وارد شده است'), barrierDismissible: false);
        break;
      case 'TimeOut':
        Get.dialog(const StatusDialog(massage: 'پرداخت انجام نشد، زمان پرداخت به اتمام رسیده است'), barrierDismissible: false);
        break;
      case 'Canceled':
        Get.dialog(const StatusDialog(
          massage: 'پرداخت لغو گردید'
        ), barrierDismissible: false);
        break;
      case 'WentWrong':
        Get.dialog(const StatusDialog(massage: 'مشکلی در ارتباط با پرداخت پیش آمده است'), barrierDismissible: false);
        break;
      case 'Error':
        Get.dialog(const StatusDialog(massage: 'مشکلی در دریافت اطلاعات پیش آمده است'), barrierDismissible: false);
        break;
      case 'Paper':
        Get.dialog(const StatusDialog(massage: 'رول کاغذ را چک نمایید'), barrierDismissible: false);
        break;
      case 'Invalid':
        Get.dialog(const StatusDialog(massage: 'قیمت پایین تر از حد مجاز'), barrierDismissible: false);
        break;
      case 'Range':
        Get.dialog(const StatusDialog(massage: 'حداقل مبلغ برای این کارت رعایت نشده است'), barrierDismissible: false);
        break;
      case 'Limited':
        Get.dialog(const StatusDialog(massage: 'سقف تراکنشات شما تمام شده است'), barrierDismissible: false);
        break;
    }
  }

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
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: context.height * .1),
                    CupertinoTextField(
                      controller: payTextController,
                      maxLines: 1,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      textDirection: TextDirection.ltr,
                      keyboardType: TextInputType.number,
                      suffix: const Padding(
                        padding: EdgeInsets.all(3.0),
                        child: Text('ریال'),
                      ),
                      prefix: CupertinoButton(
                        onPressed: () {
                          payTextController.clear();
                        },
                        padding: EdgeInsets.zero,
                        minSize: 40,
                        child: const Icon(CupertinoIcons.clear_circled),
                      ),
                    ),
                    const Text(
                      'توجه: مبلغ وارده باید به ریال باشد',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: context.height * .05),
                    GetX<PayController>(
                        init: PayController(),
                        builder: (payController) {
                          return CustomButton(
                              enableLoading: payController.paymentLoading.value,
                              onTap: () async {
                                payController.paymentLoading.value = true;
                                if (payTextController.text.isNotEmpty) {
                                  int payToInt = int.parse(payTextController.text);
                                  if (payToInt > 1300) {
                                    String status = await PosConnection.sendToPay(payTextController.text, '', '', '', '').whenComplete(() => payController.paymentLoading.value = false);
                                    print("status $status");
                                    statusHandler(status);
                                  } else {
                                    Get.dialog(const StatusDialog(massage: 'مبلغ وارده کمتر از 1.300 ریال می باشد'));
                                    payController.paymentLoading.value = false;
                                  }
                                } else {
                                  Get.dialog(const StatusDialog(massage: 'مبلغ را وارد نمایید'));
                                  payController.paymentLoading.value = false;
                                }
                              },
                              child: const Text('پرداخت مبلغ'));
                        }),
                  ],
                ),
              ))),
    );
  }
}
