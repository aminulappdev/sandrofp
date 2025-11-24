// lib/app/services/helpers/address_helper.dart

import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';

// ==================== Address Helper ====================

/* 
var lat = controller.product?.location?.coordinates[0];
var lng = controller.product?.location?.coordinates[1];
final address$ = AddressHelper.getAddress(lat, lng).obs;

 */

class AddressHelper {
  // এখন প্রতিটি লোকেশনের জন্য একটা RxString থাকবে
  static final Map<String, RxString> _cache = {};

  static String getAddress(double? lat, double? lng) {
    if (lat == null || lng == null) return 'Unknown Location';

    final key = '${lat.toStringAsFixed(6)},${lng.toStringAsFixed(6)}';

    // যদি আগে থেকে থাকে, রিটার্ন করো
    if (_cache.containsKey(key)) {
      return _cache[key]!.value;
    }

    // নতুন RxString বানাও
    final rxAddress = 'Loading location...'.obs;
    _cache[key] = rxAddress;

    // ব্যাকগ্রাউন্ডে লোড করো
    _loadAddress(lat, lng, rxAddress);

    return rxAddress.value;
  }

  static Future<void> _loadAddress(
    double lat,
    double lng,
    RxString rxAddress,
  ) async {
    try {
      final placemarks = await placemarkFromCoordinates(lat, lng);
      final place = placemarks.first;

      final parts = <String>[
        if (place.street?.isNotEmpty == true) place.street!,
        if (place.subLocality?.isNotEmpty == true) place.subLocality!,
        if (place.locality?.isNotEmpty == true) place.locality!,
        if (place.administrativeArea?.isNotEmpty == true)
          place.administrativeArea!,
        if (place.country?.isNotEmpty == true) place.country!,
      ];

      final address = parts.isNotEmpty ? parts.join(', ') : 'Near this area';
      rxAddress.value = address; // এখানে UI আপডেট হবে!
    } catch (e) {
      rxAddress.value = 'Location found';
    }
  }

  static void clearCache() {
    _cache.clear();
  }
}
