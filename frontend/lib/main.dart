import 'package:flutter/material.dart';
import 'package:frontend/screens/add_expense_screen.dart';
import 'package:frontend/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: AddExpenseScreen(),
    );
  }
}
