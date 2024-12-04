// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dummy_1/models/user_model.dart';
// import 'package:dummy_1/utils/app_data.dart';
// import 'package:dummy_1/utils/exports.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class SignUpScreen extends StatefulWidget {
//   const SignUpScreen({super.key});

//   @override
//   State<SignUpScreen> createState() => _SignUpScreenState();
// }

// class _SignUpScreenState extends State<SignUpScreen> {
//   // final FirebaseAuth auth = FirebaseAuth.instance;
//   @override
//   Widget build(BuildContext context) {
//     final TextEditingController emailController = TextEditingController();
//     final TextEditingController passwordController = TextEditingController();
//     final TextEditingController confirmPasswordController =
//         TextEditingController();
//     return Scaffold(
//       body: Form(
//         // key: formKey,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: <Widget>[
//             TextFormField(
//               controller: emailController,
//               decoration: const InputDecoration(
//                 labelText: 'Email',
//                 border: OutlineInputBorder(),
//               ),
//               validator: (value) {
//                 if ((value ?? '').isEmpty) {
//                   return 'Please enter your email';
//                 }
//                 return null;
//               },
//             ),
//             const SizedBox(height: 20.0),
//             TextFormField(
//               controller: passwordController,
//               obscureText: true,
//               decoration: const InputDecoration(
//                 labelText: 'Password',
//                 border: OutlineInputBorder(),
//               ),
//               validator: (value) {
//                 if ((value ?? '').isEmpty) {
//                   return 'Please enter a password';
//                 }
//                 return null;
//               },
//             ),
//             const SizedBox(height: 20.0),
//             TextFormField(
//               controller: confirmPasswordController,
//               obscureText: true,
//               decoration: const InputDecoration(
//                 labelText: 'Confirm Password',
//                 border: OutlineInputBorder(),
//               ),
//               validator: (value) {
//                 if ((value ?? '').isEmpty) {
//                   return 'Please confirm your password';
//                 }
//                 if (value != passwordController.text) {
//                   return 'Passwords do not match';
//                 }
//                 return null;
//               },
//             ),
//             const SizedBox(height: 20.0),
//             ElevatedButton(
//               onPressed: () async {
//                 if (emailController.text.trim().isEmpty) {
//                   Get.dialog(
//                     AlertDialog(
//                       shape: const RoundedRectangleBorder(
//                         borderRadius: BorderRadius.all(
//                           Radius.circular(15.0),
//                         ),
//                       ),
//                       title: const Text('Alert'),
//                       content: const Text('Please Enter Correct Email.'),
//                       actions: [
//                         MaterialButton(
//                           child: const Text('Ok'),
//                           onPressed: () {
//                             Get.back();
//                             Get.focusScope?.unfocus();
//                           },
//                         )
//                       ],
//                     ),
//                     barrierDismissible: false,
//                   );
//                 } else if (passwordController.text.trim().isEmpty) {
//                   Get.dialog(
//                     AlertDialog(
//                       shape: const RoundedRectangleBorder(
//                         borderRadius: BorderRadius.all(
//                           Radius.circular(15.0),
//                         ),
//                       ),
//                       title: const Text('Alert'),
//                       content: const Text('Please Enter Password.'),
//                       actions: [
//                         MaterialButton(
//                           child: const Text('Ok'),
//                           onPressed: () {
//                             Get.back();
//                             Get.focusScope?.unfocus();
//                           },
//                         )
//                       ],
//                     ),
//                     barrierDismissible: false,
//                   );
//                 } else if (confirmPasswordController.text.trim().isEmpty) {
//                   Get.dialog(
//                     AlertDialog(
//                       shape: const RoundedRectangleBorder(
//                         borderRadius: BorderRadius.all(
//                           Radius.circular(15.0),
//                         ),
//                       ),
//                       title: const Text('Alert'),
//                       content: const Text('Please Enter Confirm Password.'),
//                       actions: [
//                         MaterialButton(
//                           child: const Text('Ok'),
//                           onPressed: () {
//                             Get.back();
//                             Get.focusScope?.unfocus();
//                           },
//                         )
//                       ],
//                     ),
//                     barrierDismissible: false,
//                   );
//                 }
//                 if (passwordController.text.trim() !=
//                     confirmPasswordController.text.trim()) {
//                   Get.dialog(
//                     AlertDialog(
//                       shape: const RoundedRectangleBorder(
//                         borderRadius: BorderRadius.all(
//                           Radius.circular(15.0),
//                         ),
//                       ),
//                       title: const Text('Alert'),
//                       content: const Text(
//                           'Password and Correct Passowrd doesn\'t match.'),
//                       actions: [
//                         MaterialButton(
//                           child: const Text('Ok'),
//                           onPressed: () {
//                             Get.back();
//                             Get.focusScope?.unfocus();
//                           },
//                         )
//                       ],
//                     ),
//                     barrierDismissible: false,
//                   );
//                 }
//                 // if (formKey.currentState!.validate()) {
//                 await handleSignUp(
//                     emailController.text, passwordController.text);
//               },
//               // },
//               child: const Text('Sign Up'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   saveUsersData(UserCredential userData) async {
//     // int userId = await generateUniqueNumber();
//     UserModel userModel = UserModel(
//       name: userData.user?.displayName?.trim(),
//       email: userData.user?.email?.trim(),
//       phone: userData.user?.phoneNumber?.trim(),
//       pincode: '',
//       isFirstTime: true,
//       uid: userData.user!.uid,
//     );
//     FirebaseFirestore.instance
//         .collection('UserMaster')
//         .doc(userData.user?.email)
//         .set(userModel.toJson())
//         .then(
//       (value) {
//         AppData.email = userData.user?.email ?? '';
//         AppData.isFirstTime = true;
//         AppData.isUserLoggedIn = true;
//         Get.toNamed(
//           Routes.userDetailsPage,
//           arguments: {
//             'email': userData.user?.email ?? '',
//             'phone': userData.user?.phoneNumber ?? '',
//             'name': userData.user?.displayName ?? '',
//             'uid': userData.user?.uid ?? '',
//           },
//         );
//       },
//     );
//   }

