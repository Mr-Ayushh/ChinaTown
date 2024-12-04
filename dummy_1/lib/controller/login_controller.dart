import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dummy_1/models/user_model.dart';
import 'package:dummy_1/utils/app_data.dart';
import 'package:dummy_1/utils/exports.dart';
import 'package:dummy_1/utils/unique_id.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController signEmailController = TextEditingController();
  final TextEditingController signPasswordController = TextEditingController();
  final TextEditingController forgotemailController = TextEditingController();
  Rx<bool> isObscure = true.obs;

  final FirebaseFirestore firebaseIn = FirebaseFirestore.instance;

  handleSignInEmail(String email, String password) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference userMasterCollection =
          firestore.collection('UserMaster');

      var firebaseChecker = await userMasterCollection.get();
      if (firebaseChecker.docs.isEmpty) {
        Get.dialog(
          AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15.0),
              ),
            ),
            title: const Text('Alert'),
            content: const Text('User doesn\'t exits.'),
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
        await userMasterCollection
            .where('email', isEqualTo: emailController.text)
            .get()
            .then(
          (querySnapshot) async {
            if (querySnapshot.docs.isEmpty) {
              Get.dialog(
                AlertDialog(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15.0),
                    ),
                  ),
                  title: const Text('Alert'),
                  content: const Text('User doesn\'t exits.'),
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
              DocumentReference userDocRef = userMasterCollection.doc(
                emailController.text,
              );
              await userDocRef.get().then(
                (userDoc) async {
                  if (userDoc.exists) {
                    // Map<String, dynamic> callData = userDoc.data(); // Explicit type cast
                    var userData = userDoc.data() as Map<String, dynamic>;
                    UserModel userModel = UserModel.fromMap(userData);
                    if (userModel.isFirstTime == true &&
                        userModel.pincode.isEmptyOrNull) {
                      Get.toNamed(
                        Routes.userDetailsPage,
                        arguments: {
                          'email': userModel.email ?? '',
                          'phone': userModel.phone ?? '',
                          'uid': userModel.uid ?? '',
                          'name': userModel.name ?? '',
                        },
                      );
                    } else {
                      AppData.name = userModel.name ?? '';
                      AppData.email = userModel.email ?? '';
                      AppData.phone = userModel.phone ?? '';
                      AppData.address = userModel.address ?? '';
                      AppData.isFirstTime = userModel.isFirstTime;
                      AppData.isUserLoggedIn = true;
                      AppData.pincode = userModel.pincode ?? '';
                      Get.toNamed(Routes.navigation);
                    }

                    debugPrint('Google Login Success');
                  } else {
                    debugPrint('User document does not exist');
                    Get.dialog(
                      AlertDialog(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15.0),
                          ),
                        ),
                        title: const Text('Alert'),
                        content: const Text('User doesn\'t exits.'),
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
                },
              );
            }
          },
        );
      }
    }).catchError((error) {
      String errorMessage = '';

      if (error is FirebaseAuthException) {
        switch (error.code) {
          case 'user-not-found':
            errorMessage = 'User not found.';
            break;
          case 'wrong-password':
            errorMessage = 'Incorrect password.';
            break;
          case 'invalid-email':
            errorMessage = 'Invalid email format.';
            break;
          case 'invalid-credential':
            errorMessage = 'Invalid credentials.';
            break;
          default:
            errorMessage = 'An error occurred. Please try again later.';
        }
      } else {
        errorMessage = 'An error occurred. Please try again later.';
      }

      Get.dialog(
        AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15.0),
            ),
          ),
          title: const Text('Alert'),
          content: Text(errorMessage),
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
    });
  }

  signInGoogle(String address) async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // UserCredential userCred =
    await FirebaseAuth.instance.signInWithCredential(credential).then(
      (userCred) async {
        FirebaseFirestore firestore = FirebaseFirestore.instance;
        CollectionReference userMasterCollection =
            firestore.collection('UserMaster');

        var firebaseChecker = await firestore.collection('UserMaster').get();
        // QuerySnapshot querySnapshot =
        if (firebaseChecker.docs.isEmpty) {
          await saveUsersDataSign(userCred, address);
        } else {
          await userMasterCollection
              .where('email', isEqualTo: userCred.user?.email)
              .get()
              .then(
            (querySnapshot) async {
              if (querySnapshot.docs.isEmpty) {
                // Set New User Data
                await saveUsersDataSign(userCred, address);
              } else {
                DocumentReference userDocRef =
                    userMasterCollection.doc(userCred.user?.email);
                await userDocRef.get().then(
                  (userDoc) async {
                    if (userDoc.exists) {
                      // Map<String, dynamic> callData = userDoc.data(); // Explicit type cast
                      var userData = userDoc.data() as Map<String, dynamic>;
                      UserModel userModel = UserModel.fromMap(userData);
                      if (userModel.pincode.isEmptyOrNull) {
                        Get.toNamed(
                          Routes.userDetailsPage,
                          arguments: {
                            'email': userModel.email ?? '',
                            'phone': userModel.phone ?? '',
                            'uid': userModel.uid ?? '',
                            'name': userModel.name ?? '',
                          },
                        );
                      } else {
                        AppData.name = userModel.name ?? '';
                        AppData.email = userModel.email ?? '';
                        AppData.phone = userModel.phone ?? '';
                        AppData.address = userModel.address ?? '';
                        AppData.isFirstTime = false;
                        AppData.isUserLoggedIn = true;
                        AppData.pincode = userModel.pincode ?? '';
                        Get.toNamed(Routes.navigation);
                      }

                      debugPrint('Google Login Success');
                    } else {
                      debugPrint('User document does not exist');

                      await saveUsersDataSign(userCred, address);
                      debugPrint('User Data created successfully');
                    }
                  },
                );
              }
            },
          );
        }
      },
    );
  }

  saveUsersDataSign(UserCredential userData, String address) async {
    // int userId = await generateUniqueNumber();
    UserModel userModel = UserModel(
      name: userData.user?.displayName?.trim(),
      email: userData.user?.email?.trim(),
      phone: userData.user?.phoneNumber?.trim(),
      address: address,
      pincode: '',
      isFirstTime: false,
      uid: userData.user!.uid,
    );
    firebaseIn
        .collection('UserMaster')
        .doc(userData.user?.email)
        .set(userModel.toJson())
        .then(
      (value) {
        AppData.email = userData.user?.email ?? '';
        AppData.isFirstTime = true;
        AppData.isUserLoggedIn = true;
        Get.toNamed(
          Routes.userDetailsPage,
          arguments: {
            'email': userData.user?.email ?? '',
            'phone': userData.user?.phoneNumber ?? '',
            'uid': userData.user?.uid ?? '',
            'name': userData.user?.displayName ?? '',
          },
        );
      },
    );
  }

  Future<int> generateUniqueNumber() async {
    // Initialize Firebase
    await Firebase.initializeApp();

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference userMasterCollection =
        firestore.collection('UserMaster');

    int uniqueNumber = SafeIntIdCustom(random: Random.secure()).get9DigitId();

    QuerySnapshot querySnapshot = await userMasterCollection
        .where('userId', isEqualTo: uniqueNumber)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      // If the number is not unique, recursively call the function again
      return generateUniqueNumber();
    } else {
      return uniqueNumber;
    }
  }

  saveUsersData(UserCredential userData) async {
    // int userId = await generateUniqueNumber();
    UserModel userModel = UserModel(
      name: userData.user?.displayName?.trim(),
      email: userData.user?.email?.trim(),
      phone: userData.user?.phoneNumber?.trim(),
      pincode: '',
      isFirstTime: true,
      uid: userData.user!.uid,
    );
    FirebaseFirestore.instance
        .collection('UserMaster')
        .doc(userData.user?.email)
        .set(userModel.toJson())
        .then(
      (value) {
        AppData.email = userData.user?.email ?? '';
        AppData.isFirstTime = true;
        AppData.isUserLoggedIn = true;
        Get.offAndToNamed(
          Routes.userDetailsPage,
          arguments: {
            'email': userData.user?.email ?? '',
            'phone': userData.user?.phoneNumber ?? '',
            'name': userData.user?.displayName ?? '',
            'uid': userData.user?.uid ?? '',
          },
        );
      },
    );
  }

  handleSignUp(email, password, address) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((userCred) async {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference userMasterCollection =
          firestore.collection('UserMaster');

      var firebaseChecker = await userMasterCollection.get();
      // QuerySnapshot querySnapshot =
      if (firebaseChecker.docs.isEmpty) {
        await saveUsersDataSign(userCred, address);
      } else {
        await userMasterCollection
            .where('email', isEqualTo: userCred.user?.email)
            .get()
            .then(
          (querySnapshot) async {
            if (querySnapshot.docs.isEmpty) {
              // Set New User Data
              await saveUsersDataSign(userCred, address);
            } else {
              DocumentReference userDocRef =
                  userMasterCollection.doc(userCred.user?.email);
              await userDocRef.get().then(
                (userDoc) async {
                  if (userDoc.exists) {
                    // Map<String, dynamic> callData = userDoc.data(); // Explicit type cast
                    var userData = userDoc.data() as Map<String, dynamic>;
                    UserModel userModel = UserModel.fromMap(userData);
                    if (userModel.isFirstTime == true &&
                        userModel.address.isEmptyOrNull) {
                      Get.offAndToNamed(
                        Routes.userDetailsPage,
                        arguments: {
                          'email': userModel.email ?? '',
                          'phone': userModel.phone ?? '',
                          'uid': userModel.uid ?? '',
                          'name': userModel.name ?? '',
                        },
                      );
                    } else {
                      AppData.name = userModel.name ?? '';
                      AppData.email = userModel.email ?? '';
                      AppData.phone = userModel.phone ?? '';
                      AppData.address = userModel.address ?? '';
                      AppData.isFirstTime = userModel.isFirstTime;
                      AppData.isUserLoggedIn = true;
                      AppData.pincode = userModel.pincode ?? '';
                      Get.offAndToNamed(
                        Routes.homePage,
                      );
                    }
                    debugPrint('Normal Login Success');
                  } else {
                    debugPrint('User document does not exist');

                    await saveUsersDataSign(userCred, address);
                    debugPrint('User Data created successfully');
                  }
                },
              );
            }
          },
        );
      }
    });
  }

  Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      _showResetSuccessDialog();
    } catch (e) {
      _showErrorDialog('Password Reset Failed', e.toString());
    }
  }

  void _showResetSuccessDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('Password Reset'),
        content: const Text('Password reset link sent to your email.'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String title, String errorMessage) {
    Get.dialog(
      AlertDialog(
        title: Text(title),
        content: Text(errorMessage),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
