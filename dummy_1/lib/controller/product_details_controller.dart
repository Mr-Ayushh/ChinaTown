import 'package:dummy_1/utils/exports.dart';

class ProductDetailsController extends GetxController {
  Rx<int> counter = Rx<int>(1);
  Rx<String> selectedOption = Rx<String>('Half');
  Map<String, dynamic> fetchedData = {};
  bool isCombo = false;
  String? name;
  String? description;
  double? price;
  double? dummyPrice;
  String? picturePath;
  String? categoryName;
  @override
  void onInit() {
    if (Get.arguments != null) {
      fetchedData = Get.arguments as Map<String, dynamic>;
      if (fetchedData.isNotEmpty) {
        var data = fetchedData['item'] as Map<String, dynamic>;
        name = data['name'];
        description = data['description'];
        price = data['price'];
        dummyPrice = data['dummyPrice'];
        picturePath = data['picturePath'];
        categoryName = data['category'];
        isCombo = fetchedData['isCombo'] ?? false;
      }
    }

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

  Widget buildOptionRadioListTile({
    required String title,
    required String price,
    required String value,
    required String? groupValue,
    required ValueChanged<String?> onChanged,
  }) =>
      Row(
        children: [
          SizedBox(
            width: 200,
            child: RadioListTile<String>(
              title: Container(
                width: 50,
                padding: const EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                  color: AppColors.kFFDECF,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: AppColors.primary,
                  ),
                ),
              ),
              activeColor: AppColors.primary,
              value: value,
              groupValue: groupValue,
              onChanged: onChanged,
            ),
          ),
          Text(
            price,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      );
}
