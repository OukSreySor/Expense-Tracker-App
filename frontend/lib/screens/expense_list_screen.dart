
import 'package:flutter/material.dart';
import 'package:frontend/model/expense.dart';
import 'package:frontend/provider/expense_provider.dart';
import 'package:frontend/screens/add_expense_screen.dart';
import 'package:frontend/screens/login_screen.dart';
import 'package:frontend/screens/monthly_spend_screen.dart';
import 'package:frontend/service/expense_service.dart';
import 'package:frontend/theme/theme.dart';
import 'package:frontend/utils/date_time_util.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExpenseListScreen extends StatefulWidget {
  ExpenseListScreen({super.key});

  @override
  State<ExpenseListScreen> createState() => _ExpenseListScreenState();
}

class _ExpenseListScreenState extends State<ExpenseListScreen> {
  
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
    Provider.of<ExpenseProvider>(context, listen: false).setExpenses(expenseList);
    
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
              Consumer<ExpenseProvider>(builder: (context, provider, child) {
                return Text('Hey there, !', style: EPTTextStyles.title.copyWith(color: EPTColors.primary));
              }),
              SizedBox(height: EPTSpacings.xs),
              Text('Hope you’re having a great day  ^ ^', style: EPTTextStyles.body),
              SizedBox(height: EPTSpacings.l),
              // Add new expense button
              CustomActionButton(
                label: 'Add new expense', 
                icon: Icons.add, 
                onPressed: () async {
                  final newExpense = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddExpenseScreen()),
                  );
                  if (newExpense != null) {
                     await Provider.of<ExpenseProvider>(context, listen: false).fetchExpenses();
                  }
                },
                backgroundColor: EPTColors.addEpt,
              ),
              SizedBox(height: EPTSpacings.s),
              // Logout button
              CustomActionButton(
                label: 'Logout',
                icon: Icons.logout,
                onPressed: () async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  await prefs.remove('token');
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                backgroundColor: Colors.red,
              ),
              SizedBox(height: EPTSpacings.l),
              Text('Your expenses', style: EPTTextStyles.body),
              SizedBox(height: EPTSpacings.m),
              Consumer<ExpenseProvider>(builder: (context, provider, child) {
                return provider.expenses.isEmpty
                    ? Expanded(child: Center(child: Text('No expenses yet.')))
                    : Expanded(
                        child: ListView.builder(
                          itemCount: provider.expenses.length,
                          itemBuilder: (context, index) {
                            final expense = provider.expenses[index];
                            return ExpenseItemTile(
                              expense: expense,
                              imagePath: categoryImages[expense.category] ?? 'images/categories/default.png',
                              onEdit: () async {
                                final updatedExpense = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddExpenseScreen(expenseToEdit: expense), 
                                  ),
                                );
                                if (updatedExpense != null) {
                                  Provider.of<ExpenseProvider>(context, listen: false).updateExpense(expense.id!, updatedExpense);
                                }
                              },
                              onDelete: () async {
                                final shouldDelete = await showDialog<bool>(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text('Confirm delete'),
                                    content: Text('Are you sure you want to delete this expense?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context, false),
                                        child: Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () => Navigator.pop(context, true),
                                        child: Text('Delete'),
                                      ),
                                    ],
                                  ),
                                );
                                if (shouldDelete == true) {
                                  provider.deleteExpense(expense.id!);
                                }
                              },
                            );
                          },
                        ),
                      );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

// CustomActionButton widget for reusable action buttons
class CustomActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  final Color? backgroundColor;

  const CustomActionButton({
    Key? key,
    required this.label,
    required this.icon,
    required this.onPressed,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, color: Colors.white),
        label: Text(label, style: TextStyle(color: Colors.white)),
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? EPTColors.primary,
          padding: EdgeInsets.symmetric(horizontal: EPTSpacings.m, vertical: EPTSpacings.m),
        ),
      ),
    );
  }
}

// ExpenseItemTile widget for displaying each expense item
class ExpenseItemTile extends StatelessWidget {
  final Expense expense;
  final String imagePath;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const ExpenseItemTile({
    Key? key,
    required this.expense,
    required this.imagePath,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  Text(expense.category, style: EPTTextStyles.body),
                  SizedBox(height: EPTSpacings.xs),
                  Text(DateTimeUtils.formatDateTime(expense.date)),
                  Text('\$${expense.amount.toStringAsFixed(2)}',
                      style: EPTTextStyles.label.copyWith(color: EPTColors.amount)),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.orange),
                  onPressed: onEdit,
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: onDelete,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

