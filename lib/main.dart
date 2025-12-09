import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandrofp/app/get_storage.dart';
import 'package:sandrofp/app/modules/dashboard/views/dashboard_screen.dart';
import 'package:sandrofp/app/modules/onboarding/views/onboarding_01.dart';
import 'package:sandrofp/app/res/app_binder/controller_binder.dart';
import 'package:sandrofp/app/services/location/google_distance_services.dart';
import 'package:sandrofp/app/services/socket/socket_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await GetStorage.init();

  // await PushNotificationService().init();

  // Init FCM token
  // await _initFCMToken();

  // এই দুই লাইন খুব জরুরি
  await Get.putAsync<LocationService>(() async {
    final service = LocationService();
    await service.init();
    return service;
  });

  final SocketService socketService = Get.put(SocketService());
  await socketService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        useInheritedMediaQuery: true,
        initialBinding: ControllerBinder(),
        theme: ThemeData(
          scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255),
          fontFamily: 'Poppins',
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          inputDecorationTheme: _inputDecorationTheme(),
        ),
        home: StorageUtil.getData(StorageUtil.userAccessToken) != null
            ? DashboardScreen()
            : OnboardingScreen01(),
      ),
    );
  }
}

InputDecorationTheme _inputDecorationTheme() {
  return InputDecorationTheme(
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    hintStyle: GoogleFonts.poppins(fontWeight: FontWeight.w300, fontSize: 14),
    fillColor: Color(0xffF3F3F5),
    filled: true,
    border: _inputBorder(),
    enabledBorder: _inputBorder(),
    focusedBorder: _inputBorder(),
    errorBorder: _inputBorder(),
  );
}

OutlineInputBorder _inputBorder() {
  return OutlineInputBorder(
    borderSide: BorderSide.none,
    borderRadius: BorderRadius.circular(50.r),
  );
}


// TextFormField(
//                       decoration: InputDecoration(
//                         suffixIcon: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Container(
//                             height: 40,
//                             width: 80,
//                             decoration: BoxDecoration(
//                               color: Colors.black,
//                               borderRadius: BorderRadius.circular(20),
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.all(4.0),
//                               child: Center(
//                                 child: Text(
//                                   'Apply',
//                                   style: GoogleFonts.poppins(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w400,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         hintText: 'Enter discount code',
//                         filled: true,
//                         fillColor: Color(0xffF3F3F5),
//                       ),
//                     ),