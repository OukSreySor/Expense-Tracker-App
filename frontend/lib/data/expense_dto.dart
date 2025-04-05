import 'package:frontend/model/expense.dart';

class ExpenseDto {

  static Map<String, dynamic> toJson(Expense expense) {
    return {
      'amount': expense.amount, 
      'category': expense.category,
      'date': expense.date.toIso8601String(),
      'notes': expense.notes,
    };
  }
  static Expense fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['id'],
      amount: json['amount'], 
      category: json['category'],
      date: DateTime.parse(json['date']),
      notes: json['notes'],
    );
  }
}