import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:parkban/data/database/theme/store_theme.dart';
import 'package:parkban/presentation/screens/login/login_screen.dart';
import 'package:parkban/core/share_controller/settings_controller.dart';

import 'core/routing.dart';

void main() async{
  await GetStorage.init('unique token');
  await GetStorage.init('park_id');
  await GetStorage.init('theme');
  await GetStorage.init('reserve');
  await GetStorage.init('plate');
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky, overlays: [SystemUiOverlay.top]).then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX<SettingsController>(
      init: SettingsController(),
      builder: (settingsController) {
        return GetCupertinoApp(
          localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
            DefaultMaterialLocalizations.delegate,
            DefaultWidgetsLocalizations.delegate,
            DefaultCupertinoLocalizations.delegate,
          ],
          debugShowCheckedModeBanner: false,
          title: 'Parkban',
          theme: CupertinoThemeData(
              brightness: ThemeStorage.readFromBox('theme') ?? settingsController.darkTheme.value ? Brightness.dark : Brightness.light,
              textTheme: const CupertinoTextThemeData(
                primaryColor: CupertinoColors.systemBlue,
                actionTextStyle: TextStyle(fontFamily: 'iransans', color: CupertinoDynamicColor.withBrightness(color: CupertinoColors.black, darkColor: CupertinoColors.white)),
                  navActionTextStyle: TextStyle(fontFamily: 'iransans', color: CupertinoDynamicColor.withBrightness(color: CupertinoColors.black, darkColor: CupertinoColors.white)),
                  pickerTextStyle: TextStyle(fontFamily: 'iransans', color: CupertinoDynamicColor.withBrightness(color: CupertinoColors.black, darkColor: CupertinoColors.white)),
                  tabLabelTextStyle: TextStyle(fontFamily: 'iransans', color: CupertinoDynamicColor.withBrightness(color: CupertinoColors.black, darkColor: CupertinoColors.white)),
                  dateTimePickerTextStyle: TextStyle(fontFamily: 'iransans', color: CupertinoDynamicColor.withBrightness(color: CupertinoColors.black, darkColor: CupertinoColors.white)),
                  textStyle: TextStyle(fontFamily: 'iransans', color: CupertinoDynamicColor.withBrightness(color: CupertinoColors.black, darkColor: CupertinoColors.white)),
                  navTitleTextStyle: TextStyle(fontFamily: 'iransans', color: CupertinoDynamicColor.withBrightness(color: CupertinoColors.black, darkColor: CupertinoColors.white), fontWeight: FontWeight.bold),
              )),
          smartManagement: SmartManagement.full,
          defaultTransition: Transition.cupertino,
          getPages: Routes.pages,
          initialRoute: LoginScreen.routeName,
        );
      }
    );
  }
}
