// lib/app/services/location/address_fetcher.dart

import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';

class AddressHelper {
  static Future<String> getAddress(double? latitude, double? longitude) async {
    if (latitude == null || longitude == null) return "Unknown";

    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        return "${place.locality ?? ''}, ${place.country ?? ''}".trim();
      }
    } catch (e) {
      debugPrint("Geocoding Error: $e");
    }
    return "Unknown";
  }
}