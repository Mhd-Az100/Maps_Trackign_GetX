import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:watt_test/core/constants/colors.dart';
import 'package:watt_test/core/constants/styles.dart';

class SearchPlacesWidget extends StatefulWidget {
  const SearchPlacesWidget({
    super.key,
    required this.callBackOnSelect,
    required this.controller,
  });

  final void Function(Prediction) callBackOnSelect;
  final TextEditingController controller;
  @override
  State<SearchPlacesWidget> createState() => _SearchPlacesWidgetState();
}

class _SearchPlacesWidgetState extends State<SearchPlacesWidget> {
  @override
  Widget build(BuildContext context) {
    return GooglePlaceAutoCompleteTextField(
        textEditingController: widget.controller,
        
        boxDecoration: const BoxDecoration(),
        googleAPIKey: dotenv.env['MAP_ACCESS_KEY']!,
        
        inputDecoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: AppColors.lightgrey)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: AppColors.lightgrey)),
            suffixIcon: const Icon(Icons.search, color: AppColors.grey),
            filled: true,
            fillColor: AppColors.white2,
            hintText: "Search for Place",
            helperStyle:
                AppTextStyles.regular14.copyWith(color: AppColors.grey),
            hintStyle: AppTextStyles.regular14.copyWith(color: AppColors.grey),
            border: InputBorder.none),
        debounceTime: 800,
        countries: const ["ae"],
        isLatLngRequired: true,
        getPlaceDetailWithLatLng: (Prediction prediction) {
          widget.callBackOnSelect(prediction);
        },
        itemClick: (Prediction prediction) {
          // widget.callBackOnSelect(prediction);
        });
  }
}
