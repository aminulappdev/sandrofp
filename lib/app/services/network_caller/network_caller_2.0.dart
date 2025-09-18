// // ignore_for_file: depend_on_referenced_packages

// import 'dart:convert';
// import 'dart:io';
// import 'package:alyse_roe/app/services/network_caller/error_message_model.dart';
// import 'package:alyse_roe/app/services/network_caller/network_response.dart';
// import 'package:http/http.dart' as http;
// import 'package:logger/logger.dart';
// import 'package:http_parser/http_parser.dart';
// import 'package:mime/mime.dart';

// class NetworkCaller {
//   final Logger _logger = Logger();

//   // Clean file path to remove file:// prefix
//   String _cleanPath(String path) {
//     return path.startsWith('file://') ? path.replaceFirst('file://', '') : path;
//   }

//   // Log request details
//   void _logRequest(
//     String url, [
//     Map<String, dynamic>? headers,
//     Map<String, dynamic>? body,
//   ]) {
//     _logger.i('URL => $url\nHeaders => $headers\nBODY => $body');
//   }

//   // Log response details
//   void _logResponse(
//     String url,
//     int statusCode,
//     Map<String, String>? headers,
//     String body, [
//     String? errorMessage,
//   ]) {
//     if (errorMessage != null) {
//       _logger.e('URL => $url\nError Message => $errorMessage');
//     } else {
//       _logger.i(
//         'URL => $url\nHeaders => $headers\nStatusCode => $statusCode\nBODY => $body',
//       );
//     }
//   }

//   Future<NetworkResponse> getRequest(
//     String url, {
//     Map<String, dynamic>? queryParams,
//     String? accessToken,
//   }) async {
//     try {
//       _logRequest(url);

//       if (queryParams != null) {
//         url += '?';
//         for (String param in queryParams.keys) {
//           url += '$param=${queryParams[param]}&';
//         }
//         url = url.substring(0, url.length - 1); // Remove trailing "&"
//       }
//       Uri uri = Uri.parse(url);
//       Map<String, String> headers = {'content-type': 'application/json'};
//       if (accessToken != null && accessToken.isNotEmpty) {
//         headers['Authorization'] = 'Bearer $accessToken';
//       }

//       var response = await http.get(uri, headers: headers);
//       _logResponse(url, response.statusCode, response.headers, response.body);
//       if (response.statusCode == 200) {
//         final debugMessage = jsonDecode(response.body);
//         return NetworkResponse(
//           isSuccess: true,
//           statusCode: response.statusCode,
//           responseData: debugMessage,
//         );
//       } else {
//         final debugMessage = jsonDecode(response.body);
//         ErrorMessageModel errorMessageModel = ErrorMessageModel.fromJson(
//           debugMessage,
//         );
//         return NetworkResponse(
//           isSuccess: false,
//           statusCode: response.statusCode,
//           errorMessage: errorMessageModel.message ?? 'Something went wrong',
//         );
//       }
//     } catch (e) {
//       _logResponse(url, -1, null, '', e.toString());
//       return NetworkResponse(
//         isSuccess: false,
//         statusCode: -1,
//         errorMessage: e.toString(),
//       );
//     }
//   }

//   Future<NetworkResponse> patchRequest(
//     String url, {
//     Map<String, dynamic>? queryParams,
//     String? accessToken,
//     Map<String, dynamic>? body,
//   }) async {
//     try {
//       _logRequest(url);

//       if (queryParams != null && queryParams.isNotEmpty) {
//         url += '?';
//         for (String param in queryParams.keys) {
//           url += '$param=${queryParams[param]}&';
//         }
//         url = url.substring(0, url.length - 1); // Remove trailing "&"
//       }

//       Uri uri = Uri.parse(url);
//       Map<String, String> headers = {};
//       if (body != null) {
//         headers['content-type'] = 'application/json';
//       }
//       if (accessToken != null && accessToken.isNotEmpty) {
//         headers['Authorization'] = 'Bearer $accessToken';
//       }

//       _logRequest(url, headers, body);

//       final response = await http.patch(
//         uri,
//         headers: headers,
//         body: body != null ? jsonEncode(body) : null,
//       );

