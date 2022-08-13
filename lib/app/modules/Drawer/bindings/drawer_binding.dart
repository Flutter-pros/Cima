import 'package:get/get.dart';
import '../controllers/drawer_controller.dart';

class CounterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => DrawerController(),
    );
  }
}
