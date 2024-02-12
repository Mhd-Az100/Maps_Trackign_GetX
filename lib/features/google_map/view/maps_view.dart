import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:watt_test/features/google_map/controller/maps_controller.dart';
import 'package:watt_test/features/google_map/widget/buttons_widget.dart';

class GoogleMapView extends GetView<MapsController> {
  const GoogleMapView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MapsController>(
      builder: (controller) {
        return Stack(
          children: [
            GoogleMap(
              initialCameraPosition: controller.initialCameraPosition,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              onMapCreated: (GoogleMapController ctrl) {
                controller.homeMapController = ctrl;
                controller.moveToCurrentPosition();
              },
              polylines: controller.setPolylines,
              markers: controller.setMarkers,
            ),
            const Positioned(
              top: 20,
              right: 12,
              child: CurrentLocationButton(),
            ),
          ],
        );
      },
    );
  }
}
