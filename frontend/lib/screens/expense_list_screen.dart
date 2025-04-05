import 'package:flutter/material.dart';
import 'package:frontend/model/expense.dart';
import 'package:frontend/screens/add_expense_screen.dart';
import 'package:frontend/theme/theme.dart';
import 'package:frontend/utils/date_time_util.dart';

class ExpenseListScreen extends StatelessWidget {
  ExpenseListScreen({super.key});

  // Dummy expenses
  final List<Expense> dummyExpenses = [
    Expense(id: 1, amount: 100.0, category: 'Food', date: DateTime(2025, 3, 15), notes: 'Lunch with friends'),
    Expense(id: 2, amount: 50.0, category: 'Clothes', date: DateTime(2025, 3, 15), notes: 'New T-shirt'),
    Expense(id: 3, amount: 70.0, category: 'Groceries', date: DateTime(2025, 3, 15), notes: 'Buy some meat'),
    Expense(id: 4, amount: 25.0, category: 'Skincare', date: DateTime(2025, 3, 15), notes: 'Foam'),
    Expense(id: 5, amount: 2.0, category: 'Internet', date: DateTime(2025, 3, 15), notes: '2 dollars'),
    Expense(id: 6, amount: 4.0, category: 'Drinks', date: DateTime(2025, 3, 15), notes: 'Iced coffee'),
  ];

  // Map category to asset image
  final Map<String, String> categoryImages = {
    'Food': 'images/categories/food.png',
    'Transportation': 'images/categories/transportation.png',
    'Clothes': 'images/categories/clothes.png',
    'Groceries': 'images/categories/groceries.png',
    'Internet': 'images/categories/internet.png',
    'Travel': 'images/categories/travel.png',
    'Skincare': 'images/categories/skincare.png',
    'Utilities': 'images/categories/utilities.png',
    'HealthCare': 'images/categories/healthcare.png',
    'Entertainment': 'images/categories/entertainment.png',
  };


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(EPTSpacings.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Hey there, Sreysor!', style: EPTTextStyles.title.copyWith(color: EPTColors.primary)),
              SizedBox(height: EPTSpacings.xs),
              Text('Hope you’re having a great day  ^ ^', style: EPTTextStyles.body),
              SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => AddExpenseScreen())
                    );
                  },
                  icon: Icon(Icons.add, color: Colors.white),
                  label: Text('Add new expense', style: TextStyle(color: Colors.white),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: EPTColors.addEpt,
                    padding: EdgeInsets.symmetric(horizontal: EPTSpacings.m, vertical: EPTSpacings.m),
                  ),
                ),
              ),

              SizedBox(height: EPTSpacings.l),
              Text('Your expenses', style: EPTTextStyles.body),
              SizedBox(height: EPTSpacings.m),

              // List of expenses
              Expanded(
                child: ListView.builder(
                  itemCount: dummyExpenses.length,
                  itemBuilder: (context, index) {
                    final expense = dummyExpenses[index];
                    final category = expense.category;
                    final imagePath = categoryImages[category] ?? 'images/categories/default.png';

                    return Container(
                      margin: EdgeInsets.only(bottom: EPTSpacings.s),
                      padding: EdgeInsets.all(EPTSpacings.m),
                      decoration: BoxDecoration(
                        color: Colors.pink.shade50,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Image.asset(imagePath, width: 60, height: 60),
                          SizedBox(width: EPTSpacings.m),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(category, style: EPTTextStyles.body),
                                SizedBox(height: EPTSpacings.xs),
                                Text(DateTimeUtils.formatDateTime(expense.date)),     
                                Text('\$${expense.amount.toStringAsFixed(2)}', style: EPTTextStyles.label.copyWith(color: EPTColors.amount)),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit, color: Colors.orange),
                                onPressed: () {},
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
