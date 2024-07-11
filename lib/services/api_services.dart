import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'http://mobilecomputing.my.id/api_amru'; // URL API

  Future<void> register(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register.php'),
      body: {
        'username': username,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['status'] == 'success') {
        // Registration successful
      } else {
        throw Exception('Failed to register: ${data['message']}');
      }
    } else {
      throw Exception('Failed to register: Server error');
    }
  }

  Future<void> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login.php'),
      body: {
        'username': username,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['status'] == 'success') {
        // Login successful
        // You might want to handle login success, such as saving token or user info
      } else {
        throw Exception('Failed to login: ${data['message']}');
      }
    } else {
      throw Exception('Failed to login: Server error');
    }
  }
  }

