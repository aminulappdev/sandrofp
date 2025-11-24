class Urls {
  // =========================================== Base ================================================ //
  // static const String _baseUrl = 'http://10.10.10.17:5005/api/v1';
  // static const String socketUrl = 'http://10.10.10.17:4000/';

  static const String _baseUrl = 'http://103.186.20.117:6136/api/v1';
  static const String socketUrl = 'http://103.186.20.117:6005/';

  // =========================================== Authentication ====================================== //
  static const String signUpUrl = '$_baseUrl/users';
  static const String refreshTokenUrl = '$_baseUrl/auth/refresh-token';
  static const String googleAuthUrl = '$_baseUrl/auth/google-login';
  static const String otpVerifyUrl = '$_baseUrl/otp/verify-otp';
  static const String resendUrl = '$_baseUrl/otp/resend-otp';
  static const String forgetPasswordUrl = '$_baseUrl/auth/forgot-password'; 
  static const String resetPasswordUrl = '$_baseUrl/auth/reset-password';
  static const String changePasswordUrl = '$_baseUrl/auth/change-password';

  static const String signInUrl = '$_baseUrl/auth/login';

  // =========================================== Profile ====================================== //
  static const String profileUrl = '$_baseUrl/users/my-profile';
  static const String updateProfileUrl = '$_baseUrl/users/update-my-profile';
  static const String contentUrl = '$_baseUrl/contents';
  static const String myFeedbackUrl = '$_baseUrl/reviews';
  static const String notificationUrl = '$_baseUrl/notifications';


  // =========================================== Home ====================================== //
  static String categoryUrl = '$_baseUrl/categories';

   // =========================================== Product ====================================== //
  static String productUrl = '$_baseUrl/products';
  static String myProductUrl = '$_baseUrl/products/my-products';
  static String exchangeUrl = '$_baseUrl/exchanges';

  // =========================================== Product ====================================== //
  
  static String myExchangeUrl = '$_baseUrl/exchanges/my-requests';
  static String feedbackUrl = '$_baseUrl/reviews';

   // =========================================== Chat Block =========================================== //
  static const String allFriendsChatnUrl = '$_baseUrl/chats/my-chat-list';
  static const String lastGrappedUrl = '$_baseUrl/assets/last-grabbed';
  static const String createChatUrl = '$_baseUrl/chats';
  static const String imageDecodeUrl = '$_baseUrl/uploads/single';
  static const String messageSeenUrl = '$_baseUrl/upload-files';

  static String messagesById(String id) { 
    return '$_baseUrl/messages/get-by-recovered/$id';
  }

   static String messagesSeenById(String id) {
    return '$_baseUrl/messages/seen/$id';
  }


  static String grabbedById(String id) {
    return '$_baseUrl/assets/$id/grab';
  }
}
