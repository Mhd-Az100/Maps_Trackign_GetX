import 'package:get/get.dart';
import 'package:watt_test/features/google_map/controller/maps_controller.dart';
import 'package:watt_test/features/home/controller/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
    Get.lazyPut<MapsController>(() => MapsController(), fenix: true);
  }
}
