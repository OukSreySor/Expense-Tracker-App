import 'package:flutter/material.dart';

///
/// App colors
///
class EPTColors {
  static Color primary            = const Color(0xFF9C252B);

  static Color backgroundAccent   = const Color(0xFFEDEDED);
 
  static Color neutralDark        = const Color(0xFF054752);
  static Color neutral            = const Color(0xFF3d5c62);
  static Color neutralLight       = const Color(0xFF708c91);
  static Color neutralLighter     = const Color(0xFF92A7AB);

  static Color greyLight          = const Color(0xFFE2E2E2);
  
  static Color white              = Colors.white;

  static Color get backGroundColor { 
    return EPTColors.primary;
  }

  static Color get textNormal {
    return EPTColors.neutralDark;
  }

  static Color get textLight {
    return EPTColors.neutralLight;
  }

  static Color get iconNormal {
    return EPTColors.neutral;
  }

  static Color get iconLight {
    return EPTColors.neutralLighter;
  }

  static Color get disabled {
    return EPTColors.greyLight;
  }
}
  
///
/// App text styles
///
class EPTTextStyles {
  static TextStyle heading = TextStyle(fontSize: 36, fontWeight: FontWeight.bold);

  static TextStyle title =  TextStyle(fontSize: 20, fontWeight: FontWeight.w400);

  static TextStyle body =  TextStyle(fontSize: 15, fontWeight: FontWeight.w400);

  static TextStyle label =  TextStyle(fontSize: 12, fontWeight: FontWeight.w400);

  static TextStyle button =  TextStyle(fontSize: 14, fontWeight: FontWeight.w500);
}



///
/// App spacings, in pixels
/// 
///
class EPTSpacings {
  static const double xs = 8;
  static const double s = 12;
  static const double m = 16; 
  static const double l = 24; 
  static const double xl = 32; 
  static const double xxl = 50; 

  static const double radius = 16; 
  static const double radiusLarge = 24; 
}


class EPTSize {
  static const double icon = 24;
}

///
/// App Theme
///
ThemeData appTheme =  ThemeData(
  fontFamily: 'Roboto',
  scaffoldBackgroundColor: Colors.white,
);
 