// network_caller.dart
// ignore_for_file: depend_on_referenced_packages, avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:logger/logger.dart';
import 'package:mime/mime.dart';

import 'error_message_model.dart';
import 'network_response.dart';

class NetworkCaller {
  final Logger _logger = Logger();

  // ──────────────────────  GET  ──────────────────────
  Future<NetworkResponse> getRequest(
    String url, {
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
    String? accessToken,
    String? customTokenName,
  }) async {
    return _handleRequest(
      method: 'GET',
      url: url,
      queryParams: queryParams,
      headers: headers,
      accessToken: accessToken,
      customTokenName: customTokenName,
    );
  }

  // ──────────────────────  POST  ──────────────────────
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
    String? customTokenName,
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
      customTokenName: customTokenName,
    );
  }

  // ──────────────────────  PATCH  ──────────────────────
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
    String? customTokenName,
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
      customTokenName: customTokenName,
    );
  }

  // ──────────────────────  PUT  ──────────────────────
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
    String? customTokenName,
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
      customTokenName: customTokenName,
    );
  }

  // ──────────────────────  DELETE  ──────────────────────
  Future<NetworkResponse> deleteRequest(
    String url, {
    Map<String, dynamic>? queryParams,
    Map<String, String>? headers,
    String? accessToken,
    String? customTokenName,
  }) async {
    return _handleRequest(
      method: 'DELETE',
      url: url,
      queryParams: queryParams,
      headers: headers,
      accessToken: accessToken,
      customTokenName: customTokenName,
    );
  }

  // ─────────────────────────────────────────────────────
  // ──────────────────────  PRIVATE  ─────────────────────
  // ─────────────────────────────────────────────────────

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
    String? customTokenName,
  }) async {
    try {
      // ────── Query Params ──────
      var finalUrl = url;
      if (queryParams != null && queryParams.isNotEmpty) {
        final qp = queryParams.entries
            .map(
              (e) =>
                  '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value.toString())}',
            )
            .join('&');
        finalUrl += '?$qp';
      }

      final uri = Uri.parse(finalUrl);

      // ────── Default Headers ──────
      final Map<String, String> defaultHeaders = {
        'content-type': 'application/json',
        ...?headers,
      };

      // ────── TOKEN: Authorization = Bearer, অন্যান্য = শুধু token ──────
      if (accessToken != null && accessToken.isNotEmpty) {
        final tokenKey = (customTokenName?.isNotEmpty == true)
            ? customTokenName!
            : 'Authorization';

        if (tokenKey == 'Authorization') {
          defaultHeaders[tokenKey] = 'Bearer $accessToken';
          _logger.d('TOKEN SENT → Authorization: Bearer $accessToken');
        } else {
          defaultHeaders[tokenKey] = accessToken;
          _logger.d('TOKEN SENT → $tokenKey: $accessToken');
        }
      }

      http.Response? response;
      final bool isMultipart =
          image != null || (images?.isNotEmpty ?? false) || cover != null;
      final http.MultipartRequest? multipartReq = isMultipart
          ? http.MultipartRequest(method, uri)
          : null;

      // ────── Multipart (File upload) ──────
      if (multipartReq != null) {
        multipartReq.headers.addAll(defaultHeaders);
        if (body != null) {
          multipartReq.fields['data'] = jsonEncode(body);
        }

        // Single image
        if (image != null) {
          final path = _cleanPath(image.path);
          if (await image.exists()) {
            final mime = lookupMimeType(path) ?? 'image/jpeg';
            multipartReq.files.add(
              await http.MultipartFile.fromPath(
                keyNameImage ?? 'profile',
                path,
                contentType: MediaType.parse(mime),
              ),
            );
          }
        }

        // Multiple images
        if (images != null) {
          for (final img in images) {
            final path = _cleanPath(img.path);
            if (await img.exists()) {
              final mime = lookupMimeType(path) ?? 'image/jpeg';
              multipartReq.files.add(
                await http.MultipartFile.fromPath(
                  keyNameImage ?? 'images',
                  path,
                  contentType: MediaType.parse(mime),
                ),
              );
            }
          }
        }

        // Cover image
        if (cover != null) {
          final path = _cleanPath(cover.path);
          if (await cover.exists()) {
            final mime = lookupMimeType(path) ?? 'image/jpeg';
            multipartReq.files.add(
              await http.MultipartFile.fromPath(
                keyNameCover ?? 'cover',
                path,
                contentType: MediaType.parse(mime),
              ),
            );
          }
        }

        _logRequest(finalUrl, defaultHeaders, body);
        final streamed = await multipartReq.send();
        response = await http.Response.fromStream(streamed);
      }
      // ────── Normal HTTP request ──────
      else {
        _logRequest(finalUrl, defaultHeaders, body);

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
          default:
            throw Exception('Unsupported method: $method');
        }
      }

      // ────── Response handling ──────
      _logResponse(
        finalUrl,
        response!.statusCode,
        response.headers,
        response.body,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return NetworkResponse(
          isSuccess: true,
          statusCode: response.statusCode,
          responseData: data,
        );
      } else {
        dynamic decoded;
        try {
          decoded = jsonDecode(response.body);
        } catch (_) {
          decoded = {'message': response.body};
        }
        final err = ErrorMessageModel.fromJson(decoded);
        return NetworkResponse(
          isSuccess: false,
          statusCode: response.statusCode,
          errorMessage: err.message ?? 'Something went wrong',
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
