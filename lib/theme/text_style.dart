import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:useaapp_version_2/theme/constants.dart';

/* 
 * This is the main theme for the app. It includes all the colors, fonts, and typography
 * configurations.
 *
 * To customize this theme, you can copy the entire object and modify the values as needed.
 * Make sure to import the required packages and fonts before using this theme.



*/

// define style for page routes
ThemeData buildThemeData() {
  return ThemeData(
    primarySwatch: Colors.blue,
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        fontSize: 14.sp,
        color: Colors.black,
      ),
    ),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: SlidePageTransitionsBuilder(),
        TargetPlatform.iOS: SlidePageTransitionsBuilder(),
      },
    ),
  );
}

ThemeData buildDarkThemeData() {
  return ThemeData.dark().copyWith(
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        fontSize: 14.sp,
        color: cl_TextColor,
      ),
    ),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: SlidePageTransitionsBuilder(),
        TargetPlatform.iOS: SlidePageTransitionsBuilder(),
      },
    ),
  );
}

class SlidePageTransitionsBuilder extends PageTransitionsBuilder {
  const SlidePageTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    const begin = Offset(1.0, 0.0); // Slide from right to left
    const end = Offset.zero;
    const curve = Curves.easeInOut;

    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

    return SlideTransition(
      position: animation.drive(tween),
      child: child,
    );
  }
}

// ! ============== Title Theme ==============

// Title Large (kh: 18, en: 17)
TextStyle getTitleLargeTextStyle() {
  var locale = Get.locale?.languageCode;
  double fontSize;
  if (locale == 'km') {
    fontSize = 18.sp;
    return TextStyle(
      fontFamily: ft_Khmer_cont,
      fontWeight: FontWeight.bold,
      fontSize: fontSize.sp,
      color: cl_ThirdColor,
    );
  } else {
    fontSize = 17.sp;
    return TextStyle(
      fontFamily: ft_Eng,
      fontWeight: FontWeight.bold,
      fontSize: fontSize.sp,
      color: cl_ThirdColor,
    );
  }
}

// Title Medium (kh: 16, en: 15)
TextStyle getTitleMediumTextStyle() {
  var locale = Get.locale?.languageCode;
  double fontSize;
  if (locale == 'km') {
    fontSize = 16.sp;
    return TextStyle(
      fontFamily: ft_Khmer_cont,
      fontWeight: FontWeight.w900,
      fontSize: fontSize.sp,
      color: cl_ThirdColor,
    );
  } else {
    fontSize = 15.sp;
    return TextStyle(
      fontFamily: ft_Eng,
      fontWeight: FontWeight.bold,
      fontSize: fontSize.sp,
      color: cl_ThirdColor,
    );
  }
}

// Title Small (kh: 14, en: 13)
TextStyle getTitleSmallTextStyle() {
  var locale = Get.locale?.languageCode;
  double fontSize;
  if (locale == 'km') {
    fontSize = 16.sp;
    return TextStyle(
      fontFamily: ft_Khmer_cont,
      fontWeight: FontWeight.w700,
      fontSize: fontSize.sp,
      color: cl_ThirdColor,
    );
  } else {
    fontSize = 13.sp;
    return TextStyle(
      fontFamily: ft_Eng,
      fontWeight: FontWeight.w600,
      fontSize: fontSize.sp,
      color: cl_ThirdColor,
    );
  }
}

// Title Large & Primary Color (kh: 18, en: 18)
TextStyle getTitleLargePrimaryColorTextStyle() {
  var locale = Get.locale?.languageCode;
  double fontSize;
  if (locale == 'km') {
    fontSize = 18.sp;
    return TextStyle(
      fontFamily: ft_Khmer_cont,
      fontWeight: FontWeight.w700,
      fontSize: fontSize.sp,
      color: cl_PrimaryColor,
    );
  } else {
    fontSize = 16.sp;
    return TextStyle(
      fontFamily: ft_Eng,
      fontWeight: FontWeight.w600,
      fontSize: fontSize.sp,
      color: cl_PrimaryColor,
    );
  }
}

// Title Medium & Primary Color (kh: 16, en: 16)
TextStyle getTitleMediumPrimaryColorTextStyle() {
  var locale = Get.locale?.languageCode;
  double fontSize;
  if (locale == 'km') {
    fontSize = 17.sp;
    return TextStyle(
      fontFamily: ft_Khmer_cont,
      fontWeight: FontWeight.w700,
      fontSize: fontSize.sp,
      color: cl_PrimaryColor,
    );
  } else {
    fontSize = 16.sp;
    return TextStyle(
      fontFamily: ft_Eng,
      fontWeight: FontWeight.w600,
      fontSize: fontSize.sp,
      color: cl_PrimaryColor,
    );
  }
}

// Title Small & Primary Color (kh: 14, en: 14)
TextStyle getTitleSmallPrimaryColorTextStyle() {
  var locale = Get.locale?.languageCode;
  double fontSize;
  if (locale == 'km') {
    fontSize = 15.sp;
    return TextStyle(
      fontFamily: ft_Khmer_cont,
      fontWeight: FontWeight.w700,
      fontSize: fontSize.sp,
      color: cl_PrimaryColor,
    );
  } else {
    fontSize = 14.sp;
    return TextStyle(
      fontFamily: ft_Eng,
      fontWeight: FontWeight.w600,
      fontSize: fontSize.sp,
      color: cl_PrimaryColor,
    );
  }
}

