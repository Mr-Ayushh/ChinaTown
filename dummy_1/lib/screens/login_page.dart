import 'package:dummy_1/screens/widgets/app_textfield.dart';
import 'package:dummy_1/screens/widgets/main_button.dart';
import 'package:dummy_1/utils/app_data.dart';
import 'package:dummy_1/utils/app_images.dart';
import 'package:dummy_1/utils/exports.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offwhite,
      body: DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Column(
          children: [
            Stack(
              children: [
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 10,
                  top: 40,
                  child: Transform.translate(
                    offset: const Offset(-10, 10),
                    child: Image.asset(
                      AppAssets.loginImage,
                    ),
                  ),
                ),
                Container(
                  width: Get.width,
                  height: Get.height / 3.1,
                  decoration: BoxDecoration(
                    color: AppColors.transparent,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TabBar(
                        labelPadding: EdgeInsets.symmetric(vertical: 10),
                        indicatorColor: AppColors.primary,
                        unselectedLabelColor: AppColors.black,
                        labelColor: AppColors.primary,
                        indicatorSize: TabBarIndicatorSize.label,
                        tabs: <Widget>[
                          Text(
                            'Login',
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            'Sign-up',
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: <Widget>[
                  SingleChildScrollView(
                    padding: const EdgeInsets.all(50),
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTextFormField(
                          name: 'email',
                          controller: controller.emailController,
                          hintText: 'Email',
                          fillColor: Colors.transparent,
                          hasBorder: true,
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 10),
                        ),
                        40.heightBox,
                        Obx(() {
                          return AppTextFormField(
                            name: 'password',
                            controller: controller.passwordController,
                            hintText: 'Password',
                            hasBorder: true,
                            isObscure: controller.isObscure.value,
                            fillColor: Colors.transparent,
                            suffixIcon: controller.isObscure.value
                                ? const Icon(
                                    Icons.lock,
                                  ).onTap(() {
                                    controller.isObscure.value =
                                        !controller.isObscure.value;
                                    controller.isObscure.refresh();
                                  })
                                : const Icon(
                                    Icons.lock_open,
                                  ).onTap(() {
                                    controller.isObscure.value =
                                        !controller.isObscure.value;
                                    controller.isObscure.refresh();
                                  }),
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 10),
                          );
                        }),
                        10.heightBox,
                        const Text(
                          'Forgot password?',
                          style: TextStyle(color: AppColors.secondary),
                        ).onTap(
                          () {
                            Get.dialog(
                              AlertDialog(
                                title: const Text('Forgot Password'),
                                content: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      TextField(
                                        controller:
                                            controller.forgotemailController,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        decoration: const InputDecoration(
                                          labelText: 'Email',
                                          hintText: 'Enter your email',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      controller.resetPassword(controller
                                          .forgotemailController.text
                                          .trim());
                                      Get.back();
                                    },
                                    child: const Text('Reset Password'),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        // const SizedBox(height: 5),
                        MainButton(
                          onPressed: () {
                            if (controller.emailController.text ==
                                'chinatown') {
                              if (controller.passwordController.text ==
                                  'chinatown@123') {
                                AppData.isUserLoggedIn = true;
                                AppData.isFirstTime = false;
                                AppData.email = 'chinatown';
                                Get.offAndToNamed(Routes.adminDashboard);
                              } else {
                                Get.dialog(
                                  AlertDialog(
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(15.0),
                                      ),
                                    ),
                                    title: const Text('Alert'),
                                    content: const Text('Incorrect Password'),
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
                            } else {
                              controller.handleSignInEmail(
                                controller.emailController.text,
                                controller.passwordController.text,
                              );
                            }
                          },
                          text: 'Login',
                        ),
                        MainButton.icon(
                          buttonColor: AppColors.white,
                          fontColor: AppColors.black,
                          mainAxisAlignment: MainAxisAlignment.center,
                          borderSide:
                              const BorderSide(color: AppColors.grey200),
                          icon: SizedBox(
                            height: 15,
                            child: Image(
                              image: AssetImage(
                                AppAssets.googleIcon,
                              ),
                            ),
                          ),
                          horizontalSpace: 10,
                          onPressed: () async {
                            await controller.signInGoogle('');
                          },
                          isIconAtStart: true,
                          text: 'Continue with Google',
                          fontSize: 16,
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    padding: const EdgeInsets.all(50),
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        AppTextFormField(
                          name: 'email',
                          hintText: 'Email',
                          controller: controller.signEmailController,
                          preFixIcon: const Icon(Icons.mail),
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 20),
                          showBorderRadius: true,
                          borderRadius: 15,
                        ),
                        const SizedBox(height: 12),
                        Obx(() {
                          return AppTextFormField(
                            name: 'password',
                            hintText: 'Password',
                            controller: controller.signPasswordController,
                            preFixIcon: const Icon(Icons.lock_outline),
                            isObscure: controller.isObscure.value,
                            suffixIcon: controller.isObscure.value
                                ? const Icon(Icons.lock).onTap(() {
                                    controller.isObscure.value =
                                        !controller.isObscure.value;
                                    controller.isObscure.refresh();
                                  })
                                : const Icon(Icons.lock_open).onTap(() {
                                    controller.isObscure.value =
                                        !controller.isObscure.value;
                                    controller.isObscure.refresh();
                                  }),
                            showBorderRadius: true,
                            borderRadius: 15,
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 20),
                          );
                        }),
                        const SizedBox(height: 100),
                        MainButton(
                          onPressed: () async {
                            if (controller.signEmailController.text
                                .trim()
                                .isEmpty) {
                              Get.dialog(
                                AlertDialog(
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15.0),
                                    ),
                                  ),
                                  title: const Text('Alert'),
                                  content:
                                      const Text('Please Enter Correct Email.'),
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
                            } else if (controller.signPasswordController.text
                                .trim()
                                .isEmpty) {
                              Get.dialog(
                                AlertDialog(
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15.0),
                                    ),
                                  ),
                                  title: const Text('Alert'),
                                  content: const Text('Please Enter Password.'),
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
                            await controller.handleSignUp(
                                controller.signEmailController.text,
                                controller.signPasswordController.text,
                                '');
                          },
                          text: 'Create Account',
                          minimumSize: const Size(180, 50),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
