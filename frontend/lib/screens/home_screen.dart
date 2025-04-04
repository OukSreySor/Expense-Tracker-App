import 'package:flutter/material.dart';
import 'package:frontend/theme/theme.dart';
import 'package:frontend/widgets/actions/ept_button.dart';
import 'package:frontend/widgets/actions/ept_text_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Moneta',
                style: EPTTextStyles.heading.copyWith(color: EPTColors.primary, letterSpacing: EPTSpacings.s), 
                ),
              SizedBox(height: EPTSpacings.xxl),
              Image.asset(
                'images/ep-1.png', 
                height: 200, 
                fit: BoxFit.contain,
              ),
              SizedBox(height: EPTSpacings.xxl),
              Text(
                'See where your money goes and start saving smarter.',
                textAlign: TextAlign.center,
                style: EPTTextStyles.body
              ),
              SizedBox(height: 4),
              Text(
                'Sign up or log in to track your finances.',
                textAlign: TextAlign.center,
                style: EPTTextStyles.body
              ),
              SizedBox(height: EPTSpacings.xxl),
              EptButton(
                  text: 'CREATE ACCOUNT', 
                  onPressed: () {}
                ),
              
              SizedBox(height: 16.0),
              EptTextButton(
                text: 'LOG IN', 
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }

}