//       _logResponse(url, response.statusCode, response.headers, response.body);

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         final debugMessage = jsonDecode(response.body);
//         return NetworkResponse(
//           isSuccess: true,
//           statusCode: response.statusCode,
//           responseData: debugMessage,
//         );
//       } else {
//         final debugMessage = jsonDecode(response.body);
//         ErrorMessageModel errorMessageModel = ErrorMessageModel.fromJson(
//           debugMessage,
//         );
//         return NetworkResponse(
//           isSuccess: false,
//           statusCode: response.statusCode,
//           errorMessage: errorMessageModel.message ?? 'Something went wrong',
//         );
//       }
//     } catch (e) {
//       _logResponse(url, -1, null, '', e.toString());
//       return NetworkResponse(
//         isSuccess: false,
//         statusCode: -1,
//         errorMessage: e.toString(),
//       );
//     }
//   }

//   Future<NetworkResponse> postRequest(
//     String url,
//     Map<String, dynamic>? body, {
//     String? accessToken,
//   }) async {
//     try {
//       Uri uri = Uri.parse(url);
//       Map<String, String> headers = {'content-type': 'application/json'};
//       if (accessToken != null && accessToken.isNotEmpty) {
//         headers['Authorization'] = 'Bearer $accessToken';
//       }

//       _logRequest(url, headers, body);
//       var response = await http.post(uri, headers: headers, body: jsonEncode(body));
//       _logResponse(url, response.statusCode, response.headers, response.body);
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         final debugMessage = jsonDecode(response.body);
//         return NetworkResponse(
//           isSuccess: true,
//           statusCode: response.statusCode,
//           responseData: debugMessage,
//         );
//       } else {
//         final debugMessage = jsonDecode(response.body);
//         ErrorMessageModel errorMessageModel = ErrorMessageModel.fromJson(
//           debugMessage,
//         );
//         return NetworkResponse(
//           isSuccess: false,
//           statusCode: response.statusCode,
//           errorMessage: errorMessageModel.message ?? 'Something went wrong',
//         );
//       }
//     } catch (e) {
//       _logResponse(url, -1, null, '', e.toString());
//       return NetworkResponse(
//         isSuccess: false,
//         statusCode: -1,
//         errorMessage: e.toString(),
//       );
//     }
//   }

//   Future<NetworkResponse> putRequest(
//     String url,
//     Map<String, dynamic>? body, {
//     String? accessToken,
//   }) async {
//     try {
//       Uri uri = Uri.parse(url);
//       Map<String, String> headers = {'content-type': 'application/json'};
//       if (accessToken != null && accessToken.isNotEmpty) {
//         headers['Authorization'] = 'Bearer $accessToken';
//       }

//       _logRequest(url, headers, body);
//       var response = await http.put(uri, headers: headers, body: jsonEncode(body));
//       _logResponse(url, response.statusCode, response.headers, response.body);
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         final debugMessage = jsonDecode(response.body);
//         return NetworkResponse(
//           isSuccess: true,
//           statusCode: response.statusCode,
//           responseData: debugMessage,
//         );
//       } else {
//         final debugMessage = jsonDecode(response.body);
//         ErrorMessageModel errorMessageModel = ErrorMessageModel.fromJson(
//           debugMessage,
//         );
//         return NetworkResponse(
//           isSuccess: false,
//           statusCode: response.statusCode,
//           errorMessage: errorMessageModel.message ?? 'Something went wrong',
//         );
//       }
//     } catch (e) {
//       _logResponse(url, -1, null, '', e.toString());
//       return NetworkResponse(
//         isSuccess: false,
//         statusCode: -1,
//         errorMessage: e.toString(),
//       );
//     }
//   }

//   Future<NetworkResponse> deleteRequest(
//     String url, {
//     Map<String, dynamic>? queryParams,
//     String? accessToken,
//   }) async {
//     try {
//       _logRequest(url);

//       if (queryParams != null) {
//         url += '?';
//         for (String param in queryParams.keys) {
//           url += '$param=${queryParams[param]}&';
//         }
//         url = url.substring(0, url.length - 1); // Remove trailing "&"
//       }
//       Uri uri = Uri.parse(url);
//       Map<String, String> headers = {'content-type': 'application/json'};
//       if (accessToken != null && accessToken.isNotEmpty) {
//         headers['Authorization'] = 'Bearer $accessToken';
//       }

