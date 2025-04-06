
import 'package:flutter/material.dart';
import 'package:frontend/service/expense_service.dart';
import 'package:frontend/theme/theme.dart';
import 'package:intl/intl.dart';

class MonthlySpendingGridScreen extends StatefulWidget {
  final String month;

  MonthlySpendingGridScreen({required this.month});

  @override
  _MonthlySpendingGridScreenState createState() =>
      _MonthlySpendingGridScreenState();
}

class _MonthlySpendingGridScreenState extends State<MonthlySpendingGridScreen> {
  late Future<Map<String, double>> dailySpendingFuture;

  @override
  void initState() {
    super.initState();
    dailySpendingFuture = ExpenseService().getDailySpending(widget.month);
  }

  String formatMonth(String month) {
  final DateTime date = DateFormat('yyyy-MM').parse(month);
  return DateFormat('MMMM yyyy').format(date); 
  }

  Map<String, double> _sumExpenses(Map<String, double> dailySpending) {
    final Map<String, double> summedSpending = {};

    dailySpending.forEach((day, total) {
      if (summedSpending.containsKey(day)) {
        summedSpending[day] = summedSpending[day]! + total;
      } else {
        summedSpending[day] = total;
      }
    });

    return summedSpending;
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
              Text('Daily Spending For - ${formatMonth(widget.month)}', style: EPTTextStyles.title.copyWith(color: EPTColors.primary)),
              SizedBox(height: EPTSpacings.xxl),
              FutureBuilder<Map<String, double>>(
                future: dailySpendingFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
              
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
              
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No spending data available.'));
                  }
              
                  final dailySpending = snapshot.data!;
              
                  // Sum the expenses on the same day
                  final summedSpending = _sumExpenses(dailySpending);

                  String _getWeekdayName(String date) {
                    final DateTime parsedDate = DateFormat('yyyy-MM-dd').parse(date);
                    final String weekday = DateFormat('EEE').format(parsedDate); 
                    return weekday;
                  }
              
                  return Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, 
                        crossAxisSpacing: 12.0,
                        mainAxisSpacing: 12.0,
                      ),
                      itemCount: summedSpending.length,
                      itemBuilder: (context, index) {
                        final day = summedSpending.keys.elementAt(index);
                        final total = summedSpending[day]!;
                        final weekday = _getWeekdayName(day);
                                  
                        return Card(
                          color: Color.fromARGB(255, 195, 250, 238),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: SizedBox(
                            width: 100, 
                            height: 40,
                            child: Padding(
                              padding: EdgeInsets.all(4),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(weekday, style: TextStyle(color: EPTColors.primary)),
                                    SizedBox(height: EPTSpacings.s),
                                    Text(day),
                                    SizedBox(height: EPTSpacings.xs),
                                    Text(
                                      '\$${total.toStringAsFixed(2)}',
                                      style: TextStyle(color: EPTColors.amount),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

