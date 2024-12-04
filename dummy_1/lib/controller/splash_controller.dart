import 'package:dummy_1/utils/app_data.dart';
import 'package:dummy_1/utils/exports.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    Future.delayed(
      const Duration(
        milliseconds: 2500,
      ),
      () {
        if (AppData.isFirstTime) {
          Get.offAndToNamed(Routes.loginPage);
        } else if (AppData.isUserLoggedIn) {
          if (AppData.email == 'chinatown') {
            Get.offAndToNamed(Routes.adminDashboard);
          } else {
            Get.offAndToNamed(Routes.navigation);
          }
        } else {
          Get.offAndToNamed(Routes.loginPage);
        }
      },
    );
    super.onInit();
  }
}
