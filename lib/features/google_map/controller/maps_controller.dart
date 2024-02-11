import 'dart:async';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:watt_test/core/constants/colors.dart';
import 'package:watt_test/core/package/flutter_polyline/flutter_polyline_points.dart';
import 'package:watt_test/services/maps_service.dart';

class MapsController extends GetxController {
//variables to give map control and new camera
  Rx<CameraPosition>? defaultCamera =
      const CameraPosition(target: LatLng(25.20457441524572, 55.27081812621483))
          .obs;
  //
  final MapsService mapsService = MapsService();

  Rx<bool>? isLoading = false.obs;
  Rx<bool>? loadingPlace = false.obs;

  // current position variables
  Rx<LatLng>? currentlatLng = const LatLng(0, 0).obs;
  Rx<LatLng>? selectedlatLng = const LatLng(0, 0).obs;
  Rx<String>? placeName = "".obs;
  //
  GoogleMapController? homeMapController;
  //=================================================
  final Completer<GoogleMapController> completer = Completer();
  //
  final CameraPosition initialCameraPosition = const CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(25.20457441524572, 55.27081812621483),
      zoom: 13);
  //
  //
  Future<LatLng> moveToCurrentPosition() async {
    final currentLocation = await getCurrentLocation();
    final latLng = LatLng(currentLocation.latitude, currentLocation.longitude);
    currentlatLng?.value = latLng;
    homeMapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: latLng, zoom: 18, tilt: 30.440717697143555),
      ),
    );
    update();
    return latLng;
  }

  Future<Position> getCurrentLocation() async {
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  //
  //
  //
  void selectPositionWhileDrag(CameraPosition position) {
    loadingPlace?.value = true;
    selectedlatLng?.value = position.target;
  }

  Future<Map<String, dynamic>> saveLocation(LatLng? latLng) async {
    return {"latlng": latLng, "place": placeName?.value};
  }

  Future<String?> getPlaceName(LatLng? latLng) async {
    final name = await mapsService.getPlaceName(latLng);
    placeName?.value = name ?? "";
    loadingPlace?.value = false;
    return placeName?.value;
  }

// ==========================Direction=====================================
  Set<Polyline> setPolylines = <Polyline>{};
  Set<Marker> setMarkers = <Marker>{};
  //!! GET DIRECTION USING PACKAGE

  LatLngBounds? latLngBounds;
  List<LatLng>? polylineCoordinates = [];
  PolylinePoints? polylinePoints;
  //
  Future setPolylinesDirection(LatLng? originlatLng, LatLng? destlatlng) async {
    polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints!.getRouteBetweenCoordinates(
      dotenv.env['MAP_ACCESS_KEY']!,
      PointLatLng(originlatLng!.latitude, originlatLng.longitude),
      PointLatLng(destlatlng!.latitude, destlatlng.longitude),
      travelMode: TravelMode.driving,
    );

    polylineCoordinates!.clear();
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates?.add(LatLng(point.latitude, point.longitude));
      }
    }

    setPolylines.clear();
    Polyline polyline = Polyline(
        polylineId: const PolylineId('polylineid'),
        color: AppColors.primaryBlue,
        jointType: JointType.round,
        points: polylineCoordinates!,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        geodesic: true,
        width: 2);

    setPolylines.add(polyline);
    latLngBounds = null;
    if (originlatLng.latitude > destlatlng.latitude &&
        originlatLng.longitude > destlatlng.longitude) {
      latLngBounds =
          LatLngBounds(southwest: destlatlng, northeast: originlatLng);
    } else if (originlatLng.longitude > destlatlng.longitude) {
      latLngBounds = LatLngBounds(
          southwest: LatLng(originlatLng.latitude, destlatlng.longitude),
          northeast: LatLng(destlatlng.latitude, originlatLng.longitude));
    } else if (originlatLng.latitude > destlatlng.latitude) {
      latLngBounds = LatLngBounds(
          southwest: LatLng(destlatlng.latitude, originlatLng.longitude),
          northeast: LatLng(originlatLng.latitude, destlatlng.longitude));
    } else {
      latLngBounds =
          LatLngBounds(southwest: originlatLng, northeast: destlatlng);
    }

    homeMapController
        ?.animateCamera(CameraUpdate.newLatLngBounds(latLngBounds!, 75));

    update();
  }
  //

  getDirectionPoints(LatLng? originlatLng, LatLng? destlatlng) {
    //call  setPolylinesDirection function
    setPolylinesDirection(originlatLng, destlatlng);
//
//?? GET MARKERS AND SET ON MAP
    setMarkers.clear();
    Marker picUpLocalMarker = Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        infoWindow: const InfoWindow(title: 'Start Point'),
        position: originlatLng!,
        markerId: const MarkerId('pickUpId'));
    Marker dropOffLocalMarker = Marker(
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
      infoWindow: const InfoWindow(title: 'Destination'),
      position: destlatlng!,
      markerId: const MarkerId('dropoffId'),
    );

    setMarkers.add(picUpLocalMarker);
    setMarkers.add(dropOffLocalMarker);

    update();
  }
}
