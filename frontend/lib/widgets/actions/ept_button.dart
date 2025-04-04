import 'package:flutter/material.dart';

import '../../theme/theme.dart';

enum ButtonType { primary, secondary }

///
/// Button rendering for the whole application
///
class EptButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonType type;
  final IconData? icon;

  const EptButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.type = ButtonType.primary,
      this.icon});

  @override
  Widget build(BuildContext context) {

    Color backgroundColor =
        type == ButtonType.primary ? EPTColors.primary : EPTColors.white;

    BorderSide border = type == ButtonType.primary
        ? BorderSide.none
        : BorderSide(color: EPTColors.greyLight, width: 2);

    Color textColor =
        type == ButtonType.primary ? EPTColors.white : EPTColors.primary;
        
    Color iconColor =
        type == ButtonType.primary ? EPTColors.white : EPTColors.primary;


  	// Create the button icon - if any
    List<Widget> children = [];
    if (icon != null) {
      children.add(Icon(icon, size: 20, color: iconColor,));
      children.add(SizedBox(width: EPTSpacings.s));
    }

    // Create the button text
    Text buttonText =
        Text(text, style: EPTTextStyles.button.copyWith(color: textColor));

    children.add(buttonText);

    return SizedBox(
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor,
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(EPTSpacings.radius),
          ),
          side: border,
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: children,
        ),
      ),
    );
  }
}