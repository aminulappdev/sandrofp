// lib/app/widgets/location_field.dart   (নাম ছোট করলাম)

import 'package:flutter/material.dart';

// ==================== How to use  ====================

/*

For Controller :

final Rx<LatLng?> selectedLatLng = Rx<LatLng?>(null);
final RxString selectedAddress = ''.obs;

  void setLocation(LatLng latLng, String address) {
    selectedLatLng.value = latLng;
    selectedAddress.value = address;
    locationController.text = address;
  }


For View :

Obx(
   () => LocationField(
      address: controller.selectedAddress.value,
      onPick: () async {
      final pos = controller.selectedLatLng.value ?? LatLng(23.8103, 90.4125);
      final res = await Get.to(() => LocationPickerScreen(initialPosition: pos),);
        if (res is Map) {
            controller.setLocation(res['latLng'], res['address']);
          }
        },
        onClear: controller.clearLocation,
    ),
  ),

*/

class LocationField extends StatelessWidget {
  final String? address;
  final VoidCallback onPick;
  final VoidCallback? onClear;

  const LocationField({
    super.key,
    this.address,
    required this.onPick,
    this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    final picked = address?.isNotEmpty == true;

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onPick,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(
            color: picked ? Colors.green : Colors.grey.shade300,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(Icons.location_on, color: picked ? Colors.green : Colors.grey),
            SizedBox(width: 10),
            Expanded(child: Text(picked ? address! : "Select location")),
            if (picked) ...[
              if (onClear != null)
                GestureDetector(
                  onTap: onClear,
                  child: Icon(Icons.clear, size: 20),
                ),
              SizedBox(width: 8),
            ],
            Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