//       var response = await http.delete(uri, headers: headers);
//       _logResponse(url, response.statusCode, response.headers, response.body);
//       if (response.statusCode == 200) {
//         final debugMessage = jsonDecode(response.body);
//         return NetworkResponse(
//           isSuccess: true,
//           statusCode: response.statusCode,
//           responseData: debugMessage,
//         );
//       } else {
//         final debugMessage = jsonDecode(response.body);
//         ErrorMessageModel errorMessageModel = ErrorMessageModel.fromJson(
//           debugMessage,
//         );
//         return NetworkResponse(
//           isSuccess: false,
//           statusCode: response.statusCode,
//           errorMessage: errorMessageModel.message ?? 'Something went wrong',
//         );
//       }
//     } catch (e) {
//       _logResponse(url, -1, null, '', e.toString());
//       return NetworkResponse(
//         isSuccess: false,
//         statusCode: -1,
//         errorMessage: e.toString(),
//       );
//     }
//   }

//   Future<NetworkResponse> postRequestWithFile(
//     String url, {
//     Map<String, dynamic>? queryParams,
//     Map<String, dynamic>? body,
//     File? image,
//     List<File>? images,
//     File? cover,
//     String? accessToken,
//     String? keyNameImage,
//     String? keyNameCover,
//   }) async {
//     try {
//       // Append query parameters if provided
//       if (queryParams != null && queryParams.isNotEmpty) {
//         url += '?';
//         for (String param in queryParams.keys) {
//           url += '$param=${queryParams[param]}&';
//         }
//         url = url.substring(0, url.length - 1); // Remove trailing "&"
//       }

//       Uri uri = Uri.parse(url);
//       var request = http.MultipartRequest('POST', uri);

//       // Set headers
//       Map<String, String> headers = {};
//       if (accessToken != null && accessToken.isNotEmpty) {
//         headers['Authorization'] = 'Bearer $accessToken';
//       }
//       request.headers.addAll(headers);

//       // Set JSON fields
//       if (body != null) {
//         request.fields['payload'] = jsonEncode(body);
//       }

//       // Add single image if available
//       if (image != null) {
//         String imagePath = _cleanPath(image.path);
//         print('Adding image: $imagePath');
//         if (await image.exists()) {
//           String? mimeType = lookupMimeType(imagePath) ?? 'image/jpeg';
//           request.files.add(
//             await http.MultipartFile.fromPath(
//               keyNameImage ?? 'image',
//               imagePath,
//               contentType: MediaType.parse(mimeType),
//             ),
//           );
//         } else {
//           print('Image file does not exist: $imagePath');
//           return NetworkResponse(
//             isSuccess: false,
//             statusCode: -1,
//             errorMessage: 'Image file does not exist: $imagePath',
//           );
//         }
//       } else {
//         print('No image provided');
//       }

//       // Add multiple images if available
//       if (images != null && images.isNotEmpty) {
//         for (File img in images) {
//           String imagePath = _cleanPath(img.path);
//           print('Adding images: $imagePath');
//           if (await img.exists()) {
//             String? mimeType = lookupMimeType(imagePath) ?? 'image/jpeg';
//             request.files.add(
//               await http.MultipartFile.fromPath(
//                 keyNameImage ?? 'images[]',
//                 imagePath,
//                 contentType: MediaType.parse(mimeType),
//               ),
//             );
//           } else {
//             print('Image file does not exist: $imagePath');
//           }
//         }
//       }

//       // Add cover if available
//       if (cover != null) {
//         String coverPath = _cleanPath(cover.path);
//         print('Adding cover: $coverPath');
//         if (await cover.exists()) {
//           String? mimeType = lookupMimeType(coverPath) ?? 'image/jpeg';
//           request.files.add(
//             await http.MultipartFile.fromPath(
//               keyNameCover ?? 'cover',
//               coverPath,
//               contentType: MediaType.parse(mimeType),
//             ),
//           );
//         } else {
//           print('Cover file does not exist: $coverPath');
//         }
//       }

//       // Log request
//       _logRequest(url, headers, body);
//       print('Request files: ${request.files}');

//       // Send request
//       var streamedResponse = await request.send();
//       var responseBody = await streamedResponse.stream.bytesToString();

//       // Log response
//       _logResponse(
//         url,
//         streamedResponse.statusCode,
//         streamedResponse.headers,
//         responseBody,
//       );

