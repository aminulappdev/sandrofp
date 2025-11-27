import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:sandrofp/app/modules/payment/view/html_view_screen.dart';
import 'package:sandrofp/app/services/network_caller/network_response.dart';

class PaymentURLController extends GetxController {
  final Logger _logger = Logger();

  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _accessToken;
  String? get accessToken => _accessToken;

  // Custom GET request function to handle both JSON and HTML responses
  Future<NetworkResponse> _customGetRequest(
    String url, {
    Map<String, String>? headers,
    String? accessToken,
    String? token,
  }) async {
    try {
      Uri uri = Uri.parse(url);
      Map<String, String> defaultHeaders = {
        'content-type': 'application/json',
        ...?headers, // Merge custom headers
      };

      // Add accessToken or token to headers if provided
      if (token != null && token.isNotEmpty) {
        defaultHeaders['token'] = token;
      } else if (accessToken != null && accessToken.isNotEmpty) {
        defaultHeaders['Authorization'] = 'Bearer $accessToken';
      }

      // Log request
      _logger.i('URL => $url\nHeaders => $defaultHeaders');

      // Make HTTP GET request
      final response = await http.get(uri, headers: defaultHeaders);

      // Log response
      _logger.i(
        'URL => $url\nStatusCode => ${response.statusCode}\nHeaders => ${response.headers}\nBody => ${response.body}',
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Check Content-Type to determine response type
        final contentType = response.headers['content-type'];
        if (contentType != null && contentType.contains('application/json')) {
          // JSON response
          try {
            final decodedResponse = jsonDecode(response.body);
            return NetworkResponse(
              isSuccess: true,
              statusCode: response.statusCode,
              responseData: decodedResponse,
            );
          } catch (e) {
            return NetworkResponse(
              isSuccess: false,
              statusCode: response.statusCode,
              errorMessage: 'Failed to parse JSON: $e',
              responseData: response.body, // Return raw body as fallback
            );
          }
        } else {
          // Non-JSON response (e.g., text/html)
          return NetworkResponse(
            isSuccess: true,
            statusCode: response.statusCode,
            responseData: response.body, // Return raw body
          );
        }
      } else {
        // Handle error responses
        try {
          final decodedResponse = jsonDecode(response.body);
          return NetworkResponse(
            isSuccess: false,
            statusCode: response.statusCode,
            errorMessage: decodedResponse['message'] ?? 'Something went wrong',
            responseData: decodedResponse,
          );
        } catch (e) {
          // If error response is not JSON, return raw body
          return NetworkResponse(
            isSuccess: false,
            statusCode: response.statusCode,
            errorMessage: 'Unexpected response format: $e',
            responseData: response.body,
          );
        }
      }
    } catch (e) {
      _logger.e('URL => $url\nError => $e');
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  Future<bool> paymentUrl(String paymentLink) async {
    print('Payment Link from PaymentURLController: $paymentLink');
    bool isSuccess = false;

    _inProgress = true;
    update();

    // Use custom GET request instead of NetworkCaller
    final NetworkResponse response = await _customGetRequest(paymentLink);
    print('Payment Controller response received');
    print('Status Code: ${response.statusCode}');
    print('Response Data: ${response.responseData}');
    print('Error Message: ${response.errorMessage}');

    if (response.isSuccess && response.statusCode == 200) {
      if (response.responseData is String &&
          response.responseData.contains('<!doctype html>')) {
        // HTML response
        Get.to(() => HtmlViewScreen(htmlContent: response.responseData));
        _errorMessage = null;
        isSuccess = true;
      } else if (response.responseData is Map || response.responseData is List) {
        // JSON response
       
        _errorMessage = null;
        isSuccess = true;
      } else {
        _errorMessage = 'Unexpected response format';
        print('Error: $_errorMessage');
      }
    } else {
      _errorMessage = response.errorMessage;
      print('Error: $_errorMessage');
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}