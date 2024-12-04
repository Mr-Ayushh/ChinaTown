import 'package:dummy_1/controller/splash_controller.dart';
import 'package:dummy_1/utils/exports.dart';

import '../../utils/app_images.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: AppColors.white,
        ),
        height: Get.height,
        width: Get.width,
        child: Center(
          child: Image.asset(
            AppAssets.splash,
            height: 200,
          ),
        ),
      ),
    );
  }
}