//       var decodedResponse = jsonDecode(responseBody);

//       if (streamedResponse.statusCode == 200 ||
//           streamedResponse.statusCode == 201) {
//         return NetworkResponse(
//           isSuccess: true,
//           statusCode: streamedResponse.statusCode,
//           responseData: decodedResponse,
//         );
//       } else {
//         ErrorMessageModel errorMessageModel = ErrorMessageModel.fromJson(
//           decodedResponse,
//         );
//         return NetworkResponse(
//           isSuccess: false,
//           statusCode: streamedResponse.statusCode,
//           errorMessage:
//               errorMessageModel.message ?? 'Failed to process request',
//         );
//       }
//     } catch (e) {
//       _logResponse(url, -1, null, '', e.toString());
//       return NetworkResponse(
//         isSuccess: false,
//         statusCode: -1,
//         errorMessage: e.toString(),
//       );
//     }
//   }

//   Future<NetworkResponse> patchRequestWithFile(
//     String url, {
//     Map<String, dynamic>? queryParams,
//     Map<String, dynamic>? body,
//     File? image,
//     List<File>? images,
//     File? cover,
//     String? accessToken,
//     String? keyNameImage,
//     String? keyNameCover,
//   }) async {
//     try {
//       // Append query parameters if provided
//       if (queryParams != null && queryParams.isNotEmpty) {
//         url += '?';
//         for (String param in queryParams.keys) {
//           url += '$param=${queryParams[param]}&';
//         }
//         url = url.substring(0, url.length - 1); // Remove trailing "&"
//       }

//       Uri uri = Uri.parse(url);
//       var request = http.MultipartRequest('PATCH', uri);

//       // Set headers
//       Map<String, String> headers = {};
//       if (accessToken != null && accessToken.isNotEmpty) {
//         headers['Authorization'] = 'Bearer $accessToken';
//       }
//       request.headers.addAll(headers);

//       // Set JSON fields
//       if (body != null) {
//         request.fields['payload'] = jsonEncode(body);
//       }

//       // Add single image if available
//       if (image != null) {
//         String imagePath = _cleanPath(image.path);
//         print('Adding image: $imagePath');
//         if (await image.exists()) {
//           String? mimeType = lookupMimeType(imagePath) ?? 'image/jpeg';
//           request.files.add(
//             await http.MultipartFile.fromPath(
//               keyNameImage ?? 'image',
//               imagePath,
//               contentType: MediaType.parse(mimeType),
//             ),
//           );
//         } else {
//           print('Image file does not exist: $imagePath');
//           return NetworkResponse(
//             isSuccess: false,
//             statusCode: -1,
//             errorMessage: 'Image file does not exist: $imagePath',
//           );
//         }
//       } else {
//         print('No image provided');
//       }

//       // Add multiple images if available
//       if (images != null && images.isNotEmpty) {
//         for (File img in images) {
//           String imagePath = _cleanPath(img.path);
//           print('Adding images: $imagePath');
//           if (await img.exists()) {
//             String? mimeType = lookupMimeType(imagePath) ?? 'image/jpeg';
//             request.files.add(
//               await http.MultipartFile.fromPath(
//                 keyNameImage ?? 'images[]',
//                 imagePath,
//                 contentType: MediaType.parse(mimeType),
//               ),
//             );
//           } else {
//             print('Image file does not exist: $imagePath');
//           }
//         }
//       }

//       // Add cover if available
//       if (cover != null) {
//         String coverPath = _cleanPath(cover.path);
//         print('Adding cover: $coverPath');
//         if (await cover.exists()) {
//           String? mimeType = lookupMimeType(coverPath) ?? 'image/jpeg';
//           request.files.add(
//             await http.MultipartFile.fromPath(
//               keyNameCover ?? 'cover',
//               coverPath,
//               contentType: MediaType.parse(mimeType),
//             ),
//           );
//         } else {
//           print('Cover file does not exist: $coverPath');
//         }
//       }

//       // Log request
//       _logRequest(url, headers, body);
//       print('Request files: ${request.files}');

//       // Send request
//       var streamedResponse = await request.send();
//       var responseBody = await streamedResponse.stream.bytesToString();

