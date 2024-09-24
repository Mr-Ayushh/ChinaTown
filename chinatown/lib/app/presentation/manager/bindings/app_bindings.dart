import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

class AppBinding implements Bindings {
// default dependency
  @override
  void dependencies() {
    //Get.lazyPut(() => UserListController());
  }
}
