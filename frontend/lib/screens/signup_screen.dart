import 'package:flutter/material.dart';
import 'package:frontend/screens/login_screen.dart';
import 'package:frontend/service/auth_service.dart';
import 'package:frontend/theme/theme.dart';
import 'package:frontend/widgets/actions/ept_button.dart';
import 'package:frontend/widgets/actions/ept_text_button.dart';
import 'package:frontend/widgets/inputs/ept_textfield.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Register user
  void _registerUser() async {
    final username = _usernameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;

    String response = await AuthService().registerUser(username, email, password);

    showSnackbar(context, response);

    if (response == 'User registered successfully!') {
      Future.delayed(Duration(seconds: 2), () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      });
    }
  }

  void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.green,
      ),
    );
  }

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
                style: EPTTextStyles.title.copyWith(color: EPTColors.primary),
              ),
              SizedBox(height: EPTSpacings.xs),
              Text('Create an account to join Moneta :)',
                  style: EPTTextStyles.body),
              SizedBox(height: EPTSpacings.xxxl),
              Text('Username'),
              SizedBox(height: EPTSpacings.xs),
              EptTextField(
                controller: _usernameController,
              ),
              SizedBox(height: EPTSpacings.m),
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
                obscureText: true,
              ),
              SizedBox(height: EPTSpacings.xxxl),
              Center(
                child: EptButton(
                  text: 'CREATE',
                  onPressed: _registerUser,
                ),
              ),
              SizedBox(height: EPTSpacings.m),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account? "),
                  EptTextButton(
                      text: 'LOG IN',
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      })
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
