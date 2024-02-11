import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:watt_test/core/constants/colors.dart';
import 'package:watt_test/core/constants/styles.dart';
import 'package:watt_test/core/constants/toast.dart';
import 'package:watt_test/core/widgets/button_widget.dart';
import 'package:watt_test/core/widgets/search_places_widget.dart';
import 'package:watt_test/features/home/controller/home_controller.dart';
import 'package:watt_test/features/home/widgets/open_map_button.dart';
import 'package:watt_test/routes/app_pages.dart';

class SearchPointsDirection extends GetWidget<HomeController> {
  final startPointController = TextEditingController();
  final destinationController = TextEditingController();

  SearchPointsDirection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return Container(
        height: context.height * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30.h),
            Text("Start Point", style: AppTextStyles.medium24)
                .paddingSymmetric(vertical: 3.h),
            SearchPlacesWidget(
              controller: startPointController,
              callBackOnSelect: (v) {
                controller.saveStartPoint(
                    v.description ?? "",
                    LatLng(
                      double.parse(v.lat ?? "0"),
                      double.parse(v.lng ?? "0"),
                    ));

                startPointController.text = v.description!;
                startPointController.selection = TextSelection.fromPosition(
                    TextPosition(offset: v.description!.length));
              },
            ).paddingSymmetric(vertical: 10.h),
            OpenMapButton(
              onPressed: () {
                Get.toNamed(Routes.MAPS)?.then((value) {
                  controller.saveStartPoint(value["place"], value["latlng"]);
                  startPointController.text = value["place"];
                });
              },
            ),
            const Divider(
              color: AppColors.lightgrey,
              indent: 20,
              endIndent: 20,
            ),
            Text("Destination", style: AppTextStyles.medium24)
                .paddingSymmetric(vertical: 3.h),
            SearchPlacesWidget(
              controller: destinationController,
              callBackOnSelect: (v) {
                controller.savehDestination(
                    v.description ?? "",
                    LatLng(
                      double.parse(v.lat ?? "0"),
                      double.parse(v.lng ?? "0"),
                    ));
                destinationController.text = v.description!;
                destinationController.selection = TextSelection.fromPosition(
                    TextPosition(offset: v.description!.length));
              },
            ).paddingSymmetric(vertical: 10.h),
            OpenMapButton(
              onPressed: () {
                Get.toNamed(Routes.MAPS)?.then((value) {
                  controller.savehDestination(value["place"], value["latlng"]);
                  destinationController.text = value["place"];
                });
              },
            ),
            SizedBox(height: 30.h),
            ButtonWidget(
              onPressed: () {
                if (controller.startPointLatLng?.value == const LatLng(0, 0) ||
                    controller.destinationLatLng?.value == const LatLng(0, 0)) {
                  myToast("Please Check Start Point and Destination");
                  return;
                }
                controller.getDirection().then((value) => Get.back());
              },
              title: "Get Direction",
            ).paddingSymmetric(vertical: 10.h),
          ],
        ).paddingSymmetric(horizontal: 20.w, vertical: 10.h),
      );
    });
  }
}
