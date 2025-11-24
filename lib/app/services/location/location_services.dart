// lib/app/widgets/location_picker_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' hide Location;

// ==================== Package Required ====================

/*
  flutter_map: ^6.1.0
  latlong2: ^0.9.1
  location: ^5.0.0
  geocoding: ^3.0.0
*/

// ==================== Location Service ====================
class LocationService {
  final Location _location = Location();

  Future<bool> _checkAndRequestService(BuildContext context) async {
    bool serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        _showSnackBar(context, 'Location service is disabled', Colors.red);
        return false;
      }
    }
    return true;
  }

  Future<bool> _checkAndRequestPermission(BuildContext context) async {
    PermissionStatus permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != PermissionStatus.granted &&
          permissionGranted != PermissionStatus.grantedLimited) {
        _showSnackBar(context, 'Location permission denied', Colors.red);
        return false;
      }
    }
    return true;
  }

  Future<LatLng?> getCurrentLocation(BuildContext context) async {
    if (!await _checkAndRequestService(context)) return null;
    if (!await _checkAndRequestPermission(context)) return null;

    try {
      LocationData locationData = await _location.getLocation();
      return LatLng(locationData.latitude!, locationData.longitude!);
    } catch (e) {
      _showSnackBar(context, 'Error getting location: $e', Colors.red);
      return null;
    }
  }

  Future<LatLng?> searchLocation(BuildContext context, String query) async {
    if (query.isEmpty) return null;

    final String url =
        'https://nominatim.openstreetmap.org/search?q=${Uri.encodeComponent(query)}&format=json&limit=1';

    try {
      final response = await http.get(Uri.parse(url), headers: {
        'User-Agent': 'glow_street/1.0',
      });

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List<dynamic>;
        if (data.isNotEmpty) {
          final lat = double.parse(data[0]['lat'].toString());
          final lng = double.parse(data[0]['lon'].toString());
          return LatLng(lat, lng);
        }
      }
      _showSnackBar(context, 'Location not found', Colors.red);
      return null;
    } catch (e) {
      _showSnackBar(context, 'Error: $e', Colors.red);
      return null;
    }
  }

  Future<String> getPlaceName(BuildContext context, LatLng position) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks.first;
      List<String> parts = [];
      if (place.street != null && place.street!.isNotEmpty) parts.add(place.street!);
      if (place.subLocality != null && place.subLocality!.isNotEmpty) parts.add(place.subLocality!);
      if (place.locality != null && place.locality!.isNotEmpty) parts.add(place.locality!);
      if (place.country != null && place.country!.isNotEmpty) parts.add(place.country!);
      return parts.isNotEmpty ? parts.join(', ') : 'Unknown Location';
    } catch (e) {
      _showSnackBar(context, 'Failed to get address', Colors.red);
      return 'Unknown Location';
    }
  }

  void _showSnackBar(BuildContext context, String message, Color color) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: color),
      );
    }
  }
}

// ==================== Location Picker Screen ====================
class LocationPickerScreen extends StatefulWidget {
  /// শুরুর পজিশন (যদি থাকে)
  final LatLng initialPosition;

  /// Confirm বাটন দেখাবে কি না (কিছু ক্ষেত্রে শুধু map দেখাতে চাইলে false)
  final bool showConfirmButton;

  const LocationPickerScreen({
    super.key,
    required this.initialPosition,
    this.showConfirmButton = true,
  });

  @override
  State<LocationPickerScreen> createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  late LatLng selectedPosition;
  final MapController _mapController = MapController();
  final TextEditingController _searchController = TextEditingController();
  final LocationService _locationService = LocationService();

  @override
  void initState() {
    super.initState();
    selectedPosition = widget.initialPosition;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Location',
            style: TextStyle(fontSize: 18.sp, color: Colors.white)),
        backgroundColor: const Color(0xff1D4ED8),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: widget.initialPosition,
              initialZoom: 16.0,
              onTap: (_, point) => setState(() => selectedPosition = point),
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: const ['a', 'b', 'c'],
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: selectedPosition,
                    width: 60,
                    height: 60,
                    child: const Icon(Icons.location_pin, color: Colors.red, size: 45),
                  ),
                ],
              ),
            ],
          ),

          // Search Box
          Positioned(
            top: 10.h,
            left: 16.w,
            right: 16.w,
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search location',
                  hintStyle: TextStyle(fontSize: 16.sp),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search, color: Color(0xff1D4ED8)),
                    onPressed: () async {
                      final pos = await _locationService.searchLocation(
                          context, _searchController.text);
                      if (pos != null) {
                        setState(() => selectedPosition = pos);
                        _mapController.move(pos, 16.0);
                      }
                    },
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                ),
                onSubmitted: (q) async {
                  final pos = await _locationService.searchLocation(context, q);
                  if (pos != null) {
                    setState(() => selectedPosition = pos);
                    _mapController.move(pos, 16.0);
                  }
                },
              ),
            ),
          ),
        ],
      ),
      bottomSheet: widget.showConfirmButton
          ? Container(
              color: Colors.white,
              padding: EdgeInsets.all(20.h),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff1D4ED8),
                  minimumSize: const Size(double.infinity, 56),
                ),
                onPressed: () async {
                  // Reverse geocoding → address string
                  final address = await _locationService.getPlaceName(context, selectedPosition);
                  Navigator.pop(context, {
                    'latLng': selectedPosition,
                    'address': address,
                  });
                },
                child: Text('Confirm Location',
                    style: TextStyle(fontSize: 16.sp, color: Colors.white)),
              ),
            )
          : null,
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}