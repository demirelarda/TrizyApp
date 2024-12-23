import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class UnauthorizedException implements Exception {
  final String message;
  UnauthorizedException(this.message);
}

class NetworkingManager {
  final String baseUrl;
  final int maxRetryAttempts = 3;

  NetworkingManager({
    required this.baseUrl,
  });

  Future<Map<String, dynamic>> post({
    required String endpoint,
    required Map<String, dynamic> body,
    Map<String, String>? headers,
    Map<String, String>? urlParams,
    bool addAuthToken = false,
  }) async {
    return await _handleRequestWithRetry(
          () async => await _postRequest(endpoint, body, headers, urlParams, addAuthToken),
    );
  }

  Future<Map<String, dynamic>> get({
    required String endpoint,
    Map<String, String>? headers,
    Map<String, String>? urlParams,
    Map<String, String>? queryParams,
    bool addAuthToken = false,
  }) async {
    return await _handleRequestWithRetry(
          () async => await _getRequest(endpoint, headers, urlParams, queryParams, addAuthToken),
    );
  }

  Future<Map<String, dynamic>> delete({
    required String endpoint,
    Map<String, String>? headers,
    Map<String, String>? urlParams,
    Map<String, String>? queryParams,
    bool addAuthToken = false,
  }) async {
    return await _handleRequestWithRetry(
          () async => await _deleteRequest(endpoint, headers, urlParams, queryParams, addAuthToken),
    );
  }

  Future<Map<String, dynamic>> patch({
    required String endpoint,
    required Map<String, dynamic> body,
    Map<String, String>? headers,
    Map<String, String>? urlParams,
    bool addAuthToken = false,
  }) async {
    return await _handleRequestWithRetry(
          () async => await _patchRequest(endpoint, body, headers, urlParams, addAuthToken),
    );
  }

  Future<Map<String, dynamic>> put({
    required String endpoint,
    required Map<String, dynamic> body,
    Map<String, String>? headers,
    Map<String, String>? urlParams,
    bool addAuthToken = false,
  }) async {
    return await _handleRequestWithRetry(
          () async => await _putRequest(endpoint, body, headers, urlParams, addAuthToken),
    );
  }

  Future<Map<String, dynamic>> _postRequest(
      String endpoint,
      Map<String, dynamic> body,
      Map<String, String>? headers,
      Map<String, String>? urlParams,
      bool addAuthToken,
      ) async {
    final url = _constructUrl(endpoint, urlParams);
    final defaultHeaders = await _buildHeaders(headers, addAuthToken);

    try {
      final response = await http.post(
        url,
        headers: defaultHeaders,
        body: jsonEncode(body),
      );
      return _processResponse(response);
    } on SocketException {
      throw Exception("No internet connection");
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }

  Future<Map<String, dynamic>> _getRequest(
      String endpoint,
      Map<String, String>? headers,
      Map<String, String>? urlParams,
      Map<String, String>? queryParams,
      bool addAuthToken,
      ) async {
    final url = _constructUrl(endpoint, urlParams, queryParams);
    final defaultHeaders = await _buildHeaders(headers, addAuthToken);

    try {
      final response = await http.get(
        url,
        headers: defaultHeaders,
      );
      return _processResponse(response);
    } on SocketException {
      throw Exception("No internet connection");
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }

  Future<Map<String, dynamic>> _putRequest(
      String endpoint,
      Map<String, dynamic> body,
      Map<String, String>? headers,
      Map<String, String>? urlParams,
      bool addAuthToken,
      ) async {
    final url = _constructUrl(endpoint, urlParams);
    final defaultHeaders = await _buildHeaders(headers, addAuthToken);

    try {
      final response = await http.put(
        url,
        headers: defaultHeaders,
        body: jsonEncode(body),
      );
      return _processResponse(response);
    } on SocketException {
      throw Exception("No internet connection");
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }

  Future<Map<String, dynamic>> _deleteRequest(
      String endpoint,
      Map<String, String>? headers,
      Map<String, String>? urlParams,
      Map<String, String>? queryParams,
      bool addAuthToken,
      ) async {
    final url = _constructUrl(endpoint, urlParams, queryParams);
    final defaultHeaders = await _buildHeaders(headers, addAuthToken);

    try {
      final response = await http.delete(
        url,
        headers: defaultHeaders,
      );
      return _processResponse(response);
    } on SocketException {
      throw Exception("No internet connection");
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }

  Future<Map<String, dynamic>> _patchRequest(
      String endpoint,
      Map<String, dynamic> body,
      Map<String, String>? headers,
      Map<String, String>? urlParams,
      bool addAuthToken,
      ) async {
    final url = _constructUrl(endpoint, urlParams);
    final defaultHeaders = await _buildHeaders(headers, addAuthToken);

    try {
      final response = await http.patch(
        url,
        headers: defaultHeaders,
        body: jsonEncode(body),
      );
      return _processResponse(response);
    } on SocketException {
      throw Exception("No internet connection");
    } catch (e) {
      throw Exception("Unexpected error: $e");
    }
  }

  Future<Map<String, dynamic>> _handleRequestWithRetry(
      Future<Map<String, dynamic>> Function() request,
      ) async {
    int attempt = 0;

    while (attempt < maxRetryAttempts) {
      try {
        return await request();
      } on UnauthorizedException {
        final success = await _refreshAccessToken();
        if (!success) break;
      } catch (error) {
        rethrow;
      }
      attempt++;
    }
    throw Exception("Authentication failed after $maxRetryAttempts attempts.");
  }

  Future<bool> _refreshAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    final refreshToken = prefs.getString('refreshToken');

    if (refreshToken == null) return false;

    final refreshUrl = Uri.parse('$baseUrl/refreshAccessToken');
    final response = await http.post(
      refreshUrl,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'refreshToken': refreshToken}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final newAccessToken = data['accessToken'];
      final newRefreshToken = data['refreshToken'];

      await prefs.setString('accessToken', newAccessToken);
      await prefs.setString('refreshToken', newRefreshToken);

      return true;
    } else {
      return false;
    }
  }

  Uri _constructUrl(String endpoint, Map<String, String>? urlParams, [Map<String, String>? queryParams]) {
    if (urlParams != null) {
      urlParams.forEach((key, value) {
        endpoint = endpoint.replaceAll('{$key}', value);
      });
    }

    final uri = Uri.parse('$baseUrl/$endpoint');

    if (queryParams != null) {
      return uri.replace(queryParameters: {...uri.queryParameters, ...queryParams});
    }
    return uri;
  }

  Future<Map<String, String>> _buildHeaders(
      Map<String, String>? headers,
      bool addAuthToken,
      ) async {
    final defaultHeaders = <String, String>{
      'Content-Type': 'application/json',
      ...?headers,
    };

    if (addAuthToken) {
      final accessToken = await _getAccessToken();
      if (accessToken != null) {
        defaultHeaders['Authorization'] = 'Bearer $accessToken';
      }
    }

    return defaultHeaders;
  }

  Future<String?> _getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken');
  }

  Map<String, dynamic> _processResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 401) {
      throw UnauthorizedException('401 Unauthorized');
    } else {
      throw Exception('Error: ${response.statusCode}, ${response.body}');
    }
  }
}