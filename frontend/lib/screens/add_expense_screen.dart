import 'package:flutter/material.dart';
import 'package:frontend/model/expense.dart';
import 'package:frontend/service/expense_service.dart';
import 'package:frontend/theme/theme.dart';
import 'package:frontend/utils/date_time_util.dart';
import 'package:frontend/widgets/actions/ept_button.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});
  
  @override
  _AddExpenseScreenState createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  DateTime? _selectedDate;
  String? _selectedCategory;

  final List<Map<String, dynamic>> _categories = [
    {'name': 'Food', 'color': Colors.orange.shade200},
    {'name': 'Transportation', 'color': Colors.blue.shade200},
    {'name': 'Clothes', 'color': Colors.purple.shade200},
    {'name': 'Groceries', 'color': Colors.green.shade200},
    {'name': 'Internet', 'color': Colors.indigo.shade200},
    {'name': 'Travel', 'color': Colors.teal.shade200},
    {'name': 'Skincare', 'color': Colors.pink.shade200},
    {'name': 'Utilities', 'color': Colors.brown.shade200},
    {'name': 'HealthCare', 'color': Colors.red.shade200},
    {'name': 'Entertainment', 'color': Colors.cyan.shade200},
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2026),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateTimeUtils.formatDateTime(_selectedDate!);
      });
    }
  }

  void _addExpense() async {
    if (_amountController.text.isEmpty || _selectedCategory == null || _dateController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill in all fields")),
      );
      return;
    }

    Expense expense = Expense(
      amount: double.parse(_amountController.text),
      category: _selectedCategory!,
      date: _selectedDate!,
      notes: _noteController.text,
    );

    // Call the ExpenseService to add the expense
    ExpenseService expenseService = ExpenseService();
    String result = await expenseService.addExpense(expense);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(result)),
    );

    // If successfully added, navigate back to the previous screen
    if (result.contains('successfully')) {
      Navigator.pop(context);
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(EPTSpacings.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add a new Expense',
              style: EPTTextStyles.title.copyWith(color: EPTColors.primary),
            ),
            SizedBox(height: EPTSpacings.xs),
            Text(
              'It\'s a good habit to keep track of your expenditure',
              style: EPTTextStyles.body,
            ),
            SizedBox(height: EPTSpacings.xl),
            CustomTextField(
              label: 'Amount', 
              controller: _amountController,
              prefixText: '\$',
            ),
            SizedBox(height: EPTSpacings.l),
            CustomTextField(
              label: 'Date',
              controller: _dateController,
              readOnly: true,
              onTap: () => _selectDate(context),
              suffixIcon: const Icon(Icons.calendar_today),
            ),
            SizedBox(height: EPTSpacings.l),
            CustomTextField(
              label: 'Note',
              controller: _noteController,
            ),
            SizedBox(height: EPTSpacings.l),
            Text('Category'),
            SizedBox(height: EPTSpacings.l),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: _categories.map((category) {
                final isSelected = _selectedCategory == category['name'];
                return FilterChip(
                  label: Text(category['name']),
                  selected: isSelected,
                  onSelected: (bool selected) {
                    setState(() {
                      if (selected) {
                        _selectedCategory = category['name'];
                      } else if (_selectedCategory == category['name']) {
                        _selectedCategory = null;
                      }
                    });
                  },
                  backgroundColor: isSelected
                      ? category['color']
                      : EPTColors.backgroundAccent,
                  selectedColor: category['color'],
                  labelStyle: TextStyle(color: isSelected ? EPTColors.white : EPTColors.black),
                  showCheckmark: false,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide.none,
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: EPTSpacings.xxl),
            SizedBox(
              width: double.infinity,
              child: EptButton(
                text: 'ADD', 
                onPressed: _addExpense
              ),
            ),
          ],
        ),
      ),
    );
  }

}

class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool readOnly;
  final VoidCallback? onTap;
  final Widget? suffixIcon;
  final String? prefixText;

  const CustomTextField({
    super.key,
    required this.label,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.readOnly = false,
    this.onTap,
    this.suffixIcon,
    this.prefixText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 4), 
          child: Text(label),
        ),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          readOnly: readOnly,
          onTap: onTap,
          style: const TextStyle(fontSize: 14),
          decoration: InputDecoration(
            prefixText: prefixText,
            border: const UnderlineInputBorder(),
            suffixIcon: suffixIcon,
            isDense: true, // Use isDense to reduce default padding
            contentPadding: const EdgeInsets.symmetric(vertical: 12), 
          ),
        ),
      ],
    );
  }
}
