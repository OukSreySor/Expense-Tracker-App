import 'package:flutter/material.dart';
import 'package:frontend/theme/theme.dart';
import 'package:frontend/widgets/actions/ept_button.dart';
import 'package:frontend/widgets/actions/ept_text_button.dart';
import 'package:frontend/widgets/inputs/ept_textfield.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(EPTSpacings.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, 
            children: [
              Text(
                'Welcome!',
                style: EPTTextStyles.heading,
              ),
              SizedBox(height: EPTSpacings.xs),
              Text(
                'Create an account to join Moneta :)',
                style: EPTTextStyles.body
              ),
              SizedBox(height: EPTSpacings.xxxl),
              Text('Email'),
              SizedBox(height: EPTSpacings.xs),
              EptTextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: EPTSpacings.m),
              Text('Password'),
              SizedBox(height: EPTSpacings.xs),
              EptTextField(
                controller: _passwordController,
              ),
              SizedBox(height: EPTSpacings.m),
              Text('Confirm Password'),
              SizedBox(height: EPTSpacings.xs),
              EptTextField(
                controller: _confirmPasswordController,
                obscureText: true,
              ),
              SizedBox(height: EPTSpacings.xxxl),
              Center(
                child: EptButton(
                  text: 'CREATE', 
                  onPressed: (){}
                ),
              ),
              SizedBox(height: EPTSpacings.m),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account? "),
                  EptTextButton(
                    text: 'LOG IN', 
                    onPressed: (){}
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}