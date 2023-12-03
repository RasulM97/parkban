import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:parkban/data/database/theme/store_theme.dart';
import 'package:parkban/core/share_controller/settings_controller.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);
  static String routeName = '/settings';

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
          children: [
            GetX<SettingsController>(builder: (settingsController) {
              return CupertinoListSection(
                header: const Text(
                  'تنظیمات',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                topMargin: 5,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
                children: [
                  CupertinoListTile(
                    padding: const EdgeInsets.all(8.8),
                    title: const Text('حالت شب'),
                    subtitle: const Text('تغییر تم در حالت شب و روز'),
                    trailing: CupertinoSwitch(
                        onChanged: (value) => {
                              settingsController.darkTheme.value = value,
                              ThemeStorage.writeInBox('theme', value),
                            },
                        value: ThemeStorage.readFromBox('theme') ?? settingsController.darkTheme.value),
                  ),
                  CupertinoListTile(
                    padding: const EdgeInsets.all(8.8),
                    title: const Text('نسخه نرم افزار'),
                    trailing: FutureBuilder(
                      future: PackageInfo.fromPlatform(),
                      builder: (context, snapShot) {
                        if (snapShot.hasData) {
                          return Text(snapShot.data!.version);
                        } else {
                          return const CupertinoActivityIndicator(radius: 12);
                        }
                      },
                    ),
                  ),
                ],
              );
            }),
          ],
        ),
      )),
    );
  }
}
