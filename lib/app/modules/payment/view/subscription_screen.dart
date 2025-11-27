// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';

// class SubscriptionScreen extends StatefulWidget {
//   const SubscriptionScreen({super.key});

//   @override
//   State<SubscriptionScreen> createState() => _SubscriptionScreenState();
// }
 
// class _SubscriptionScreenState extends State<SubscriptionScreen> {
//   final AllPackageController allPackageController =
//       Get.put(AllPackageController());

//   final SubscriptionController subscriptionController =
//       Get.put(SubscriptionController());
//   final PaymentService paymentService = PaymentService();
//   final PaymentController paymentController = Get.put(PaymentController());

//   // Variable to store the selected package ID
//   String? selectedPackageId;
//   bool isLoading = false;

//   @override
//   void initState() {
//     allPackageController.getAllPackage();
//     super.initState();
//   }

//   // Centralized method to handle package selection
//   void selectPackage(String packageId) {
//     setState(() {
//       selectedPackageId = packageId;
//       print("Selected Package ID: $selectedPackageId"); // Print the selected ID
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             heightBox30,
//             CustomAppBar(name: 'Subscription'),
//             heightBox30,
//             Card(
//               elevation: 1,
//               color: Color(0xffE6E6E6),
//               child: Container(
//                 height: 65,
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                     color: Color(0xffE6E6E6),
//                     borderRadius: BorderRadius.circular(12)),
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Text(
//                         'Current Plan',
//                         style: TextStyle(
//                             fontSize: 16, fontWeight: FontWeight.w700),
//                       ),
//                       heightBox4,
//                       Text(
//                         'Monthly - 12 Day remaining',
//                         style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w400,
//                           color: const Color.fromARGB(255, 87, 87, 87),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             heightBox12,
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(
//                   'Choose a plan',
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
//                 ),
//                 heightBox4,
//                 Text(
//                   'Monthly or yearly? It’s your call',
//                   style: TextStyle(
//                     fontSize: 14,
//                     fontWeight: FontWeight.w400,
//                     color: const Color.fromARGB(255, 87, 87, 87),
//                   ),
//                 )
//               ],
//             ),
//             heightBox12,
//             Obx(
//               () {
//                 if (allPackageController.inProgress) {
//                   return Center(
//                       child: SizedBox(
//                     height: 100.h,
//                     child: Center(
//                       child: LoadingAnimationWidget.horizontalRotatingDots(
//                         color: Colors.black,
//                         size: 24,
//                       ),
//                     ),
//                   ));
//                 } else if (allPackageController.errorMessage.isNotEmpty) {
//                   return Center(
//                     child: Text(allPackageController.errorMessage),
//                   );
//                 } else {
//                   return Expanded(
//                     child: ListView.builder(
//                       padding: EdgeInsets.all(0),
//                       itemCount: allPackageController.allPackageData.length,
//                       itemBuilder: (context, index) {
//                         final packageData =
//                             allPackageController.allPackageData[index];
//                         return GestureDetector(
//                           onTap: () {
//                             selectPackage(packageData.id ??
//                                 ''); // Update selection and print ID
//                           },
//                           child: package(
//                             packageData.title ?? '',
//                             packageData.price.toString(),
//                             packageData.id ?? '', // Pass the package ID
//                           ),
//                         );
//                       },
//                     ),
//                   );
//                 }
//               },
//             ),
//             heightBox14,
//             CustomElevatedButton(
//               isLoading: isLoading,
//               title: 'Go to Payment',
//               onPressed: () {
//                 if (selectedPackageId != null) {
//                   getPackage(selectedPackageId!);
//                 }
//               },
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Widget package(String package, String price, String packageId) {
//     return Container(
//       width: double.infinity,
//       decoration: BoxDecoration(
//           border: Border.all(color: Colors.grey),
//           color: Color.fromARGB(255, 255, 253, 253),
//           borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(
//                   package,
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
//                 ),
//                 heightBox4,
//                 Row(
//                   children: [
//                     Text(
//                       '\$$price',
//                       style: TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w600,
//                         color: const Color.fromARGB(255, 4, 4, 4),
//                       ),
//                     ),
//                     Text(
//                       '/month',
//                       style: TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w400,
//                         color: const Color.fromARGB(255, 87, 87, 87),
//                       ),
//                     ),
//                   ],
//                 )
//               ],
//             ),
//             Checkbox(
//               value: selectedPackageId ==
//                   packageId, // Check if this package is selected
//               onChanged: (value) {
//                 selectPackage(value == true
//                     ? packageId
//                     : ''); // Update selection and print ID
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> getPackage(String packageId) async {
//     setState(() {
//       isLoading = true;
//     });
//     final bool isSuccess =
//         await subscriptionController.getSubscription(packageId);

//     setState(() {
//       isLoading = false;
//     });

//     if (isSuccess) {
//       if (mounted) {
//         paymentService.payment(
//             context, subscriptionController.subcriptionId ?? '');
//         print('Subscription ID: ${subscriptionController.subcriptionId}');
//       }
//     } else {
//       if (mounted) {
//         showSnackBarMessage(
//           context,
//           subscriptionController.errorMessage ??
//               'Failed to create subscription',
//           true,
//         );
//       }
//     }
//   }
// }
