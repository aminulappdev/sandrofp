// app/modules/product/views/upload_product_info_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:sandrofp/app/modules/product/controller/add_product_controller.dart';
import 'package:sandrofp/app/modules/product/widgets/label.dart';
import 'package:sandrofp/app/modules/product/widgets/status_bar.dart';
import 'package:sandrofp/app/res/common_widgets/custom_app_bar.dart';
import 'package:sandrofp/app/res/common_widgets/custom_circle.dart';
import 'package:sandrofp/app/res/common_widgets/custom_elevated_button.dart';
import 'package:sandrofp/app/res/custom_style/custom_size.dart';
import 'package:sandrofp/app/services/location/location_services.dart';
import 'package:sandrofp/app/services/location/location_picker_field.dart';
import 'package:sandrofp/app/services/network_caller/validator_service.dart';
import 'package:sandrofp/gen/assets.gen.dart';

class UploadProductInfoScreen extends GetView<AddProductController> {
  const UploadProductInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddProductController());
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Product information',
        leading: Row(
          children: [
            CircleIconWidget(
              radius: 20,
              iconRadius: 20,
              color: const Color(0xffFFFFFF).withValues(alpha: 0.05),
              imagePath: Assets.images.notification.keyName,
              onTap: () {},
            ),
            widthBox10,
            CircleAvatar(
              backgroundImage: AssetImage(Assets.images.onboarding01.keyName),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                heightBox20,
                StatusBar(
                  firstName: 'Information',
                  firstBgColor: Color(0xffEBF2EE),
                  firtsIconColor: null,
                  firstIconPath: Assets.images.group02.keyName,
                  secondName: 'Description',
                  secondBgColor: Color(0xffEBF2EE),
                  secondIconColor: Colors.grey,
                  secondIconPath: Assets.images.group02.keyName,
                  thirdName: 'Upload',
                  thirdBgColor: Color(0xffEBF2EE),
                  thirdIconColor: Colors.grey,
                  thirdIconPath: Assets.images.group02.keyName,
                ),
                heightBox14,
                Text(
                  'Product Information',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                heightBox20,

                // Name
                const Label(label: 'Name'),
                heightBox8,
                TextFormField(
                  controller: controller.nameController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) =>
                      ValidatorService.validateSimpleField(value),
                  decoration: const InputDecoration(
                    hintText: 'Enter product name',
                  ),
                ),
                heightBox20,

                // Description
                const Label(label: 'Description'),
                heightBox8,
                TextFormField(
                  controller: controller.descriptionController,
                  maxLines: 5,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) =>
                      ValidatorService.validateSimpleField(value),
                  decoration: const InputDecoration(
                    hintText: 'Enter product description',
                  ),
                ),
                heightBox20,

                // Location → Map Picker
                const Label(label: 'Location'),
                heightBox8,
                Obx(
                  () => LocationField(
                    address: controller.selectedAddress.value,
                    onPick: () async {
                      final pos =
                          controller.selectedLatLng.value ??
                          LatLng(23.8103, 90.4125);
                      final res = await Get.to(
                        () => LocationPickerScreen(initialPosition: pos),
                      );
                      if (res is Map) {
                        controller.setLocation(res['latLng'], res['address']);
                      }
                    },
                    onClear: controller.clearLocation,
                  ),
                ),
                heightBox20,

                // Price
                const Label(label: 'Price'),
                heightBox8,
                TextFormField(
                  controller: controller.priceController,
                  keyboardType: TextInputType.number,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) =>
                      ValidatorService.validateSimpleField(value),
                  decoration: const InputDecoration(
                    hintText: 'Enter product price',
                  ),
                ),
                heightBox20,

                // Discount
                const Label(label: 'Discount (Optional)'),
                heightBox8,
                TextFormField(
                  controller: controller.discountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Enter discount percentage',
                  ),
                ),
                heightBox30,

                // Next Button
                CustomElevatedButton(
                  title: 'Next',
                  onPress: () {
                    if (_formKey.currentState!.validate()) {
                      if (controller.selectedLatLng.value == null) {
                        Get.snackbar(
                          'Location Required',
                          'Please select a location on map',
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                        );
                        return;
                      }
                      controller.goToDescriptionScreen();
                    }
                  },
                ),
                heightBox30,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
