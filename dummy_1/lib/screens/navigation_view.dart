import 'package:dummy_1/controller/navigation_controller.dart';
import 'package:dummy_1/utils/app_data.dart';

import '../utils/exports.dart';
import 'home_view.dart';
import 'presentation/screens/order_view.dart';

class NavigationView extends GetView<NavigationController> {
  const NavigationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: IndexedStack(
          index: controller.currentIndex.value,
          children: [
            UserDetailsScreen(
              address: AppData.address,
              name: AppData.name,
              phone: AppData.phone,
              pincode: AppData.pincode,
              otpReq: true,
            ),
            const HomeView(),
            const OrderView(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.white,
          unselectedItemColor: Colors.grey,
          backgroundColor: AppColors.primary,
          currentIndex: controller.currentIndex.value,
          onTap: (index) {
            controller.currentIndex.value = index;
            controller.currentIndex.refresh();
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'Profile',
              activeIcon: Icon(Icons.person),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
              activeIcon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_outlined),
              label: 'Orders',
              activeIcon: Icon(Icons.shopping_bag),
            ),
          ],
        ),
      );
    });
  }
}
