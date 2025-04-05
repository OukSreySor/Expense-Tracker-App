import 'package:flutter/material.dart';
import 'package:frontend/theme/theme.dart';


class EptTextField extends StatefulWidget {
  const EptTextField({
    super.key,
    required this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onTap, // handle tap events for DatePicker
    this.suffixIcon, 
  });

  final TextEditingController controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final VoidCallback? onTap; // Callback for when the field is tapped (e.g., date picker)
  final Widget? suffixIcon; 

  @override
  _EptTextFieldState createState() => _EptTextFieldState();
}

class _EptTextFieldState extends State<EptTextField> {
  late bool _secureText;

  @override
  void initState() {
    super.initState();
    _secureText = widget.obscureText; // Initialize with provided obscureText value
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: TextFormField(
        controller: widget.controller,
        obscureText: _secureText,
        keyboardType: widget.keyboardType,
        validator: widget.validator,
        decoration: InputDecoration(
          fillColor: EPTColors.greyLight,
          filled: true,
          suffixIcon: widget.suffixIcon ??
              (widget.obscureText // Only show the toggle if it's a password field
              ? IconButton(
                  icon: Icon(_secureText ? Icons.visibility_off : Icons.visibility),
                  onPressed: () {
                    setState(() {
                      _secureText = !_secureText; // Toggle visibility
                    });
                  },
                )
              : null),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: EPTColors.primary),
          ),
        ),
      ),
    );
  }
}



