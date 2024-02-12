import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:watt_test/core/api/handle_exception.dart';
import 'package:watt_test/core/service_locator/service_locator.dart';

class MapsService with BaseHandleApi {
  final httpProvider = ServiceLocator.httpProvider;

  // Google Maps Geocoding API base URL and API key
  final String baseUrl =
      'https://maps.googleapis.com/maps/api/geocode/json?latlng=';
  final String mapApiKey = dotenv.env['MAP_ACCESS_KEY']!;

  // Get the place name based on the provided latitude and longitude
  Future<String?> getPlaceName(LatLng? latLng) async {
    final query = '${latLng?.latitude},${latLng?.longitude}';
    final url = Uri.parse("$baseUrl$query&key=$mapApiKey");
    final Response res = await httpProvider.get(url,
        headers: {"Accept": "application/json"}).catchError(handleError);

    if (res.statusCode == 200) {
      // Parse the response data to extract the place name
      final data = jsonDecode(res.body);
      final placeName =
          "${data["results"][0]["address_components"][1]['long_name']} , ${data["results"][1]["address_components"][2]["long_name"]}";

      return placeName;
    } else {
      return null;
    }
  }

  // Get distance and duration information using the Google Distance Matrix API
  Future<Map<String, dynamic>> getDistanceMatrix({
    required double originLat,
    required double originLng,
    required double destinationLat,
    required double destinationLng,
  }) async {
    // Google Maps Distance Matrix API URL
    const String apiUrl =
        'https://maps.googleapis.com/maps/api/distancematrix/json';

    // Make a request to the API
    final response = await httpProvider.get(
      Uri.parse(
        '$apiUrl?origins=$originLat,$originLng&destinations=$destinationLat,$destinationLng&key=$mapApiKey',
      ),
    );

    if (response.statusCode == 200) {
      // Parse the response data and extract distance and duration information
      final Map<String, dynamic> data = json.decode(response.body);

      if (data['status'] == 'OK') {
        final row = data['rows'][0];
        final element = row['elements'][0];
        final distance = element['distance']['text'];
        final duration = element['duration']['text'];
        final durationValue = element['duration']['value'];

        return {
          'distance': distance,
          'duration': duration,
          'durationValue': durationValue,
        };
      } else {
        // Handle API error status
        throw Exception('Error: ${data['status']}');
      }
    } else {
      // Handle HTTP error
      throw Exception(
          'Failed to load data from the Google Distance Matrix API');
    }
  }
}
