library flutter_polyline_points;

import 'package:watt_test/core/package/flutter_polyline/src/network_util.dart';
import 'package:watt_test/core/package/flutter_polyline/src/point_lat_lng.dart';
import 'package:watt_test/core/package/flutter_polyline/src/utils/polyline_result.dart';
import 'package:watt_test/core/package/flutter_polyline/src/utils/polyline_waypoint.dart';
import 'package:watt_test/core/package/flutter_polyline/src/utils/request_enums.dart';

export './src/network_util.dart';
export './src/utils/polyline_result.dart';
export './src/utils/polyline_waypoint.dart';
export './src/utils/request_enums.dart';
export 'src/point_lat_lng.dart';

class PolylinePoints {
  NetworkUtil util = NetworkUtil();

  /// Get the list of coordinates between two geographical positions
  /// which can be used to draw polyline between this two positions
  ///
  Future<PolylineResult> getRouteBetweenCoordinates(
      String googleApiKey, PointLatLng origin, PointLatLng destination,
      {TravelMode travelMode = TravelMode.driving,
      List<PolylineWayPoint> wayPoints = const [],
      bool avoidHighways = false,
      bool avoidTolls = false,
      bool avoidFerries = true,
      bool optimizeWaypoints = false}) async {
    return await util.getRouteBetweenCoordinates(
        googleApiKey,
        origin,
        destination,
        travelMode,
        wayPoints,
        avoidHighways,
        avoidTolls,
        avoidFerries,
        optimizeWaypoints);
  }

  /// Decode and encoded google polyline
  /// e.g "_p~iF~ps|U_ulLnnqC_mqNvxq`@"
  ///
  List<PointLatLng> decodePolyline(String encodedString) {
    return util.decodeEncodedPolyline(encodedString);
  }
}
