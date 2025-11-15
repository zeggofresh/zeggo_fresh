import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:zeggo_fresh/core/api/api_constants.dart';
import 'package:zeggo_fresh/core/api/api_exception.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  // Helper method to handle API responses
  void _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return; // Success
    } else {
      String errorMessage = 'An error occurred';
      try {
        final errorData = jsonDecode(response.body);
        errorMessage = errorData['message'] ?? errorMessage;
      } catch (e) {
        // If parsing fails, use the default message
      }
      throw ApiException(errorMessage, statusCode: response.statusCode);
    }
  }

  // Registration API call
  Future<http.Response> registerUser({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    final url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.registerEndpoint}');
    
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
      }),
    );

    _handleResponse(response);
    return response;
  }

  // Add other API calls here as needed
  Future<http.Response> loginUser({required String email, required String password}) async {
    final url = Uri.parse('${ApiConstants.baseUrl}${ApiConstants.loginEndpoint}');
    
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    _handleResponse(response);
    return response;
  }
  // Future<http.Response> getProducts() async { }
}