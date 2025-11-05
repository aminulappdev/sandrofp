// ignore_for_file: depend_on_referenced_packages, avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:logger/logger.dart';
import 'package:mime/mime.dart';
import 'package:sandrofp/app/services/network_caller/error_message_model.dart';
import 'package:sandrofp/app/services/network_caller/network_response.dart';


class NetworkCaller {
  final Logger _logger = Logger();

  // GET request
  Future<NetworkResponse> getRequest(
    String url, {
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
    String? accessToken,
  }) async {
    return _handleRequest(
      method: 'GET',
      url: url,
      queryParams: queryParams,
      headers: headers,
      accessToken: accessToken,
    );
  }

  // POST request
  Future<NetworkResponse> postRequest(
    String url, {
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    File? image,
    List<File>? images,
    File? cover,
    String? keyNameImage,
    String? keyNameCover,
    String? accessToken,
  }) async {
    return _handleRequest(
      method: 'POST',
      url: url,
      queryParams: queryParams,
      headers: headers,
      body: body,
      image: image,
      images: images,
      cover: cover,
      keyNameImage: keyNameImage,
      keyNameCover: keyNameCover,
      accessToken: accessToken,
    );
  }

  // PATCH request
  Future<NetworkResponse> patchRequest(
    String url, {
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    File? image,
    List<File>? images,
    File? cover,
    String? keyNameImage,
    String? keyNameCover,
    String? accessToken,
  }) async {
    return _handleRequest(
      method: 'PATCH',
      url: url,
      queryParams: queryParams,
      headers: headers,
      body: body,
      image: image,
      images: images,
      cover: cover,
      keyNameImage: keyNameImage,
      keyNameCover: keyNameCover,
      accessToken: accessToken,
    );
  }

  // PUT request
  Future<NetworkResponse> putRequest(
    String url, {
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    File? image,
    List<File>? images,
    File? cover,
    String? keyNameImage,
    String? keyNameCover,
    String? accessToken,
  }) async {
    return _handleRequest(
      method: 'PUT',
      url: url,
      queryParams: queryParams,
      headers: headers,
      body: body,
      image: image,
      images: images,
      cover: cover,
      keyNameImage: keyNameImage,
      keyNameCover: keyNameCover,
      accessToken: accessToken,
    );
  }

  // DELETE request
  Future<NetworkResponse> deleteRequest(
    String url, {
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
    String? accessToken,
  }) async {
    return _handleRequest(
      method: 'DELETE',
      url: url,
      queryParams: queryParams,
      headers: headers,
      accessToken: accessToken,
    );
  }

  
  String _cleanPath(String path) {
    return path.startsWith('file://') ? path.replaceFirst('file://', '') : path;
  }
 
  void _logRequest(String url, Map<String, String> headers, [dynamic body]) {
    _logger.i('URL => $url\nHeaders => $headers\nBody => $body');
  }

  void _logResponse(
    String url,
    int statusCode,
    Map<String, String>? headers,
    String body, [
    String? errorMessage,
  ]) {
    if (errorMessage != null) {
      _logger.e('URL => $url\nError => $errorMessage');
    } else {
      _logger.i(
        'URL => $url\nStatusCode => $statusCode\nHeaders => $headers\nBody => $body',
      );
    }
  }
 
  Future<NetworkResponse> _handleRequest({
    required String method,
    required String url,
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
    dynamic body,
    File? image,
    List<File>? images,
    File? cover,
    String? keyNameImage,
    String? keyNameCover,
    String? accessToken,
  }) async {
    try {
      // Append query parameters if provided
      if (queryParams != null && queryParams.isNotEmpty) {
        url +=
            '?${queryParams.entries.map((e) => '${e.key}=${e.value}').join('&')}';
      }

      Uri uri = Uri.parse(url);
      Map<String, String> defaultHeaders = {
        'content-type': 'application/json',
        ...?headers, // Merge custom headers
      };

      // Add accessToken to headers if provided
      if (accessToken != null && accessToken.isNotEmpty) {
        defaultHeaders['Authorization'] = 'Bearer $accessToken';
      }

      http.Response? response;
      var request = image != null || images != null || cover != null
          ? http.MultipartRequest(method, uri)
          : null;

      if (request != null) {
        // Handle multipart request for file uploads
        request.headers.addAll(defaultHeaders);
        if (body != null) {
          request.fields['payload'] = jsonEncode(body);
        }

        // Add single image
        if (image != null) {
          String imagePath = _cleanPath(image.path);
          print('Adding image: $imagePath');
          if (await image.exists()) {
            String? mimeType = lookupMimeType(imagePath) ?? 'image/jpeg';
            request.files.add(
              await http.MultipartFile.fromPath(
                keyNameImage ?? 'image',
                imagePath,
                contentType: MediaType.parse(mimeType),
              ),
            );
          } else {
            print('Image file does not exist: $imagePath');
            return NetworkResponse(
              isSuccess: false,
              statusCode: -1,
              errorMessage: 'Image file does not exist: $imagePath',
            );
          }
        }

        // Add multiple images
        if (images != null && images.isNotEmpty) {
          for (File img in images) {
            String imagePath = _cleanPath(img.path);
            print('Adding multiple images: $imagePath');
            if (await img.exists()) {
              String? mimeType = lookupMimeType(imagePath) ?? 'image/jpeg';
              request.files.add(
                await http.MultipartFile.fromPath(
                  keyNameImage ?? 'images',
                  imagePath,
                  contentType: MediaType.parse(mimeType),
                ),
              );
            } else {
              print('Image file does not exist: $imagePath');
            }
          }
        }

        // Add cover image
        if (cover != null) {
          String coverPath = _cleanPath(cover.path);
          print('Adding cover: $coverPath');
          if (await cover.exists()) {
            String? mimeType = lookupMimeType(coverPath) ?? 'image/jpeg';
            request.files.add(
              await http.MultipartFile.fromPath(
                keyNameCover ?? 'cover',
                coverPath,
                contentType: MediaType.parse(mimeType),
              ),
            );
          } else {
            print('Cover file does not exist: $coverPath');
          }
        }

        _logRequest(url, defaultHeaders, body);
        print('Request files: ${request.files}');
        var streamedResponse = await request.send();
        response = await http.Response.fromStream(streamedResponse);
      } else {
        // Handle regular HTTP request 
        _logRequest(url, defaultHeaders, body);
        switch (method) {
          case 'GET':
            response = await http.get(uri, headers: defaultHeaders);
            break;
          case 'POST':
            response = await http.post(
              uri,
              headers: defaultHeaders,
              body: body != null ? jsonEncode(body) : null,
            );
            break;
          case 'PATCH':
            response = await http.patch(
              uri,
              headers: defaultHeaders,
              body: body != null ? jsonEncode(body) : null,
            );
            break;
          case 'PUT':
            response = await http.put(
              uri,
              headers: defaultHeaders,
              body: body != null ? jsonEncode(body) : null,
            );
            break;
          case 'DELETE':
            response = await http.delete(uri, headers: defaultHeaders);
            break;
        }
      }

      _logResponse(url, response!.statusCode, response.headers, response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final decodedResponse = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: decodedResponse,
        );
      } else {
        final decodedResponse = jsonDecode(response.body);
        ErrorMessageModel errorMessageModel = ErrorMessageModel.fromJson(
          decodedResponse,
        );
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: errorMessageModel.message ?? 'Something went wrong',
        );
      }
    } catch (e) {
      _logResponse(url, -1, null, '', e.toString());
      return NetworkResponse(
        isSuccess: false,
        statusCode: -1,
        errorMessage: e.toString(),
      );
    }
  }


}
