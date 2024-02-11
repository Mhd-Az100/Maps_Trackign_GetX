import 'package:get/get.dart';
import 'package:watt_test/features/google_map/controller/maps_controller.dart';

class GoogleMapsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MapsController>(() => MapsController());
  }
}
