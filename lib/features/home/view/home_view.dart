import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:watt_test/core/constants/colors.dart';
import 'package:watt_test/core/constants/styles.dart';
import 'package:watt_test/core/widgets/button_widget.dart';
import 'package:watt_test/features/google_map/view/maps_view.dart';
import 'package:watt_test/features/home/controller/home_controller.dart';
import 'package:watt_test/features/home/widgets/resized_card_widget.dart';
import 'package:watt_test/features/home/widgets/search_points_widget.dart';
import 'package:watt_test/features/home/widgets/trip_card_widget.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // centerTitle: true,
        backgroundColor: AppColors.primaryBlue,
        title: Obx(() {
          return Row(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                width: 45.w,
                height: 45.w,
                decoration: BoxDecoration(
                  color: AppColors.white2,
                  border: Border.all(color: AppColors.primaryGreen),
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage(controller.user?.value.image ?? ""),
                      fit: BoxFit.contain),
                ),
              ),
              Text(
                controller.user?.value.firstName ?? "",
                style: AppTextStyles.bold20.copyWith(color: Colors.white),
              ),
            ],
          );
        }),
        actions: [
          //logout button
          IconButton(
            onPressed: () {
              controller.logout();
            },
            icon: const Icon(Icons.logout, color: Colors.white),
          )
        ],
      ),
      body: Stack(
        children: [
          const GoogleMapView(),
          Obx(
            () => Visibility(
              visible: controller.showTripCard.value,
              child: Positioned(
                bottom: 100.h,
                left: 20,
                right: 20,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  reverseDuration: const Duration(milliseconds: 400),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return ScaleTransition(scale: animation, child: child);
                  },
                  child: controller.isCardTripExpanded.value
                      ? FloatingTripCard(
                          pointA: controller.startPointName?.value ?? '',
                          pointB: controller.destinationtName?.value ?? '',
                          distanceKm: controller.distance?.value ?? "0.0",
                          cost: controller.costTrip?.value ?? 0.0,
                          duration: controller.duration?.value ?? "0.0",
                          endDate: controller.endDate?.value,
                          startDate: controller.startDate?.value,
                        )
                      : const ResizeCardTrip(),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: Obx(
              () => ButtonWidget(
                width: 150,
                onPressed: () {
                  if (controller.showTripCard.value) {
                    controller.endTrip();
                    return;
                  }
                  showModalBottomSheet(
                      enableDrag: true,
                      isScrollControlled: true,
                      showDragHandle: true,
                      context: context,
                      builder: (context) {
                        return SearchPointsDirection();
                      });
                },
                child: Row(
                  children: [
                    Text(
                      controller.showTripCard.value ? "End Trip" : "Direction",
                      style: AppTextStyles.bold16.copyWith(color: Colors.white),
                    ),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.directions,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
