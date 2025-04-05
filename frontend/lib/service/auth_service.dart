import 'dart:convert';
import 'package:frontend/utils/auth_util.dart';
import 'package:http/http.dart' as http;

class AuthService {

  static const String baseUrl = "http://localhost:5000/auth"; 

  // User registration
  Future<String> registerUser(String username, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        'username': username,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 201) {
      return "User registered successfully!";
    } else {
      final error = json.decode(response.body); 
      return "Error registering user: ${error['message']}";
    }
  }

  // User login
  Future<String> loginUser(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      String token = data['token'];
      await storeToken(token);
      return token; 
    } else {
      final error = json.decode(response.body); 
      return "Error logging in: ${error['message']}";
    }
  }

}
