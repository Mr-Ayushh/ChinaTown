import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dummy_1/models/user_model.dart';
import 'package:dummy_1/screens/widgets/app_textfield.dart';
import 'package:dummy_1/utils/app_configuration.dart';
import 'package:dummy_1/utils/exports.dart';
import 'package:image_picker/image_picker.dart';

class UserDetailsController extends GetxController {
  Map<String, dynamic> fetchedData = {};
  Rx<String?> verifyCode = ''.obs;
  late File image;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  @override
  void onInit() {
    if (Get.arguments != null) {
      fetchedData = Get.arguments as Map<String, dynamic>;
      nameController.text = fetchedData['name'];
      if (fetchedData['phone'].toString().contains('+91')) {
        var number = fetchedData['phone'].toString().split('+91');
        phoneNumberController.text = number[1];
      } else {
        phoneNumberController.text = fetchedData['phone'];
      }
    } else {}

    super.onInit();
  }

  Future<void> selectImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image = File(pickedFile.path);
    }
  }
  Future<void> updateDataService(email, phone, pincode, address, isFirstTime,
      uid, name, profilePic) async {
    try {
      if (await checkConnection()) {
        loadingDialog();

        var collection = FirebaseFirestore.instance.collection('UserMaster');
        UserModel userModel = UserModel(
          name: name.toString().trim(),
          email: email.toString().trim(),
          phone: phone.toString().trim(),
          address: address.toString().trim(),
          pincode: pincode.toString().trim(),
          isFirstTime: true,
          profilePicPath: profilePic,
          uid: uid.toString().trim(),
        );
        await collection.doc(fetchedData['email']).update(userModel.toJson());

        Get.back();
        Get.back();
      } else {
        Get.back();
        Get.dialog(
          AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15.0),
              ),
            ),
            title: const Text('Alert'),
            content: const Text('Please turn on your internet connectivity...'),
            actions: [
              MaterialButton(
                child: const Text('Ok'),
                onPressed: () {
                  Get.back();
                  Get.focusScope?.unfocus();
                },
              )
            ],
          ),
          barrierDismissible: false,
        );
      }
    } catch (e) {
      Get.back();
      e.toString();
      Get.dialog(
        AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15.0),
            ),
          ),
          title: const Text('Alert'),
          content: const Text('Something went wrong...'),
          actions: [
            MaterialButton(
              child: const Text('Ok'),
              onPressed: () {
                Get.back();
                Get.focusScope?.unfocus();
              },
            )
          ],
        ),
        barrierDismissible: false,
      );
    }
  }

  Widget buildTextField({
    required String name,
    required String label,
    required TextEditingController textController,
    Widget? preFixIcon,
    int? maxLength,
    String? Function(dynamic)? validate,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 5),
        AppTextFormField(
          name: name,
          controller: textController,
          preFixIcon: preFixIcon,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
          validate: validate,
          showBorderRadius: true,
          maxLength: maxLength,
          borderRadius: 15,
          keyboardType: keyboardType,
        ),
      ],
    );
  }
}
