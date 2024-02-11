import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:watt_test/features/google_map/controller/maps_controller.dart';

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
            Positioned(
              top: 20,
              right: 12,
              child: InkWell(
                onTap: () {
                  controller.moveToCurrentPosition();
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(top: 0, left: 20),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.4),
                        blurRadius: 7,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.my_location_sharp,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