//       // Log response
//       _logResponse(
//         url,
//         streamedResponse.statusCode,
//         streamedResponse.headers,
//         responseBody,
//       );

//       var decodedResponse = jsonDecode(responseBody);

//       if (streamedResponse.statusCode == 200 ||
//           streamedResponse.statusCode == 201) {
//         return NetworkResponse(
//           isSuccess: true,
//           statusCode: streamedResponse.statusCode,
//           responseData: decodedResponse,
//         );
//       } else {
//         ErrorMessageModel errorMessageModel = ErrorMessageModel.fromJson(
//           decodedResponse,
//         );
//         return NetworkResponse(
//           isSuccess: false,
//           statusCode: streamedResponse.statusCode,
//           errorMessage:
//               errorMessageModel.message ?? 'Failed to process request',
//         );
//       }
//     } catch (e) {
//       _logResponse(url, -1, null, '', e.toString());
//       return NetworkResponse(
//         isSuccess: false,
//         statusCode: -1,
//         errorMessage: e.toString(),
//       );
//     }
//   }

//   Future<NetworkResponse> putRequestWithFile(
//     String url, {
//     Map<String, dynamic>? queryParams,
//     Map<String, dynamic>? body,
//     File? image,
//     List<File>? images,
//     File? cover,
//     String? accessToken,
//     String? keyNameImage,
//     String? keyNameCover,
//   }) async {
//     try {
//       // Append query parameters if provided
//       if (queryParams != null && queryParams.isNotEmpty) {
//         url += '?';
//         for (String param in queryParams.keys) {
//           url += '$param=${queryParams[param]}&';
//         }
//         url = url.substring(0, url.length - 1); // Remove trailing "&"
//       }

//       Uri uri = Uri.parse(url);
//       var request = http.MultipartRequest('PUT', uri);

//       // Set headers
//       Map<String, String> headers = {};
//       if (accessToken != null && accessToken.isNotEmpty) {
//         headers['Authorization'] = 'Bearer $accessToken';
//       }
//       request.headers.addAll(headers);

//       // Set JSON fields
//       if (body != null) {
//         request.fields['payload'] = jsonEncode(body);
//       }

//       // Add single image if available
//       if (image != null) {
//         String imagePath = _cleanPath(image.path);
//         print('Adding image: $imagePath');
//         if (await image.exists()) {
//           String? mimeType = lookupMimeType(imagePath) ?? 'image/jpeg';
//           request.files.add(
//             await http.MultipartFile.fromPath(
//               keyNameImage ?? 'image',
//               imagePath,
//               contentType: MediaType.parse(mimeType),
//             ),
//           );
//         } else {
//           print('Image file does not exist: $imagePath');
//           return NetworkResponse(
//             isSuccess: false,
//             statusCode: -1,
//             errorMessage: 'Image file does not exist: $imagePath',
//           );
//         }
//       } else {
//         print('No image provided');
//       }

//       // Add multiple images if available
//       if (images != null && images.isNotEmpty) {
//         for (File img in images) {
//           String imagePath = _cleanPath(img.path);
//           print('Adding images: $imagePath');
//           if (await img.exists()) {
//             String? mimeType = lookupMimeType(imagePath) ?? 'image/jpeg';
//             request.files.add(
//               await http.MultipartFile.fromPath(
//                 keyNameImage ?? 'images[]',
//                 imagePath,
//                 contentType: MediaType.parse(mimeType),
//               ),
//             );
//           } else {
//             print('Image file does not exist: $imagePath');
//           }
//         }
//       }

//       // Add cover if available
//       if (cover != null) {
//         String coverPath = _cleanPath(cover.path);
//         print('Adding cover: $coverPath');
//         if (await cover.exists()) {
//           String? mimeType = lookupMimeType(coverPath) ?? 'image/jpeg';
//           request.files.add(
//             await http.MultipartFile.fromPath(
//               keyNameCover ?? 'cover',
//               coverPath,
//               contentType: MediaType.parse(mimeType),
//             ),
//           );
//         } else {
//           print('Cover file does not exist: $coverPath');
//         }
//       }

//       // Log request
//       _logRequest(url, headers, body);
//       print('Request files: ${request.files}');

//       // Send request
//       var streamedResponse = await request.send();
//       var responseBody = await streamedResponse.stream.bytesToString();

