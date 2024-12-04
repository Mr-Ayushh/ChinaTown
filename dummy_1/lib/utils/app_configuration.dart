import 'package:dummy_1/utils/exports.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class LoadingDialog extends Dialog {
  const LoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          decoration: const ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  10,
                ),
              ),
            ),
          ),
          width: 80,
          height: 80,
          padding: const EdgeInsets.all(10),
          child: const Center(
            child: CircularProgressIndicator(
              color: AppColors.primary,
            ),
          ),
        ),
      ),
    );
  }
}

checkConnection() async {
  return await InternetConnectionChecker().hasConnection;
}

loadingDialog() {
  Get.dialog(
    PopScope(
      canPop: true,
      onPopInvoked: (value) async => false,
      child: const LoadingDialog(),
    ),
    barrierDismissible: false,
  );
}
