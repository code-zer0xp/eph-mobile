import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../utils/constants/app_constants.dart';
import '../utils/toast/toast_helper.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  final String _baseUrl = AppConstants.baseUrl;

  // Default headers
  Map<String, String> get _headers => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

  // GET request
  Future<Map<String, dynamic>?> get(String endpoint,
      {Map<String, String>? headers}) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl$endpoint'),
        headers: {..._headers, ...?headers},
      );

      return _handleResponse(response);
    } catch (e) {
      if (kDebugMode) print('GET Error: $e');
      ToastHelper.showErrorToast(message: 'Network error occurred');
      return null;
    }
  }

  // POST request
  Future<Map<String, dynamic>?> post(
    String endpoint, {
    Map<String, dynamic>? data,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl$endpoint'),
        headers: {..._headers, ...?headers},
        body: data != null ? json.encode(data) : null,
      );

      return _handleResponse(response);
    } catch (e) {
      if (kDebugMode) print('POST Error: $e');
      ToastHelper.showErrorToast(message: 'Network error occurred');
      return null;
    }
  }

  // PUT request
  Future<Map<String, dynamic>?> put(
    String endpoint, {
    Map<String, dynamic>? data,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await http.put(
        Uri.parse('$_baseUrl$endpoint'),
        headers: {..._headers, ...?headers},
        body: data != null ? json.encode(data) : null,
      );

      return _handleResponse(response);
    } catch (e) {
      if (kDebugMode) print('PUT Error: $e');
      ToastHelper.showErrorToast(message: 'Network error occurred');
      return null;
    }
  }

  // DELETE request
  Future<Map<String, dynamic>?> delete(String endpoint,
      {Map<String, String>? headers}) async {
    try {
      final response = await http.delete(
        Uri.parse('$_baseUrl$endpoint'),
        headers: {..._headers, ...?headers},
      );

      return _handleResponse(response);
    } catch (e) {
      if (kDebugMode) print('DELETE Error: $e');
      ToastHelper.showErrorToast(message: 'Network error occurred');
      return null;
    }
  }

  // Handle HTTP response
  Map<String, dynamic>? _handleResponse(http.Response response) {
    if (kDebugMode) {
      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');
    }

    if (response.statusCode >= 200 && response.statusCode < 300) {
      try {
        return json.decode(response.body);
      } catch (e) {
        if (kDebugMode) print('JSON Decode Error: $e');
        return {'success': true, 'data': response.body};
      }
    } else {
      String errorMessage =
          'Request failed with status: ${response.statusCode}';

      try {
        final errorData = json.decode(response.body);
        errorMessage = errorData['message'] ?? errorMessage;
      } catch (e) {
        // Use default error message if JSON parsing fails
      }

      ToastHelper.showErrorToast(message: errorMessage);
      return null;
    }
  }
}