//       // Log response
//       _logResponse(
//         url,
//         streamedResponse.statusCode,
//         streamedResponse.headers,
//         responseBody,
//       );

//       var decodedResponse = jsonDecode(responseBody);

//       if (streamedResponse.statusCode == 200 ||
//           streamedResponse.statusCode == 201) {
//         return NetworkResponse(
//           isSuccess: true,
//           statusCode: streamedResponse.statusCode,
//           responseData: decodedResponse,
//         );
//       } else {
//         ErrorMessageModel errorMessageModel = ErrorMessageModel.fromJson(
//           decodedResponse,
//         );
//         return NetworkResponse(
//           isSuccess: false,
//           statusCode: streamedResponse.statusCode,
//           errorMessage:
//               errorMessageModel.message ?? 'Failed to process request',
//         );
//       }
//     } catch (e) {
//       _logResponse(url, -1, null, '', e.toString());
//       return NetworkResponse(
//         isSuccess: false,
//         statusCode: -1,
//         errorMessage: e.toString(),
//       );
//     }
//   }

//   Future<NetworkResponse> patchRequestWithToken(
//     String url, {
//     Map<String, dynamic>? queryParams,
//     String? accessToken,
//     Map<String, dynamic>? body,
//   }) async {
//     try {
//       _logRequest(url);

//       if (queryParams != null && queryParams.isNotEmpty) {
//         url += '?';
//         for (String param in queryParams.keys) {
//           url += '$param=${queryParams[param]}&';
//         }
//         url = url.substring(0, url.length - 1); // Remove trailing "&"
//       }

//       Uri uri = Uri.parse(url);
//       Map<String, String> headers = {};
//       if (body != null) {
//         headers['content-type'] = 'application/json';
//       }
//       if (accessToken != null && accessToken.isNotEmpty) {
//         headers['token'] = accessToken;
//       }

//       _logRequest(url, headers, body);

//       final response = await http.patch(
//         uri,
//         headers: headers,
//         body: body != null ? jsonEncode(body) : null,
//       );

//       _logResponse(url, response.statusCode, response.headers, response.body);

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         final debugMessage = jsonDecode(response.body);
//         return NetworkResponse(
//           isSuccess: true,
//           statusCode: response.statusCode,
//           responseData: debugMessage,
//         );
//       } else {
//         final debugMessage = jsonDecode(response.body);
//         ErrorMessageModel errorMessageModel = ErrorMessageModel.fromJson(
//           debugMessage,
//         );
//         return NetworkResponse(
//           isSuccess: false,
//           statusCode: response.statusCode,
//           errorMessage: errorMessageModel.message ?? 'Something went wrong',
//         );
//       }
//     } catch (e) {
//       _logResponse(url, -1, null, '', e.toString());
//       return NetworkResponse(
//         isSuccess: false,
//         statusCode: -1,
//         errorMessage: e.toString(),
//       );
//     }
//   }

//   Future<NetworkResponse> postRequestWithToken(
//     String url,
//     Map<String, dynamic>? body, {
//     String? accessToken,
//   }) async {
//     try {
//       Uri uri = Uri.parse(url);
//       Map<String, String> headers = {'content-type': 'application/json'};
//       if (accessToken != null && accessToken.isNotEmpty) {
//         headers['token'] = accessToken;
//       }

//       _logRequest(url, headers, body);
//       var response = await http.post(uri, headers: headers, body: jsonEncode(body));
//       _logResponse(url, response.statusCode, response.headers, response.body);
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         final debugMessage = jsonDecode(response.body);
//         return NetworkResponse(
//           isSuccess: true,
//           statusCode: response.statusCode,
//           responseData: debugMessage,
//         );
//       } else {
//         final debugMessage = jsonDecode(response.body);
//         ErrorMessageModel errorMessageModel = ErrorMessageModel.fromJson(
//           debugMessage,
//         );
//         return NetworkResponse(
//           isSuccess: false,
//           statusCode: response.statusCode,
//           errorMessage: errorMessageModel.message ?? 'Something went wrong',
//         );
//       }
//     } catch (e) {
//       _logResponse(url, -1, null, '', e.toString());
//       return NetworkResponse(
//         isSuccess: false,
//         statusCode: -1,
//         errorMessage: e.toString(),
//       );
//     }
//   }
// }