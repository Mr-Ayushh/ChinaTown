import 'package:dummy_1/controller/cart_controller.dart';
import 'package:dummy_1/controller/navigation_controller.dart';
import 'package:dummy_1/controller/product_details_controller.dart';
import 'package:dummy_1/controller/splash_controller.dart';
import 'package:dummy_1/screens/admin/admin_dashboard.dart';
import 'package:dummy_1/screens/admin/beverages_list_page.dart';
import 'package:dummy_1/screens/admin/completed_orders.dart';
import 'package:dummy_1/screens/admin/featured_list_page.dart';
import 'package:dummy_1/screens/admin/non_veg_item_page.dart';
import 'package:dummy_1/screens/admin/pending_orders.dart';
import 'package:dummy_1/screens/admin/veg_item_page.dart';
import 'package:dummy_1/screens/confirm_order_view.dart';
import 'package:dummy_1/screens/navigation_view.dart';
import 'package:dummy_1/screens/product_detail.dart';
import 'package:dummy_1/screens/splash_screen/splash_view.dart';

import '../utils/exports.dart';

class Routes {
  static const String splashScreen = '/splashScreen';
  static const String homePage = '/homePage';
  static const String navigation = '/navigation';
  static const String adminDashboard = '/adminDashboard';
  static const String beveragesAdmin = '/beveragesAdmin';
  static const String featuredAdmin = '/featuredAdmin';
  static const String vegAdmin = '/vegAdmin';
  static const String nonvegAdmin = '/nonvegAdmin';
  static const String completedOrderPage = '/completedOrderPage';
  static const String pendingOrderPage = '/pendingOrderPage';
  static const String loginPage = '/loginPage';
  static const String signUpPage = '/signUpPage';
  static const String userDetailsPage = '/userDetailsPage';
  static const String productDetailView = '/productDetailView';
  static const String cartPage = '/cartPage';

  static List<GetPage<dynamic>> get routes {
    return [
      GetPage(
        name: Routes.splashScreen,
        page: () => const SplashView(),
        binding: BindingsBuilder.put(() => SplashController()),
      ),
      GetPage(
        name: Routes.navigation,
        page: () => const NavigationView(),
        binding: BindingsBuilder.put(() => NavigationController()),
      ),
      GetPage(
        name: Routes.beveragesAdmin,
        page: () => const BeveragesListPage(),
        // binding: BindingsBuilder.put(() => HomeController()),
      ),
      GetPage(
        name: Routes.adminDashboard,
        page: () => const AdminDashboard(),
        // binding: BindingsBuilder.put(() => HomeController()),
      ),
      GetPage(
        name: Routes.featuredAdmin,
        page: () => const FeaturedProductListPage(),
        // binding: BindingsBuilder.put(() => HomeController()),
      ),
      GetPage(
        name: Routes.vegAdmin,
        page: () => const VegListPage(),
        // binding: BindingsBuilder.put(() => HomeController()),
      ),
      GetPage(
        name: Routes.nonvegAdmin,
        page: () => const NonVegItemListPage(),
        // binding: BindingsBuilder.put(() => HomeController()),
      ),
      GetPage(
        name: Routes.completedOrderPage,
        page: () => const CompleteOrderListPage(),
        // binding: BindingsBuilder.put(() => HomeController()),
      ),
      GetPage(
        name: Routes.pendingOrderPage,
        page: () => const PendingOrderListPage(),
        // binding: BindingsBuilder.put(() => HomeController()),
      ),
      GetPage(
        name: Routes.loginPage,
        page: () => const LoginPage(),
        binding: BindingsBuilder.put(() => LoginController()),
      ),
      // GetPage(
      //   name: Routes.signUpPage,
      //   page: () => const SignUpScreen(),
      //   binding: BindingsBuilder.put(() => SignUpcontroller()),
      // ),
      GetPage(
        name: Routes.userDetailsPage,
        page: () => const UserDetailsScreen(),
        binding: BindingsBuilder.put(() => UserDetailsController()),
      ),
      GetPage(
        name: Routes.productDetailView,
        page: () => const ProductDetailView(),
        binding: BindingsBuilder.put(() => ProductDetailsController()),
      ),
      GetPage(
        name: Routes.cartPage,
        page: () => const ConfirmOrderView(),
        binding: BindingsBuilder.put(() => CartController()),
      ),
    ];
  }
}
