import 'dart:convert';
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
      return "Error registering user: ${response.body}";
    }
  }

}
