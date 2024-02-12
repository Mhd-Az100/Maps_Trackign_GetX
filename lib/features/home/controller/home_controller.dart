import 'dart:developer';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:watt_test/core/service_locator/service_locator.dart';
import 'package:watt_test/features/auth/model/user_model.dart';
import 'package:watt_test/features/google_map/controller/maps_controller.dart';
import 'package:watt_test/routes/app_pages.dart';
import 'package:watt_test/services/maps_service.dart';

class HomeController extends GetxController {
  final mapsController = Get.find<MapsController>();
  final mapsService = MapsService();

  // Start point and destination details
  Rx<LatLng>? startPointLatLng = const LatLng(0, 0).obs;
  Rx<String>? startPointName = "".obs;
  Rx<LatLng>? destinationLatLng = const LatLng(0, 0).obs;
  Rx<String>? destinationtName = "".obs;

  // Trip details
  Rx<String>? distance = "".obs;
  Rx<int>? durationValue = 0.obs;
  Rx<String>? duration = "".obs;
  Rx<DateTime>? startDate = DateTime.now().obs;
  Rx<DateTime>? endDate = DateTime.now().obs;
  RxDouble? costTrip = 0.0.obs;
  RxBool showTripCard = false.obs;
  RxBool isCardTripExpanded = false.obs;

  // User instance
  Rx<UserModel>? user = const UserModel().obs;

  // Get user information
  getUserInfo() async {
    user?.value =
        await ServiceLocator.globalSession.getUser() ?? const UserModel();
    inspect(user?.value);
  }

  // Save start point details
  saveStartPoint(String placeName, LatLng latLng) {
    startPointName?.value = placeName;
    startPointLatLng?.value = latLng;
  }

  // Save destination details
  saveDestination(String placeName, LatLng latLng) {
    destinationtName?.value = placeName;
    destinationLatLng?.value = latLng;
  }

  // Get direction and update trip card
  Future<void> getDirection() async {
    await mapsController.getDirectionPoints(
        startPointLatLng?.value, destinationLatLng?.value);
    await getDistanceDuration(
        startPointLatLng?.value, destinationLatLng?.value);
    showTripCard.value = true;
    update();
  }

  // Retrieve distance and duration using mapsService
  Future<void> getDistanceDuration(
      LatLng? originlatLng, LatLng? destlatlng) async {
    Map<String, dynamic> value = await mapsService.getDistanceMatrix(
      originLat: startPointLatLng?.value.latitude ?? 0,
      originLng: startPointLatLng?.value.longitude ?? 0,
      destinationLat: destinationLatLng?.value.latitude ?? 0,
      destinationLng: destinationLatLng?.value.longitude ?? 0,
    );

    distance?.value = value["distance"];
    duration?.value = value["duration"];
    durationValue?.value = value["durationValue"];

    calculateCost(distance?.value);
    calculateDate(durationValue?.value);
    update();
  }

  // Calculate trip cost based on distance
  calculateCost(String? distance) {
    double distanceNumber = double.parse(distance?.split(" ")[0] ?? "0");
    // Assuming a rate of 2 AED per kilometer
    const double ratePerKilometer = 2.0;
    final double distanceInKilometers = distanceNumber;
    final double cost = distanceInKilometers * ratePerKilometer;
    costTrip?.value = cost;
  }

  // Calculate trip end date based on duration
  calculateDate(int? duration) {
    final durationInMinutes = duration! / 60; // Duration in minutes
    startDate?.value = DateTime.now();
    endDate?.value =
        DateTime.now().add(Duration(minutes: durationInMinutes.toInt()));
  }

  // Toggle the trip card expansion state
  toggleCardTrip() {
    isCardTripExpanded.value = !isCardTripExpanded.value;
  }

  // End the trip and reset UI
  endTrip() {
    showTripCard.value = false;
    isCardTripExpanded.value = false;
    mapsController.stopDirection();
    update();
  }

  //logout user and navigate to login screen
  logout() {
    ServiceLocator.globalSession.clearSessions();
    Get.offAllNamed(Routes.LOGIN);
  }

  @override
  void onInit() {
    getUserInfo();
    super.onInit();
  }
}
