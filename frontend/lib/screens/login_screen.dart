import 'package:flutter/material.dart';
import 'package:frontend/theme/theme.dart';
import 'package:frontend/widgets/actions/ept_button.dart';
import 'package:frontend/widgets/actions/ept_text_button.dart';
import 'package:frontend/widgets/inputs/ept_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(EPTSpacings.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  'assets/images/ep-2.png', 
                  height: 200,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: EPTSpacings.xxl),
              Text('Email'),
              SizedBox(height: EPTSpacings.xs),

              EptTextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: EPTSpacings.l),
              Text('Password'),

              SizedBox(height: EPTSpacings.xs),
              EptTextField(
                controller: _passwordController,
                obscureText: true,
              ),
              
              SizedBox(height: EPTSpacings.xxxl),
              Center(
                child: EptButton(
                  text: 'LOG IN', 
                  onPressed: (){}
                )
              ),
              SizedBox(height: EPTSpacings.m),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account? "),
                  EptTextButton(
                    text: 'SIGN UP', 
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