import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dummy_1/screens/admin/beverages_list_page.dart';
import 'package:dummy_1/screens/admin/completed_orders.dart';
import 'package:dummy_1/screens/admin/featured_list_page.dart';
import 'package:dummy_1/screens/admin/non_veg_item_page.dart';
import 'package:dummy_1/screens/admin/pending_orders.dart';
import 'package:dummy_1/screens/admin/veg_item_page.dart';
import 'package:dummy_1/utils/app_data.dart';
import 'package:dummy_1/utils/exports.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              height: Get.height * 0.3,
              width: Get.width,
              decoration: const BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(
                    20,
                  ),
                  bottomRight: Radius.circular(
                    20,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Icon(
                      Icons.logout,
                      size: 20.sp,
                      weight: 700,
                      color: Colors.white,
                    ).onTap(() async {
                      await signOut().then(
                        (value) {
                          AppData.clear();
                          AppData.isUserLoggedIn = false;
                          Get.offNamedUntil(Routes.loginPage, (route) => false);
                        },
                      );
                    }),
                  ).pOnly(
                    right: 20,
                  ),
                  Text(
                    'CHINA TOWN',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(
                      20,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                    ),
                    child: FutureBuilder<Map<String, int>>(
                        future: getOrderCounts(),
                        builder: (context, snapshot) {
                          int pendingCount = 0;
                          int completedCount = 0;
                          if (snapshot.data != null) {
                            pendingCount = snapshot.data!['pending'] ?? 0;
                            completedCount = snapshot.data!['completed'] ?? 0;
                          }

                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  10.heightBox,
                                  Icon(
                                    Icons.info_outline,
                                    size: 20.sp,
                                    weight: 700,
                                    color: Colors.red,
                                  ),
                                  const Text(
                                    'Pending Order',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  5.heightBox,
                                  Text(
                                    pendingCount.toString(),
                                    style: const TextStyle(fontSize: 24),
                                  ),
                                ],
                              ).onTap(() {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return const PendingOrderListPage();
                                    },
                                  ),
                                );
                              }),
                              Column(
                                children: [
                                  10.heightBox,
                                  Icon(
                                    Icons.check_circle_outline,
                                    size: 20.sp,
                                    weight: 700,
                                    color: Colors.green,
                                  ),
                                  const Text(
                                    'Completed Order',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    completedCount.toString(),
                                    style: const TextStyle(fontSize: 24),
                                  ),
                                ],
                              ).onTap(() {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return const CompleteOrderListPage();
                                    },
                                  ),
                                );
                              }),
                            ],
                          );
                        }),
                  ),
                  20.heightBox,
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: Get.width * 0.4,
                          height: Get.height * 0.3,
                          padding: const EdgeInsets.all(
                            10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              'Featured Product',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ).onTap(() {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return const FeaturedProductListPage();
                              },
                            ),
                          );
                        }),
                        30.widthBox,
                        Container(
                          width: Get.width * 0.4,
                          height: Get.height * 0.3,
                          padding: const EdgeInsets.all(
                            10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              'Beverages',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ).onTap(
                          () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return const BeveragesListPage();
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ).pOnly(
                      left: 20,
                      right: 20,
                    ),
                  ),
                  10.heightBox,
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: Get.width * 0.4,
                          height: Get.height * 0.3,
                          padding: const EdgeInsets.all(
                            10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              'Vegetarian',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ).onTap(() {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return const VegListPage();
                              },
                            ),
                          );
                        }),
                        Container(
                          width: Get.width * 0.4,
                          height: Get.height * 0.3,
                          padding: const EdgeInsets.all(
                            10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              'Non Vegetarian',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ).onTap(
                          () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return const NonVegItemListPage();
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ).pOnly(
                      left: 20,
                      right: 20,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        // .pOnly(
        //   top: MediaQuery.of(context).padding.top,
        // ),
      ),
    );
  }

  static final CollectionReference _ordersCollection =
      FirebaseFirestore.instance.collection('ordersMaster');

  static Future<Map<String, int>> getOrderCounts() async {
    int pendingCount = 0;
    int completedCount = 0;

    try {
      QuerySnapshot querySnapshot =
          await _ordersCollection.get(); // Get all orders

      for (var doc in querySnapshot.docs) {
        String status = doc['status'];

        // Increment counts based on status
        if (status == 'pending') {
          pendingCount++;
        } else if (status == 'completed') {
          completedCount++;
        }
      }
    } catch (error) {
      debugPrint('Error getting order counts: $error');
      // Handle error
    }

    return {'pending': pendingCount, 'completed': completedCount};
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
