import 'package:dummy_1/utils/app_data.dart';
import 'package:dummy_1/utils/exports.dart';

class CartController extends GetxController {
  Rx<int> counter = Rx<int>(1);
  TextEditingController addressController = TextEditingController();

  @override
  void onInit() {
    addressController.text = AppData.address;
    super.onInit();
  }

  void incrementCounter() {
    counter.value++;
  }

  void decrementCounter() {
    if (counter.value > 1) {
      counter.value--;
    }
  }

  Row buildTextRow({
    required String leadingText,
    required String trailingText,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          leadingText,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Text(
          trailingText,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}
