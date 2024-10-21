import 'package:flutter/material.dart';
import 'theme_provider/theme_utils.dart';
import 'constants.dart';

extension ThemeContext on BuildContext {
//COMMENT For light mode only

  Color get guestBGColor {
    final isDark = isDarkMode(this);
    return isDark ? cl_ThirdColor : cl_ThirdColor;
  }

  // ?================================================================
  /*


================================================================
     * Colors for Text mode.
   * NOTE: isDark ? true : false.
================================================================
      


  */

  Color get titlePrimaryColor {
    final isDark = isDarkMode(this);
    return isDark ? cl_PrimaryColor_Mode : cl_PrimaryColor;
  }

  Color get subTitlePrimaryColor {
    final isDark = isDarkMode(this);
    return isDark ? cl_ThirdColor_Mode_87 : cl_PrimaryColor;
  }

  Color get titleColor {
    final isDark = isDarkMode(this);
    return isDark ? cl_ThirdColor_Mode_87 : cl_ThirdColor;
  }

  Color get subTitleColor {
    final isDark = isDarkMode(this);
    return isDark ? cl_TextColor_Mode_60 : cl_TextColor;
  }

  Color get textDecColor {
    final isDark = isDarkMode(this);
    return isDark ? cl_PlaceholderColor_Mode_38 : cl_PlaceholderColor;
  }

  Color get titleAppBarColor {
    final isDark = isDarkMode(this);
    return isDark ? cl_ThirdColor_Mode_87 : cl_SecondaryColor;
  }

  Color get bottomColor {
    final isDark = isDarkMode(this);
    return isDark ? cl_PrimaryColor_Mode : cl_PrimaryColor;
  }

  Color get textDateColor {
    final isDark = isDarkMode(this);
    return isDark ? cl_PlaceholderColor_Mode_38 : cl_PlaceholderColor;
  }

  Color get textNextMonthDateColor {
    final isDark = isDarkMode(this);
    return isDark
        ? cl_PlaceholderColor_Mode_38.withOpacity(0.1)
        : Colors.grey.shade100;
  }

  Color get cardTextColor {
    final isDark = isDarkMode(this);
    return isDark ? cl_ThirdColor_Mode_87 : cl_TextColor;
  }

// ?================================================================

  /*


================================================================
     * Colors for background mode.
   * NOTE: isDark ? true : false.
================================================================



  */
  // BG Container
  Color get colorDarkMode {
    final isDark = isDarkMode(this);
    return isDark ? cl_darkMode : cl_ItemBackgroundColor;
  }

  Color get appBarColor {
    final isDark = isDarkMode(this);
    return isDark ? cl_darkMode : cl_defaultMode;
  }

  Color get bottomBGColor {
    final isDark = isDarkMode(this);
    return isDark ? cl_darkMode : cl_ThirdColor;
  }

// colorWhiteDarkMode
  Color get bgThirdDarkMode {
    final isDark = isDarkMode(this);
    return isDark ? cl_darkMode : cl_ThirdColor;
  }

  Color get secondaryColoDarkMode {
    final isDark = isDarkMode(this);
    return isDark ? cl_SecondaryColor_Mode : cl_SecondaryColor;
  }

  Color get secondaryForTabBarColoDarkMode {
    final isDark = isDarkMode(this);
    return isDark
        ? cl_SecondaryColor_Mode
        : const Color(0xFFD9D9D9).withOpacity(0.7);
  }

  Color get colorCountAttendDarkMode {
    final isDark = isDarkMode(this);
    return isDark ? cl_DefaultDark_Mode : cl_ThirdColor;
  }

  Color get colorSecDarkMode {
    final isDark = isDarkMode(this);
    return isDark ? cl_darkMode : cl_SecondaryColor;
  }

  Color get activeSelectScheduleDarkMode {
    final isDark = isDarkMode(this);
    return isDark ? cl_PrimaryColor_Mode : cl_PrimaryColor;
  }

  Color get sundayScheduleDarkMode {
    final isDark = isDarkMode(this);
    return isDark ? const Color(0xFFA04747) : const Color(0xFFFFD4D4);
  }

// cardHeaderDarkMode
  Color get listViewDarkMode {
    final isDark = isDarkMode(this);
    return isDark ? cl_SecondaryColor_Mode : cl_SecondaryColor;
  }

  Color get scoreDarkMode {
    final isDark = isDarkMode(this);
    return isDark
        ? const Color(0xFF3961C7).withOpacity(0.3)
        : const Color(0xFF3961C7);
  }

  Color get finalScoreDarkMode {
    final isDark = isDarkMode(this);
    return isDark
        ? const Color(0xFF39AEC7).withOpacity(0.3)
        : const Color(0xFF39AEC7);
  }

  Color get attendLateMode {
    final isDark = isDarkMode(this);
    return isDark ? const Color(0xFF4477CE) : const Color(0xFF003EDD);
  }

  Color get attendPresentMode {
    final isDark = isDarkMode(this);
    return isDark ? const Color(0xFF4ECCA3) : const Color(0xFF4DC739);
  }

  Color get attendPermissionMode {
    final isDark = isDarkMode(this);
    return isDark ? const Color(0xFFFFA069) : const Color(0xFFEA6930);
  }

  Color get attendAbsentMode {
    final isDark = isDarkMode(this);
    return isDark ? const Color(0xFFED6663) : const Color(0xFFC61B12);
  }

// ?================================================================

  /*


================================================================
     * Colors for Icon mode.
   * NOTE: isDark ? true : false.
================================================================



  */
  Color get iconColor {
    final isDark = isDarkMode(this);
    return isDark ? cl_BGIconDarkMode : cl_SecondaryColor;
  }
}

// ?================================================================

/*



================================================================
     * Colors for Icon Extension mode.
   * NOTE: isDark ? true : false.
================================================================
      


  */
extension ColorExtensions on BuildContext {
  Color get bgIconColor {
    final isDark = isDarkMode(this);
    return isDark ? cl_BGIconDarkMode : cl_SecondaryColor;
  }
}
