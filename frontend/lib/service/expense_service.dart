import 'dart:convert';
import 'package:frontend/data/expense_dto.dart';
import 'package:frontend/utils/auth_util.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/model/expense.dart';

class ExpenseService {
  static const String baseUrl = 'http://localhost:5000/expense';

  Future<String> addExpense(Expense expense) async {
    try {
      String token = await getToken();
      if (token.isEmpty) {
        return 'Error: No token found. Please log in.';
      }
      final response = await http.post(
        Uri.parse('$baseUrl/add'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(ExpenseDto.toJson(expense)),
      );

      if (response.statusCode == 201) {
        return 'Expense added successfully!';
      } else {
        return 'Error adding expense: ${response.body}';
      }
    } catch (e) {
      return 'Error adding expense: $e';
    }
  }

}
