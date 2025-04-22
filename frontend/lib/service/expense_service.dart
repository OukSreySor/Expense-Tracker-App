import 'dart:async';
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

  Future<List<Expense>> getExpenses() async {

    try {
      String token = await getToken();  
    
      if (token.isEmpty) {
        throw Exception('No token found. Please log in.');
      }

      final response = await http.get(
        Uri.parse('$baseUrl/expense-list'),
         headers: {
          'Authorization': 'Bearer $token',  
        },
        
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((expenseData) => ExpenseDto.fromJson(expenseData)).toList();
      } else {
        throw Exception('Failed to load expenses');
      }
    } catch (e) {
      throw Exception('Error fetching expenses: $e');
    }
  }

  Future<String> updateExpense(int expenseId, Expense expense) async {
    try {
      String token = await getToken();
      if (token.isEmpty) {
        return 'Error: No token found. Please log in.';
      }

      final response = await http.put(
        Uri.parse('$baseUrl/update/$expenseId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode(ExpenseDto.toJson(expense)),
      );

      if (response.statusCode == 200) {
        return 'Expense updated successfully!';
      } else {
        return 'Error updating expense: ${response.body}';
      }
    } catch (e) {
      return 'Error updating expense: $e';
    }
  }

  Future<String> deleteExpense(int expenseId) async {
    try {
      String token = await getToken();
      if (token.isEmpty) {
        return 'Error: No token found. Please log in.';
      }

      final response = await http.delete(
        Uri.parse('$baseUrl/delete/$expenseId'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return 'Expense deleted successfully!';
      } else {
        return 'Error deleting expense: ${response.body}';
      }
    } catch (e) {
      return 'Error deleting expense: $e';
    }
  }

  Future<Map<String, double>> getDailySpending(String month) async {
    try {
      String token = await getToken();
    
      if (token.isEmpty) {
        throw Exception('No token found. Please log in.');
      }

      final response = await http.get(
        Uri.parse('$baseUrl/daily-summary?month=$month'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        // Convert the response data to a map of date -> spending
        Map<String, double> dailySpending = {};
        data.forEach((key, value) {
          dailySpending[key] = value.toDouble();
        });
        return dailySpending;
      } else {
        throw Exception('Failed to load daily spending data');
      }
    } catch (e) {
      throw Exception('Error fetching daily spending data: $e');
    }
  }

}
