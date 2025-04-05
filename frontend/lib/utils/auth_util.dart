import 'package:shared_preferences/shared_preferences.dart';

Future<void> storeToken(String token) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('token', token);
  print("Token stored: $token");
}

Future<String> getToken() async {
  final prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  print("Fetched token: $token");  
  return token ?? ''; 

}