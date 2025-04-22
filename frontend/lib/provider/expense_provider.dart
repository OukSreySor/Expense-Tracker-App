
import 'package:flutter/material.dart';
import 'package:frontend/model/expense.dart';
import 'package:frontend/service/expense_service.dart';


class ExpenseProvider with ChangeNotifier {
  final ExpenseService _expenseService = ExpenseService();

  List<Expense> _expenses = [];
  bool _isLoading = false;
  String _message = '';
  Map<String, double> _dailySpending = {};

  List<Expense> get expenses => _expenses;
  bool get isLoading => _isLoading;
  String get message => _message;
  Map<String, double> get dailySpending => _dailySpending;

  ExpenseProvider() {
    _loadExpenses();
  }

  void setExpenses(List<Expense> expenses) {
    _expenses = expenses;
    notifyListeners();  
  }

  Future<void> _loadExpenses() async {
    _expenses = await ExpenseService().getExpenses();
    notifyListeners();
  }

  Future<void> fetchExpenses() async {
    _isLoading = true;
    notifyListeners();

    try {
      _expenses = await _expenseService.getExpenses();
      _message = '';
    } catch (e) {
      _message = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addExpense(Expense expense) async {
    _isLoading = true;
    notifyListeners();

    try {
      String response = await _expenseService.addExpense(expense);
      _message = response;

      if (response.contains('successfully')) {
        await fetchExpenses(); 
      }
    } catch (e) {
      _message = 'Error: $e';
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> updateExpense(int id, Expense expense) async {
    _isLoading = true;
    notifyListeners();

    try {
      String response = await _expenseService.updateExpense(id, expense);
      _message = response;

      if (response.contains('successfully')) {
        await fetchExpenses();
      }
    } catch (e) {
      _message = 'Error: $e';
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> deleteExpense(int id) async {
    _isLoading = true;
    notifyListeners();

    try {
      String response = await _expenseService.deleteExpense(id);
      _message = response;

      if (response.contains('successfully')) {
        await fetchExpenses();
      }
    } catch (e) {
      _message = 'Error: $e';
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchDailySpending(String month) async {
    try {
      _dailySpending = await _expenseService.getDailySpending(month);
      notifyListeners();
    } catch (e) {
      _message = 'Error fetching daily spending: $e';
      notifyListeners();
    }
  }
}
