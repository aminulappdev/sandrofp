class Urls {
  // =========================================== Base ================================================ //
  // static const String _baseUrl = 'http://10.10.10.17:5005/api/v1';
  // static const String socketUrl = 'http://10.10.10.17:4000/';

  static const String _baseUrl = 'http://103.186.20.117:6136/api/v1';
  static const String socketUrl = 'http://206.162.244.133:4001/';

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

  // =========================================== Home ====================================== //
  static String categoryUrl = '$_baseUrl/categories';

   // =========================================== Product ====================================== //
  static String productUrl = '$_baseUrl/products';
  static String myProductUrl = '$_baseUrl/products/my-products';
  static String exchangeUrl = '$_baseUrl/exchanges';


  static String grabbedById(String id) {
    return '$_baseUrl/assets/$id/grab';
  }
}
