// get_storage.dart
// ignore_for_file: avoid_print

import 'package:get_storage/get_storage.dart';
 
class StorageUtil {
  static final box = GetStorage();

  static Future<void> saveData(String key, dynamic value) async {
    await box.write(key, value);
  }

  static dynamic getData(String key) {
    return box.read(key);
  }

  static Future<void> deleteData(String key) async {
    print('Deleting key: $key');
    await box.remove(key);
  }

  // Existing keys
  static String userAccessToken = 'user-access-token';
  static String userId = 'user-id';
  static String otpToken = 'otp-token';

}
