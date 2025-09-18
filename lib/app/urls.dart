class Urls {
  // =========================================== Base ================================================ //
  // static const String _baseUrl = 'http://10.10.10.17:5005/api/v1';
  // static const String socketUrl = 'http://10.10.10.17:4000/';

  static const String _baseUrl = 'http://206.162.244.133:5001/api/v1';
  static const String socketUrl = 'http://206.162.244.133:4001/';

  // =========================================== Common ============================================== //
  static const String districtsUrl = '$_baseUrl/districts';
  static const String districtUrl = '$_baseUrl/districts';
  static const String schoolsUrl = '$_baseUrl/schools';
  static const String categoryUrl = '$_baseUrl/categories';
  static const String profileUrl = '$_baseUrl/teachers/profile';
  static const String notificationsUrl = '$_baseUrl/notifications';
  static const String contentUrl = '$_baseUrl/legal';

  // =========================================== Authentication ====================================== //
  static const String signUpUrl = '$_baseUrl/teachers/signup';
  static const String refreshTokenUrl = '$_baseUrl/auth/refresh-token';
  static const String googleAuthUrl = '$_baseUrl/auth/google-login';
  static const String otpVerifyUrl = '$_baseUrl/auth/verify-otp';
  static const String signInUrl = '$_baseUrl/auth/login';
  static const String forgotPasswordUrl = '$_baseUrl/auth/send-otp';
  static const String changePasswordUrl = '$_baseUrl/auth/change-password';
  static const String deleteAccountUrl = '$_baseUrl/auth/change-password';
  static const String resterPasswordUrl =
      '$_baseUrl/auth/reset-forgotten-password';

  // =========================================== Profile Block ======================================= //
  static const String updateProfileUrl = '$_baseUrl/teachers/profile';
  static const String updateProfilImageUrl =
      '$_baseUrl/teachers/profile/change-image';

  // =========================================== Home Block ========================================== //
  static const String assetsUrl = '$_baseUrl/assets';
  static const String myAssetsUrl = '$_baseUrl/assets/my-posted';
  static const String createAssetUrl = '$_baseUrl/assets';
  static const String myGrabbedUrl = '$_baseUrl/assets/my-grabbed';
  static String assetsDetailsById(String id) {
    return '$_baseUrl/assets/$id';
  }
   static String deleteNotificationById(String id) {
    return '$_baseUrl/notifications/$id';
  }

  // =========================================== Chat Block =========================================== //
  static const String allFriendsChatnUrl = '$_baseUrl/chats/my';
  static const String lastGrappedUrl = '$_baseUrl/assets/last-grabbed';
  static const String createChatUrl = '$_baseUrl/chats';
  static String messagesById(String id) {
    return '$_baseUrl/messages/$id';
  }

  static String grabbedById(String id) {
    return '$_baseUrl/assets/$id/grab';
  }
}
