import 'package:flutter/material.dart';
import 'package:frontend/model/expense.dart';
import 'package:frontend/screens/add_expense_screen.dart';
import 'package:frontend/screens/login_screen.dart';
import 'package:frontend/screens/monthly_spend_screen.dart';
import 'package:frontend/service/expense_service.dart';
import 'package:frontend/theme/theme.dart';
import 'package:frontend/utils/date_time_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExpenseListScreen extends StatefulWidget {
  ExpenseListScreen({super.key});

  @override
  State<ExpenseListScreen> createState() => _ExpenseListScreenState();
}

class _ExpenseListScreenState extends State<ExpenseListScreen> {

  late List<Expense> _expenses = [];

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
  void initState() {
    super.initState();
    _loadExpenses();  
  }

  void _loadExpenses() async {
    var expenseList = await ExpenseService().getExpenses();  
    setState(() {
      _expenses = expenseList;  
    });
  }

  Future<void> logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()), 
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(EPTSpacings.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Hey there!', style: EPTTextStyles.title.copyWith(color: EPTColors.primary)),
              SizedBox(height: EPTSpacings.xs),
              Text('Hope you’re having a great day  ^ ^', style: EPTTextStyles.body),
              SizedBox(height: EPTSpacings.l),
              Align(
                alignment: Alignment.centerRight,
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      final newExpense = await Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => AddExpenseScreen())
                      );
                      if (newExpense != null){
                        setState(() {
                          _expenses.add(newExpense);
                        });
                      }
                    },
                    icon: Icon(Icons.add, color: Colors.white),
                    label: Text('Add new expense', style: TextStyle(color: Colors.white),),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: EPTColors.addEpt,
                      padding: EdgeInsets.symmetric(horizontal: EPTSpacings.m, vertical: EPTSpacings.m),
                    ),
                  ),           
              ),
              SizedBox(height: EPTSpacings.s),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    logout(context);  
                  },
                  icon: Icon(Icons.logout, color: Colors.white),
                  label: Text('Logout', style: TextStyle(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: EPTSpacings.m, vertical: EPTSpacings.m),
                  ),
                ),
              ),
              SizedBox(height: EPTSpacings.l),
              Text('Your expenses', style: EPTTextStyles.body),
              SizedBox(height: EPTSpacings.m),
              _expenses.isEmpty
                  ? Center(child: Text('No expenses yet.'))
                  : Expanded(
                    child: ListView.builder(
                      itemCount: _expenses.length,
                      itemBuilder: (context, index) {
                        final expense = _expenses[index];
                        final category = expense.category;
                        final imagePath = categoryImages[category] ?? 'images/categories/default.png';

                        // Extract the month from the expense date
                        final String month = '${expense.date.year}-${expense.date.month.toString().padLeft(2, '0')}';
                      
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MonthlySpendingGridScreen(month: month),
                              ),
                            );
                          },
                        child: Container(
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
                        )
                        );
                  }
                ),
                  )
              ]
            )
          )
        )
    );
}
}

