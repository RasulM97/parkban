import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:parkban/core/share_controller/progress_controller.dart';
import 'package:parkban/core/share_controller/settings_controller.dart';
import 'package:parkban/data/database/token/store_token.dart';
import 'package:parkban/presentation/Widgets/custom_button.dart';
import 'package:parkban/presentation/screens/home/controller/home_controller.dart';
import 'package:parkban/presentation/screens/home/home_screen.dart';

import '../../../data/api/api.dart';
import 'controller/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static String routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop(false);
        return false;
      },
      child: CupertinoPageScaffold(
          child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: context.height * .1),
              Align(alignment: Alignment.center, child: Image.asset("assets/images/park.png", width: context.width * .3, height: context.width * .3,)),
              SizedBox(height: context.height * .1),
              const Text('نام  کاربری'),
              CupertinoTextField(
                  controller: userController,
                  maxLines: 1,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  prefix: const Padding(
                    padding: EdgeInsets.all(3.0),
                    child: Icon(CupertinoIcons.profile_circled),
                  )),
              const SizedBox(height: 16),
              const Text('رمز عبور'),
              GetX<LoginController>(builder: (loginController) {
                return CupertinoTextField(
                    controller: passwordController,
                    maxLines: 1,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    obscureText: loginController.showPassword.value,
                    prefix: const Padding(
                      padding: EdgeInsets.all(3.0),
                      child: Icon(CupertinoIcons.padlock),
                    ),
                    suffix: CupertinoButton(
                      onPressed: () {
                        loginController.showPassword.value = !loginController.showPassword.value;
                      },
                      padding: EdgeInsets.zero,
                      minSize: 40,
                      child: Icon(loginController.showPassword.value ? CupertinoIcons.eye : CupertinoIcons.eye_slash),
                    ));
              }),
              const SizedBox(height: 36),
              SizedBox(
                  width: double.infinity,
                  child: GetX<ProgressController>(
                    builder: (progressController) {
                      return CustomButton(
                          enableLoading: progressController.loginProgress.value,
                          onTap: () async {
                            progressController.loginProgress.value = true;
                            try {
                              debugPrint(userController.text);
                              debugPrint(passwordController.text);
                              await Api.authSignIn(userController.text, passwordController.text).then((signInModel) {
                                debugPrint(signInModel.toString());
                                if (signInModel != null && signInModel.token != null) {
                                  Get.put<HomeController>(HomeController(), permanent: true).setSignInModelWithoutUpdate(signInModel);
                                  StoreToken.writeInBox(signInModel.token!);
                                  progressController.loginProgress.value = false;
                                  Get.offAndToNamed(HomeScreen.routeName);
                                }else{
                                  progressController.loginProgress.value = false;
                                  Get.dialog(CupertinoAlertDialog(
                                    title: const Text('اطلاعات ورود معتبر نمی باشد', style: TextStyle(fontFamily: 'iransans')),
                                    actions: [
                                      CupertinoButton(child: const Text('متوجه شدم', style: TextStyle(fontFamily: 'iransans')), onPressed: ()=> Get.back())
                                    ],
                                  ));
                                }
                              });
                            } catch (e) {
                              progressController.loginProgress.value = false;
                              Get.dialog(CupertinoAlertDialog(
                                title: const Text('مشکلی در ارتباط پیش آمده است', style: TextStyle(fontFamily: 'iransans')),
                                actions: [
                                  CupertinoButton(child: const Text('تلاش مجدد', style: TextStyle(fontFamily: 'iransans')), onPressed: ()=> Get.back())
                                ],
                              ));
                            }
                          },
                          child: const Text('ورود'));
                    },
                  ))
            ],
          ),
        ),
      )),
    );
  }
}
