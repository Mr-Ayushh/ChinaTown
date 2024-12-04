import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dummy_1/screens/widgets/main_button.dart';
import 'package:dummy_1/utils/app_data.dart';
import 'package:dummy_1/utils/app_images.dart';
import 'package:dummy_1/utils/exports.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserDetailsScreen extends GetView<UserDetailsController> {
  final String? name;
  final String? address;
  final String? phone;
  final String? pincode;
  final bool? otpReq;
  const UserDetailsScreen({
    super.key,
    this.name,
    this.address,
    this.phone,
    this.pincode,
    this.otpReq,
  });

  @override
  Widget build(BuildContext context) {
    if (otpReq != null) {
      controller.nameController.text = name ?? '';
      controller.phoneNumberController.text = phone ?? '';
      controller.addressController.text = address ?? '';
      controller.pincodeController.text = pincode ?? '';
    }
    return Scaffold(
      backgroundColor: AppColors.primary,
      resizeToAvoidBottomInset: false,
      body: SizedBox(
        height: Get.height,
        child: Column(
          children: [
            SizedBox(
              height: Get.height * 0.15,
              child: Center(
                child: Text(
                  (otpReq != null && otpReq == true)
                      ? 'Profile Page'
                      : 'User Details',
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: Get.width,
                // height: Get.height * 0.85,
                decoration: const BoxDecoration(
                  color: AppColors.kF2F2F2,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 50,
                  ),
                  physics: const BouncingScrollPhysics(),
                  child: FutureBuilder<DocumentSnapshot>(
                      future: FirebaseFirestore.instance
                          .collection('UserMaster')
                          .doc(AppData.email)
                          .get(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (!snapshot.hasData ||
                            snapshot.data!.data() == null) {
                          return const Center(child: Text('User not found'));
                        }
                        Map<String, dynamic> userData =
                            snapshot.data?.data() as Map<String, dynamic>;
                        String? profilePicUrl = userData['profilePicPath'];
                        return Column(
                          children: [
                            (otpReq != null && otpReq == true)
                                ? profilePicUrl != null
                                    ? CircleAvatar(
                                        radius: 50,
                                        backgroundImage:
                                            NetworkImage(profilePicUrl),
                                      )
                                    : const CircleAvatar(
                                        radius: 50,
                                        child: Icon(Icons.person),
                                      )
                                : Container(
                                    width: 120,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.rectangle,
                                      image: DecorationImage(
                                        image: AssetImage(AppAssets.googleIcon),
                                        fit: BoxFit.cover,
                                      ),
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 4,
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ).onTap(() async {
                                    await controller.selectImage();
                                  }),
                            20.heightBox,
                            AbsorbPointer(
                              absorbing: (otpReq != null && otpReq == true),
                              child: controller.buildTextField(
                                name: 'fName',
                                label: 'Full name',
                                textController: controller.nameController,
                                validate: (value) {
                                  return null;
                                },
                              ),
                            ),
                            20.heightBox,
                            AbsorbPointer(
                              absorbing: (otpReq != null && otpReq == true),
                              child: controller.buildTextField(
                                name: 'address',
                                textController: controller.addressController,
                                label: 'Delivery Address',
                                validate: (value) {
                                  return null;
                                },
                              ),
                            ),
                            20.heightBox,
                            AbsorbPointer(
                              absorbing: (otpReq != null && otpReq == true),
                              child: controller.buildTextField(
                                name: 'pincode',
                                label: 'Pincode',
                                textController: controller.pincodeController,
                                maxLength: 6,
                                keyboardType: TextInputType.number,
                                validate: (value) {
                                  return null;
                                },
                              ),
                            ),
                            20.heightBox,
                            AbsorbPointer(
                              absorbing: (otpReq != null && otpReq == true),
                              child: controller.buildTextField(
                                name: 'phone',
                                label: 'Phone Number',
                                textController:
                                    controller.phoneNumberController,
                                maxLength: 10,
                                preFixIcon: const Center(
                                  child: Text('+91'),
                                ),
                                keyboardType: TextInputType.number,
                                validate: (value) {
                                  return null;
                                },
                              ),
                            ),
                            (otpReq != null && otpReq == true)
                                ? Container()
                                : 20.heightBox,
                            (otpReq != null && otpReq == true)
                                ? Container()
                                : controller.buildTextField(
                                    name: 'otp',
                                    label: 'OTP',
                                    textController: controller.otpController,
                                    maxLength: 6,
                                    keyboardType: TextInputType.number,
                                    validate: (value) {
                                      return null;
                                    },
                                  ),
                            (otpReq != null && otpReq == true)
                                ? Container()
                                : Align(
                                    alignment: Alignment.centerRight,
                                    child: TextButton(
                                      onPressed: () async {
                                        if (controller.phoneNumberController
                                            .text.isEmpty) {
                                          Get.dialog(
                                            AlertDialog(
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(15.0),
                                                ),
                                              ),
                                              title: const Text('Alert'),
                                              content: const Text(
                                                  'Please Enter Phone Number'),
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
                                        } else if (controller
                                                .phoneNumberController
                                                .text
                                                .length <
                                            10) {
                                          Get.dialog(
                                            AlertDialog(
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(15.0),
                                                ),
                                              ),
                                              title: const Text('Alert'),
                                              content: const Text(
                                                  'Please Enter Correct Phone Number'),
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
                                        } else {
                                          await FirebaseAuth.instance
                                              .verifyPhoneNumber(
                                                  phoneNumber:
                                                      '+91${controller.phoneNumberController.text}',
                                                  verificationCompleted:
                                                      ((phoneAuthCredential) {}),
                                                  verificationFailed:
                                                      (FirebaseAuthException
                                                          ex) {
                                                    Get.dialog(
                                                      AlertDialog(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15.0),
                                                        ),
                                                        title: const Text(
                                                            'Verification Failed'),
                                                        content: const Text(
                                                            'An error occurred while verifying your phone number.'),
                                                        actions: [
                                                          TextButton(
                                                            child: const Text(
                                                                'OK'),
                                                            onPressed: () {
                                                              Get.back();
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                  codeSent: ((verificationId,
                                                      forceResendingToken) {
                                                    if (verificationId
                                                        .isNotEmptyAndNotNull) {
                                                      AppData.verifyCode =
                                                          verificationId;
                                                      controller.verifyCode
                                                              .value =
                                                          verificationId;
                                                      controller.verifyCode
                                                          .refresh();
                                                    } else {
                                                      Get.dialog(
                                                        AlertDialog(
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15.0),
                                                          ),
                                                          title: const Text(
                                                              'Verification Failed'),
                                                          content: const Text(
                                                              'An error occurred while verifying your phone number.'),
                                                          actions: [
                                                            TextButton(
                                                              child: const Text(
                                                                  'OK'),
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context); // Close the dialog
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    }
                                                  }),
                                                  codeAutoRetrievalTimeout:
                                                      ((verificationId) {}));
                                        }
                                      },
                                      child: const Text('send otp'),
                                    ),
                                  ),
                            const SizedBox(height: 30),
                            (otpReq != null && otpReq == true)
                                ? Container()
                                : MainButton(
                                    onPressed: () async {
                                      if (controller
                                          .nameController.text.isEmpty) {
                                        Get.dialog(
                                          AlertDialog(
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(15.0),
                                              ),
                                            ),
                                            title: const Text('Alert'),
                                            content:
                                                const Text('Please Enter Name'),
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
                                      } else if (controller
                                          .addressController.text.isEmpty) {
                                        Get.dialog(
                                          AlertDialog(
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(15.0),
                                              ),
                                            ),
                                            title: const Text('Alert'),
                                            content: const Text(
                                                'Please Enter Address.'),
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
                                      } else if (controller
                                          .pincodeController.text.isEmpty) {
                                        Get.dialog(
                                          AlertDialog(
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(15.0),
                                              ),
                                            ),
                                            title: const Text('Alert'),
                                            content: const Text(
                                                'Please Enter Pincode.'),
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
                                      } else if (controller
                                          .phoneNumberController.text.isEmpty) {
                                        Get.dialog(
                                          AlertDialog(
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(15.0),
                                              ),
                                            ),
                                            title: const Text('Alert'),
                                            content: const Text(
                                                'Please Enter Phone Number'),
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
                                      } else if (controller
                                              .otpController.text.isEmpty &&
                                          otpReq == null) {
                                        Get.dialog(
                                          AlertDialog(
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(15.0),
                                              ),
                                            ),
                                            title: const Text('Alert'),
                                            content: const Text(
                                                'Please Enter OTP Number for verification.'),
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
                                      // try {
                                      // PhoneAuthCredential credential =
                                      //     PhoneAuthProvider.credential(
                                      //   verificationId: controller.verifyCode.value ??
                                      //       AppData.verifyCode,
                                      //   smsCode: controller.otpController.text,
                                      // );
                                      // await FirebaseAuth.instance
                                      //     .signInWithCredential(credential)
                                      //     .then(
                                      //   (value) async {
                                      AppData.isFirstTime = false;
                                      AppData.isUserLoggedIn = true;
                                      AppData.name =
                                          controller.nameController.text.trim();
                                      AppData.address = controller
                                          .addressController.text
                                          .trim();
                                      AppData.phone = controller
                                          .phoneNumberController.text
                                          .trim();
                                      AppData.pincode = controller
                                          .pincodeController.text
                                          .trim();
                                      // Step 1: Upload image to Firebase Storage
                                      String imageFileName =
                                          '${DateTime.now().millisecondsSinceEpoch}.jpg';
                                      Reference storageReference =
                                          FirebaseStorage.instance.ref().child(
                                              'profile_pics/$imageFileName');
                                      debugPrint(controller.image.path);
                                      UploadTask uploadTask = storageReference
                                          .putFile(controller.image);
                                      await uploadTask.whenComplete(() {});

                                      // Step 2: Get the download URL of the image
                                      String imageUrl = await storageReference
                                          .getDownloadURL();
                                      AppData.profilePic = imageUrl;
                                      await controller
                                          .updateDataService(
                                        controller.fetchedData['email'],
                                        controller.phoneNumberController.text
                                            .trim(),
                                        controller.pincodeController.text
                                            .trim(),
                                        controller.addressController.text
                                            .trim(),
                                        false,
                                        controller.fetchedData['uid'],
                                        controller.nameController.text.trim(),
                                        imageUrl,
                                      )
                                          .then(
                                        (value) {
                                          Get.toNamed(Routes.navigation);
                                        },
                                      );
                                      //   },
                                      // );
                                      // } catch (e) {
                                      //   debugPrint(e.toString());
                                      // }
                                    },
                                    text: 'Take Me to Home',
                                    minimumSize: const Size(180, 50),
                                  ),
                          ],
                        );
                      }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
