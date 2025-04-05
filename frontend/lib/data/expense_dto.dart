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
      id: json['ID'],
      amount: json['AMOUNT'], 
      category: json['CATEGORY'],
      date: DateTime.parse(json['DATE']),
      notes: json['NOTES'],
    );
  }
}