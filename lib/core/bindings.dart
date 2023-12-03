import 'package:get/get.dart';
import 'package:parkban/core/share_controller/progress_controller.dart';
import 'package:parkban/core/share_controller/settings_controller.dart';
import '../presentation/screens/home/controller/home_controller.dart';
import '../presentation/screens/home/controller/plate_controller.dart';
import '../presentation/screens/login/controller/login_controller.dart';

class LoginBinding extends BindingsInterface {
  @override
  void dependencies() {
    Get.create<LoginController>(() => LoginController(), permanent: true);
    Get.create<ProgressController>(() => ProgressController(), permanent: true);
  }
}

class HomeBindings extends BindingsInterface{
  @override
  dependencies() {
    Get.create<HomeController>(() => HomeController(), permanent: true);
    Get.create<PlateController>(() => PlateController(), permanent: true);
    Get.create<SettingsController>(() => SettingsController(), permanent: true);
  }
}