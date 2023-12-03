import 'package:get/get.dart';
import 'package:parkban/data/database/theme/store_theme.dart';

class SettingsController extends GetxController{
  RxBool darkTheme = false.obs;

  @override
  void onInit() {
    super.onInit();
    darkTheme.value = ThemeStorage.readFromBox('theme') ?? false;
  }
}