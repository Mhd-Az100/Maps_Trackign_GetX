import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:watt_test/features/google_map/controller/maps_controller.dart';
import 'package:watt_test/services/maps_service.dart';

class HomeController extends GetxController {
  final mapsController = Get.find<MapsController>();
  final mapsService = MapsService();
  //
  Rx<LatLng>? startPointLatLng = const LatLng(0, 0).obs;
  Rx<String>? startPointName = "".obs;
  Rx<LatLng>? destinationLatLng = const LatLng(0, 0).obs;
  Rx<String>? destinationtName = "".obs;
  Rx<String>? distance = "".obs;
  Rx<int>? durationValue = 0.obs;
  Rx<String>? duration = "".obs;
  Rx<DateTime>? startDate = DateTime.now().obs;
  Rx<DateTime>? endDate = DateTime.now().obs;
  RxDouble? costTrip = 0.0.obs;
  RxBool showTripCard = false.obs;
  RxBool isCardTripExpanded = false.obs;
  //
  saveStartPoint(String placeName, LatLng latLng) {
    startPointName?.value = placeName;
    startPointLatLng?.value = latLng;
  }

  savehDestination(String placeName, LatLng latLng) {
    destinationtName?.value = placeName;
    destinationLatLng?.value = latLng;
  }

  Future<void> getDirection() async {
    await mapsController.getDirectionPoints(
        startPointLatLng?.value, destinationLatLng?.value);
    await getDistanceDuration(
        startPointLatLng?.value, destinationLatLng?.value);
    showTripCard.value = true;
    update();
  }

  /// Retrieves the distance and duration between the specified origin and destination coordinates using the mapsService.
  ///
  /// The distance and duration values are then assigned to the distance and duration variables, respectively.
  Future<void> getDistanceDuration(
      LatLng? originlatLng, LatLng? destlatlng) async {
    Map<String, dynamic> value = await mapsService.getDistanceMatrix(
        originLat: startPointLatLng?.value.latitude ?? 0,
        originLng: startPointLatLng?.value.longitude ?? 0,
        destinationLat: destinationLatLng?.value.latitude ?? 0,
        destinationLng: destinationLatLng?.value.longitude ?? 0);
    distance?.value = value["distance"];
    duration?.value = value["duration"];
    durationValue?.value = value["durationValue"];

    calculateCost(distance?.value);
    calculateDate(durationValue?.value);
    update();
  }

  calculateCost(String? distace) {
    double distanceNumber = double.parse(distance?.split(" ")[0] ?? "0");
    // Assuming a rate of 2 AED per kilometer
    const double ratePerKilometer = 2.0;
    final double distanceInKilometers = distanceNumber;
    final double cost = distanceInKilometers * ratePerKilometer;
    costTrip?.value = cost;
  }

  calculateDate(int? duration) {
    final durationInMinutes = duration! / 60; // Duration in minutes
    startDate?.value = DateTime.now();
    endDate?.value =
        DateTime.now().add(Duration(minutes: durationInMinutes.toInt()));
  }

  toggleCardTrip() {
    isCardTripExpanded.value = !isCardTripExpanded.value;
  }
}