// Title Khmer Mool 1 & Primary Color (kh: 16, en: 16)
TextStyle getTitleKhmerMoolPrimaryColorTextStyle() {
  var locale = Get.locale?.languageCode;
  double fontSize;
  if (locale == 'km') {
    fontSize = 16.sp;
    return TextStyle(
      fontFamily: ft_Khmer,
      fontSize: fontSize.sp,
      color: cl_PrimaryColor,
      letterSpacing: 0.0,
      height: 1.6,
    );
  } else {
    fontSize = 16.sp;
    return TextStyle(
      fontFamily: ft_Eng,
      fontWeight: FontWeight.bold,
      fontSize: fontSize.sp,
      color: cl_PrimaryColor,
    );
  }
}

// ! ============== Body Theme ==============

// Body Large (kh: 14, en: 14)
TextStyle getBodyLargeTextStyle() {
  var locale = Get.locale?.languageCode;
  double fontSize;
  if (locale == 'km') {
    fontSize = 15.sp;
    return TextStyle(
      fontFamily: ft_Khmer_cont,
      fontWeight: FontWeight.w600,
      fontSize: fontSize.sp,
      color: cl_TextColor,
    );
  } else {
    fontSize = 14.sp;
    return TextStyle(
      fontFamily: ft_Eng,
      fontWeight: FontWeight.w400,
      fontSize: fontSize.sp,
      color: cl_TextColor,
    );
  }
}

// Body Medium (kh: 12, en: 12)
TextStyle getBodyMediumTextStyle() {
  var locale = Get.locale?.languageCode;
  double fontSize;
  if (locale == 'km') {
    fontSize = 12.sp;
    return TextStyle(
      fontFamily: ft_Khmer_cont,
      fontWeight: FontWeight.w500,
      fontSize: fontSize.sp,
      color: cl_TextColor,
    );
  } else {
    fontSize = 12.sp;
    return TextStyle(
      fontFamily: ft_Eng,
      fontWeight: FontWeight.w500,
      fontSize: fontSize.sp,
      color: cl_TextColor,
    );
  }
}

// Body MediumThirdColor & White Color (kh: 12, en: 12)
TextStyle getBodyMediumThirdColorTextStyle() {
  var locale = Get.locale?.languageCode;
  double fontSize;
  if (locale == 'km') {
    fontSize = 12;
    return TextStyle(
      fontFamily: ft_Khmer_cont,
      fontWeight: FontWeight.w500,
      fontSize: fontSize.sp,
      color: cl_ThirdColor,
    );
  } else {
    fontSize = 12;
    return TextStyle(
      fontFamily: ft_Eng,
      fontWeight: FontWeight.w500,
      fontSize: fontSize.sp,
      color: cl_ThirdColor,
    );
  }
}

// Body Small (kh: 11, en: 11)
TextStyle getBodySmallTextStyle() {
  var locale = Get.locale?.languageCode;
  double fontSize;
  if (locale == 'km') {
    fontSize = 11;
    return TextStyle(
      fontFamily: ft_Khmer_cont,
      fontWeight: FontWeight.w400,
      fontSize: fontSize.sp,
      color: cl_PlaceholderColor,
    );
  } else {
    fontSize = 11;
    return TextStyle(
      fontFamily: ft_Eng,
      fontWeight: FontWeight.w400,
      fontSize: fontSize.sp,
      color: cl_PlaceholderColor,
    );
  }
}

// ! ============== ListTile Theme ==============

// ListTile Title (kh: 16, en: 15)
TextStyle getListTileTitle() {
  var locale = Get.locale?.languageCode;
  double fontSize;
  if (locale == 'km') {
    fontSize = 16;
    return TextStyle(
      fontFamily: ft_Khmer_cont,
      fontWeight: FontWeight.w700,
      fontSize: fontSize.sp,
      color: cl_PrimaryColor,
    );
  } else {
    fontSize = 15;
    return TextStyle(
      fontFamily: ft_Eng,
      fontWeight: FontWeight.w600,
      fontSize: fontSize.sp,
      color: cl_PrimaryColor,
    );
  }
}

// ListTile Body (kh: 12, en: 12)
TextStyle getListTileBody() {
  var locale = Get.locale?.languageCode;
  double fontSize;
  if (locale == 'km') {
    fontSize = 13;
    return TextStyle(
      fontFamily: ft_Khmer_cont,
      fontWeight: FontWeight.w600,
      fontSize: fontSize.sp,
      color: cl_TextColor,
    );
  } else {
    fontSize = 12;
    return TextStyle(
      fontFamily: ft_Eng,
      fontWeight: FontWeight.w500,
      fontSize: fontSize.sp,
      color: cl_TextColor,
    );
  }
}

// ! ============== Others Custom Theme ==============

// Body Medium & White Color (kh: 12, en: 12)
TextStyle getBodyMediumCareerCenterTextStyle() {
  var locale = Get.locale?.languageCode;
  double fontSize;
  if (locale == 'km') {
    fontSize = 12;
    return TextStyle(
      fontFamily: ft_Khmer_cont,
      fontWeight: FontWeight.w500,
      fontSize: fontSize.sp,
      color: Colors.cyan[600],
    );
  } else {
    fontSize = 12;
    return TextStyle(
      fontFamily: ft_Eng,
      fontWeight: FontWeight.w500,
      fontSize: fontSize.sp,
      color: Colors.cyan[600],
    );
  }
}

// Title Small (kh: 14, en: 13)
TextStyle getTitleDegreeTextStyle() {
  var locale = Get.locale?.languageCode;
  double fontSize;
  if (locale == 'km') {
    fontSize = 17;
    return TextStyle(
      fontFamily: ft_Khmer_cont,
      fontWeight: FontWeight.w500,
      fontSize: fontSize.sp,
      color: cl_ThirdColor,
    );
  } else {
    fontSize = 13;
    return TextStyle(
      fontFamily: ft_Eng,
      fontWeight: FontWeight.w700,
      fontSize: fontSize.sp,
      color: cl_ThirdColor,
    );
  }
}
