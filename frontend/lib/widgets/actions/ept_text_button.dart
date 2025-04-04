import 'package:flutter/material.dart';

import '../../theme/theme.dart';

///
/// Text Button rendering for the whole application
///
class EptTextButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const EptTextButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
            onTap: onPressed,
            child: Text(text,
                style: EPTTextStyles.button.copyWith(color: EPTColors.primary))),
      ),
    );
  }
}