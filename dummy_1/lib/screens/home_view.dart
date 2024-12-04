import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dummy_1/utils/app_data.dart';
import 'package:dummy_1/utils/app_images.dart';
import 'package:dummy_1/utils/exports.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.put(HomeController());
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        backgroundColor: AppColors.offwhite,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          automaticallyImplyLeading: false,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello ${AppData.name.contains(' ') ? AppData.name.split(' ')[0] : AppData.name}👋🏻',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primary,
                ),
              ),
              const Text(
                'Welcome',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
              ),
            ],
          ),
          centerTitle: false,
          actions: [
            IconButton(
              onPressed: () {
                Get.toNamed(
                  Routes.cartPage,
                );
              },
              icon: Icon(
                Icons.shopping_cart_rounded,
                size: 30.sp,
                color: AppColors.primary,
              ),
            ),
            5.widthBox,
            Icon(
              Icons.logout,
              size: 28.sp,
              color: AppColors.primary,
              weight: 700,
            ).onTap(
              () async {
                await controller.signOut().then(
                  (value) {
                    AppData.clear();
                    AppData.isUserLoggedIn = false;
                    Get.offNamedUntil(Routes.loginPage, (route) => false);
                  },
                );
              },
            ),
            5.widthBox,
          ],
        ),
        body: Column(
          children: [
            Container(
              width: Get.width,
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: SizedBox(
                      height: 170,
                      child: StreamBuilder<QuerySnapshot>(
                        stream: controller.featuredStream,
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return const Center(
                                child: Text('Something went wrong'));
                          } else if (snapshot.hasData &&
                              snapshot.data!.docs.isNotEmpty) {
                            return ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              padding: const EdgeInsets.only(
                                top: 20,
                              ),
                              itemBuilder: (context, index) {
                                var item = snapshot.data!.docs[index].data()
                                    as Map<String, dynamic>;
                                String name = item['name'];
                                String description = item['description'];
                                double price = item['price'];
                                String picturePath = item['picturePath'];
                                String categoryName = item['category'];

                                return Image.network(
                                  picturePath ?? '',
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(AppAssets.banner);
                                  },
                                )
                                    .pOnly(
                                  left: index == 0 ? 30 : 20,
                                  right:
                                      ((snapshot.data?.docs.length ?? 1) - 1) ==
                                              index
                                          ? 30
                                          : 0,
                                )
                                    .onTap(() {
                                  Get.toNamed(
                                    Routes.productDetailView,
                                    arguments: {
                                      'item': item,
                                      'isCombo': true,
                                    },
                                  );
                                });
                              },
                            );
                          } else {
                            return const Center(child: Text('No items found'));
                          }
                        },
                      ),
                    ),
                  ),
                  const TabBar(
                    dividerColor: Colors.transparent,
                    unselectedLabelColor: AppColors.black,
                    labelColor: AppColors.primary,
                    labelPadding: EdgeInsets.symmetric(vertical: 10),
                    indicatorColor: AppColors.primary,
                    indicatorSize: TabBarIndicatorSize.label,
                    tabs: <Widget>[
                      Text(
                        'Non-Veg',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        'Veg',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        'Beverages',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: TabBarView(
                children: <Widget>[
                  // Non Veg Stream Data
                  StreamBuilder<QuerySnapshot>(
                    stream: controller.nonVegStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Center(
                            child: Text('Something went wrong'));
                      } else if (snapshot.hasData &&
                          snapshot.data!.docs.isNotEmpty) {
                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          padding: const EdgeInsets.only(
                            top: 20,
                          ),
                          itemBuilder: (context, index) {
                            var item = snapshot.data!.docs[index].data()
                                as Map<String, dynamic>;
                            String name = item['name'];
                            String description = item['description'];
                            double price = item['price'] != null
                                ? double.parse(item['price'].toString())
                                : 0.0;
                            String picturePath = item['picturePath'];
                            String categoryName = item['category'];

                            return ListTile(
                              title: Text(name),
                              subtitle: Text(description),
                              leading: Image.network(
                                picturePath,
                                height: 40,
                                width: 40,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                    ),
                                    child: Icon(
                                      Icons.image_not_supported,
                                      size: 20.sp,
                                      weight: 700,
                                    ),
                                  );
                                },
                              ),
                              trailing: Text(
                                '₹$price',
                                style: TextStyle(
                                  color: AppColors.secondary,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                              ),
                              tileColor: Colors.white,
                              titleTextStyle: TextStyle(
                                color: AppColors.black,
                                fontSize: 22.sp,
                                fontWeight: FontWeight.w700,
                              ),
                              subtitleTextStyle: TextStyle(
                                color: Colors.black87,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                              onTap: () {
                                Get.toNamed(
                                  Routes.productDetailView,
                                  arguments: {
                                    'item': item,
                                  },
                                );
                              },
                            ).pOnly(
                              left: 20,
                              right: 20,
                              bottom: 10,
                            );
                          },
                        );
                      } else {
                        return const Center(child: Text('No items found'));
                      }
                    },
                  ),
                  // Veg Stream Data
                  StreamBuilder<QuerySnapshot>(
                    stream: controller.vegStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Center(
                            child: Text('Something went wrong'));
                      } else if (snapshot.hasData &&
                          snapshot.data!.docs.isNotEmpty) {
                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          padding: const EdgeInsets.only(
                            top: 20,
                          ),
                          itemBuilder: (context, index) {
                            var item = snapshot.data!.docs[index].data()
                                as Map<String, dynamic>;
                            String name = item['name'];
                            String description = item['description'];
                            double price = item['price'];
                            String picturePath = item['picturePath'];
                            String categoryName = item['category'];

                            return ListTile(
                              title: Text(name),
                              subtitle: Text(description),
                              leading: Image.network(
                                picturePath,
                                height: 40,
                                width: 40,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                    ),
                                    child: Icon(
                                      Icons.image_not_supported,
                                      size: 20.sp,
                                      weight: 700,
                                    ),
                                  );
                                },
                              ),
                              trailing: Text(
                                '₹$price',
                                style: TextStyle(
                                  color: AppColors.secondary,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                              ),
                              tileColor: Colors.white,
                              titleTextStyle: TextStyle(
                                color: AppColors.black,
                                fontSize: 22.sp,
                                fontWeight: FontWeight.w700,
                              ),
                              subtitleTextStyle: TextStyle(
                                color: Colors.black87,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                              onTap: () {
                                Get.toNamed(
                                  Routes.productDetailView,
                                  arguments: {
                                    'item': item,
                                  },
                                );
                              },
                            ).pOnly(
                              left: 20,
                              right: 20,
                              bottom: 10,
                            );
                          },
                        );
                      } else {
                        return const Center(child: Text('No items found'));
                      }
                    },
                  ),
                  // Beverages Stream Data
                  StreamBuilder<QuerySnapshot>(
                    stream: controller.beveragesStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Center(
                            child: Text('Something went wrong'));
                      } else if (snapshot.hasData &&
                          snapshot.data!.docs.isNotEmpty) {
                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          padding: const EdgeInsets.only(
                            top: 20,
                          ),
                          itemBuilder: (context, index) {
                            var item = snapshot.data!.docs[index].data()
                                as Map<String, dynamic>;
                            String name = item['name'];
                            String description = item['description'];
                            double price = item['price'];
                            String picturePath = item['picturePath'];
                            String categoryName = item['category'];

                            return ListTile(
                              title: Text(name),
                              subtitle: Text(description),
                              leading: Image.network(
                                picturePath,
                                height: 40,
                                width: 40,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                    ),
                                    child: Icon(
                                      Icons.image_not_supported,
                                      size: 20.sp,
                                      weight: 700,
                                    ),
                                  );
                                },
                              ),
                              trailing: Text(
                                '₹$price',
                                style: TextStyle(
                                  color: AppColors.secondary,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  10,
                                ),
                              ),
                              tileColor: Colors.white,
                              titleTextStyle: TextStyle(
                                color: AppColors.black,
                                fontSize: 22.sp,
                                fontWeight: FontWeight.w700,
                              ),
                              subtitleTextStyle: TextStyle(
                                color: Colors.black87,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                              onTap: () {
                                Get.toNamed(
                                  Routes.productDetailView,
                                  arguments: {
                                    'item': item,
                                  },
                                );
                              },
                            ).pOnly(
                              left: 20,
                              right: 20,
                              bottom: 10,
                            );
                          },
                        );
                      } else {
                        return const Center(child: Text('No items found'));
                      }
                    },
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
