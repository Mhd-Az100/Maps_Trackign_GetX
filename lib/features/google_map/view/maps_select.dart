import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:watt_test/core/constants/colors.dart';
import 'package:watt_test/core/constants/styles.dart';
import 'package:watt_test/core/widgets/button_widget.dart';
import 'package:watt_test/features/google_map/controller/maps_controller.dart';

class GoogleMapSelect extends GetView<MapsController> {
  GoogleMapSelect({super.key});
  GoogleMapController? googleMapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetX<MapsController>(
          builder: (controller) => Stack(
                alignment: Alignment.center,
                children: [
                  GoogleMap(
                    initialCameraPosition: controller.initialCameraPosition,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: false,
                    onMapCreated: (GoogleMapController ctrl) {
                      googleMapController = ctrl;
                      controller
                          .moveToCurrentPosition()
                          .then((value) => googleMapController?.animateCamera(
                                CameraUpdate.newCameraPosition(
                                  CameraPosition(
                                      target: value,
                                      zoom: 18,
                                      tilt: 30.440717697143555),
                                ),
                              ));
                    },
                    onCameraMove: (CameraPosition position) async {
                      controller.selectPositionWhileDrag(position);
                    },
                    onCameraIdle: () async {
                      controller.getPlaceName(controller.selectedlatLng?.value);
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 70),
                    child: Icon(
                      Icons.location_on,
                      color: AppColors.secondary,
                      size: 50,
                    ),
                  )
                      .animate(
                          target:
                              (controller.loadingPlace?.value ?? false) ? 1 : 0)
                      .scale(
                          begin: const Offset(1, 1),
                          end: const Offset(0.8, 0.8)),
                  Positioned(
                    top: 60,
                    right: 12,
                    child: InkWell(
                      onTap: () {
                        controller
                            .moveToCurrentPosition()
                            .then((value) => googleMapController?.animateCamera(
                                  CameraUpdate.newCameraPosition(
                                    CameraPosition(
                                        target: value,
                                        zoom: 18,
                                        tilt: 30.440717697143555),
                                  ),
                                ));
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
                  Positioned(
                    top: 60,
                    left: 12,
                    child: InkWell(
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
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 50,
                    right: 50,
                    child: ButtonWidget(
                      color: (controller.loadingPlace?.value ?? false)
                          ? AppColors.darkgrey
                          : AppColors.secondary,
                      onPressed: () {
                        (controller.loadingPlace?.value ?? false)
                            ? null
                            : controller
                                .saveLocation(controller.selectedlatLng?.value)
                                .then((value) => Get.back(result: value));
                      },
                      child: Center(
                        child: (controller.isLoading?.value ?? false)
                            ? SizedBox(
                                width: 22.w,
                                height: 22.w,
                                child: const CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                'Save',
                                style: AppTextStyles.bold20
                                    .copyWith(color: Colors.white),
                              ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 100,
                    right: 30,
                    left: 30,
                    child: Center(
                      child: Text(
                        (controller.loadingPlace?.value ?? false)
                            ? "loading ....."
                            : (controller.placeName?.value ?? ''),
                        style: AppTextStyles.medium24,
                      ),
                    ),
                  ),
                ],
              )),
    );
  }
}
