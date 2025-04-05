class Expense {
  final int? id;
  final double amount;
  final String category;
  final DateTime date;
  final String? notes;

  Expense({
    this.id,
    required this.amount,
    required this.category,
    required this.date,
    this.notes,
  });
}
