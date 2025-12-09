// lib/app/services/location/location_service.dart

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart';

// lib/app/services/location/location_service.dart

import 'package:get/get.dart';
import 'package:location/location.dart';

class LocationService extends GetxService {
  static LocationService get to => Get.find(); // এটাই ছিল মিসিং

  final Location _location = Location();
  final Rx<LocationData?> currentLocation = Rx<LocationData?>(null);
  final RxBool isReady = false.obs;

  Future<LocationService> init() async {
    await getLocation();
    return this;
  }

  Future<void> getLocation() async {
    try {
      bool serviceEnabled = await _location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await _location.requestService();
        if (!serviceEnabled) return _setFallback();
      }

      PermissionStatus permission = await _location.hasPermission();
      if (permission == PermissionStatus.denied) {
        permission = await _location.requestPermission();
        if (permission != PermissionStatus.granted &&
            permission != PermissionStatus.grantedLimited) {
          return _setFallback();
        }
      }

      final loc = await _location.getLocation().timeout(
        const Duration(seconds: 15),
      );
      currentLocation.value = loc;
      isReady.value = true;
      debugPrint("Location Success: ${loc.latitude}, ${loc.longitude}");
    } catch (e) {
      debugPrint("Location failed: $e → using fallback");
      _setFallback();
    }
  }

  void _setFallback() {
    currentLocation.value = LocationData.fromMap({
      "latitude": 23.8103,
      "longitude": 90.4125,
    });
    isReady.value = true;
    debugPrint("Fallback location: Dhaka");
  }
}

class DistanceService {
  static const String apiKey = "AIzaSyB_3nOokGz9jksH5jN_f05YNEJeZqWizYM";

  static Future<String> getDistanceInKm({
    required double userLat,
    required double userLng,
    required double productLat,
    required double productLng,
  }) async {
    debugPrint(
      "Fetching distance from ($userLat, $userLng) to ($productLat, $productLng)",
    );

    final url =
        Uri.https('maps.googleapis.com', '/maps/api/distancematrix/json', {
          'origins': '$userLat,$userLng',
          'destinations': '$productLat,$productLng',
          'mode': 'driving',
          'language': 'en',
          'key': apiKey,
        });

    try {
      final response = await http.get(url).timeout(const Duration(seconds: 12));

      if (response.statusCode != 200) {
        debugPrint("HTTP Error: ${response.statusCode}");
        return "Far";
      }

      final data = json.decode(response.body);

      if (data['status'] != 'OK') {
        debugPrint(
          "API Error: ${data['status']} - ${data['error_message'] ?? ''}",
        );
        return "Far";
      }

      final element = data['rows'][0]['elements'][0];
      if (element['status'] != 'OK') {
        debugPrint("No route: ${element['status']}");
        return "Far";
      }

      final int meters = element['distance']['value'];
      final double km = meters / 1000.0;

      String distanceText;

      if (km < 1) {
        final int m = meters.round();
        distanceText = "$m m";
      } else if (km < 10) {
        distanceText = "${km.toStringAsFixed(1)} km";
      } else {
        distanceText = "${km.round()} km";
      }

      debugPrint("Distance Success: $distanceText");
      return distanceText;
    } catch (e) {
      debugPrint("Distance Exception: $e");
      return "Far";
    }
  }
}
