import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:watt_test/features/google_map/controller/maps_controller.dart';

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.back();
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(top: 0, right: 20),
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
          Icons.arrow_back_ios_outlined,
          color: Colors.grey[800],
        ),
      ),
    );
  }
}

class CurrentLocationButton extends GetWidget<MapsController> {
  const CurrentLocationButton({
    super.key,
    this.callback,
  });
  //callback function
  final void Function(LatLng)? callback;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        controller.moveToCurrentPosition().then((value) => callback);
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
    );
  }
}
