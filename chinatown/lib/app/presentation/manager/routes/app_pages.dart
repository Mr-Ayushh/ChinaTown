import 'package:get/get.dart';

import '../../pages/material_home/material_home_page.dart';
import '../../pages/user_details/user_details_page.dart';
import '../../pages/users_list/users_list_page.dart';
import '../bindings/app_bindings.dart';

part './app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.INITIAL,
      page: () => MyApp(),
      title: "Home",
      binding: AppBinding(),
      popGesture: true,
      transitionDuration: Duration.zero,
      maintainState: true,
      transition: Transition.upToDown,
    ),
    GetPage(
        name: AppRoutes.USER_LIST,
        page: () => UserListPage(),
        maintainState: true,
        popGesture: true,
        binding: AppBinding(),
        title: 'User List',
        transition: Transition.upToDown),
    GetPage(
        name: AppRoutes.USER_Details,
        page: () => UserDetailsPage(),
        maintainState: true,
        popGesture: true,
        binding: AppBinding(),
        title: 'User Details',
        transition: Transition.downToUp),
    //GetPage(name: Routes.APRESENTACAO, page:()=> ApresentacaoPage()),
  ];
}