//   handleSignUp(email, password) async {
//     await FirebaseAuth.instance
//         .createUserWithEmailAndPassword(email: email, password: password)
//         .then((userCred) async {
//       FirebaseFirestore firestore = FirebaseFirestore.instance;
//       CollectionReference userMasterCollection =
//           firestore.collection('UserMaster');

//       var firebaseChecker = await userMasterCollection.get();
//       // QuerySnapshot querySnapshot =
//       if (firebaseChecker.docs.isEmpty) {
//         await saveUsersData(userCred);
//       } else {
//         await userMasterCollection
//             .where('email', isEqualTo: userCred.user?.email)
//             .get()
//             .then(
//           (querySnapshot) async {
//             if (querySnapshot.docs.isEmpty) {
//               // Set New User Data
//               await saveUsersData(userCred);
//             } else {
//               DocumentReference userDocRef =
//                   userMasterCollection.doc(userCred.user?.email);
//               await userDocRef.get().then(
//                 (userDoc) async {
//                   if (userDoc.exists) {
//                     // Map<String, dynamic> callData = userDoc.data(); // Explicit type cast
//                     var userData = userDoc.data() as Map<String, dynamic>;
//                     UserModel userModel = UserModel.fromMap(userData);
//                     if (userModel.isFirstTime == true &&
//                         userModel.address.isEmptyOrNull) {
//                       Get.toNamed(
//                         Routes.userDetailsPage,
//                         arguments: {
//                           'email': userModel.email ?? '',
//                           'phone': userModel.phone ?? '',
//                           'uid': userModel.uid ?? '',
//                           'name': userModel.name ?? '',
//                         },
//                       );
//                     } else {
//                       AppData.name = userModel.name ?? '';
//                       AppData.email = userModel.email ?? '';
//                       AppData.phone = userModel.phone ?? '';
//                       AppData.address = userModel.address ?? '';
//                       AppData.isFirstTime = userModel.isFirstTime;
//                       AppData.isUserLoggedIn = true;
//                       AppData.pincode = userModel.pincode ?? '';
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => const HomePage()),
//                       );
//                     }
//                     debugPrint('Normal Login Success');
//                   } else {
//                     debugPrint('User document does not exist');

//                     await saveUsersData(userCred);
//                     debugPrint('User Data created successfully');
//                   }
//                 },
//               );
//             }
//           },
//         );
//       }
//     });
//   }
// }
