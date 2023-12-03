import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:parkban/presentation/screens/login/login_screen.dart';
import 'package:parkban/presentation/screens/pay_money/pay_money_screen.dart';
import 'package:parkban/presentation/screens/settings/settings_screen.dart';
import 'package:parkban/presentation/screens/user/user_screen.dart';

import '../presentation/screens/home/home_screen.dart';
import 'bindings.dart';

class Routes{
  static List<GetPage> get pages => [
    GetPage(name: LoginScreen.routeName, page: ()=> const LoginScreen(), binding: LoginBinding()),
    GetPage(name: HomeScreen.routeName, page: ()=> const HomeScreen(), binding: HomeBindings()),
    GetPage(name: SettingsScreen.routeName, page: ()=> const SettingsScreen()),
    GetPage(name: UserScreen.routeName, page: ()=> const UserScreen()),
    GetPage(name: PayMoneyScreen.routeName, page: ()=> const PayMoneyScreen()),
  ];
}