import 'package:flutter/material.dart';
import 'package:frontend/provider/expense_provider.dart';
import 'package:frontend/screens/home_screen.dart';
import 'package:frontend/theme/theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create:(context) => ExpenseProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appTheme,
        home: HomeScreen(),
      ),
    );
  }
}
