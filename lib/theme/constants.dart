// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

//? Define the primary color
const cl_PrimaryColor = Color(0xFF113375);
const cl_SecondaryColor = Color(0xFFD8E7EC);
const cl_ThirdColor = Colors.white;
const cl_TextColor = Color(0xFF333333);
const cl_PlaceholderColor = Color(0xFF828282);
const cl_ItemBackgroundColor = Color.fromARGB(110, 255, 255, 255);
const cl_ItemBackgroundGridColor = Color.fromARGB(136, 255, 255, 255);
const cl_defaultMode = Color(0xFF002060);
const LinearGradient u_BackgroundScaffold = LinearGradient(
  colors: [
    Color(0xFF002060),
    Color(0xFF4C74BD),
    Color(0xFFBCDAFF),
  ],
  stops: [0.0, 0.5, 1.0],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);

//? Define the Night Mode color
const cl_PrimaryColor_Mode = Color(0xFF83B4FF);
const cl_SecondaryColor_Mode = Color(0xFF2D324B);
const cl_ThirdColor_Mode_87 = Color(0xDEFFFFFF);
const cl_TextColor_Mode_60 = Color(0x99FFFFFF);
const cl_PlaceholderColor_Mode_38 = Color(0x61FFFFFF);
const cl_ItemBackgroundColor_Mode_87 = Color(0xDE18191E);
const cl_ContainerBackgroundColor_Mode = Color(0xFF0B192C);
const cl_darkMode = Color(0xFF202328);
const cl_BGIconDarkMode = Color(0xFF789DBC);
const cl_Background_Modal_Mode = Color(0XFF413E47);
const cl_DefaultDark_Mode = Color(0XFF121212);

//? Define the rounded corner radii
const double rd_FullRounded = 50.0;
const double rd_LargeRounded = 20.0;
const double rd_MediumRounded = 16.0;
const double rd_SmallRounded = 8.0;

//? Define the Box Shadow
const BoxShadow sd_BoxShadow = BoxShadow(
  color: Color.fromARGB(26, 0, 0, 0),
  spreadRadius: 0,
  blurRadius: 4.0,
  offset: Offset(0.0, 4.0),
);

const BoxShadow sd_BoxShadowMode = BoxShadow(
  color: Color.fromARGB(16, 0, 0, 0),
  spreadRadius: 0,
  blurRadius: 1.0,
  offset: Offset(0.0, 1.0),
);

//? Define the font family
const ft_Eng = 'font_Poppins';
const ft_Khmer = 'Mool1';
const ft_Khmer_cont = 'Battambang';

//? sizedBox

const SdH_SizeBox_S = SizedBox(height: 8.0);
const SdH_SizeBox_M = SizedBox(height: 16.0);
const SdH_SizeBox_L = SizedBox(height: 20.0);
const SdH_SizeBox_XL = SizedBox(height: 26.0);

const SdW_SizeBox_S = SizedBox(width: 8.0);
const SdW_SizeBox_M = SizedBox(width: 16.0);
const SdW_SizeBox_L = SizedBox(width: 20.0);
const SdW_SizeBox_XL = SizedBox(width: 26.0);

//? for switch color
const BoxDecoration defaultBackground =
    BoxDecoration(gradient: u_BackgroundScaffold);

const BoxDecoration switchBackground =
    BoxDecoration(color: cl_DefaultDark_Mode);
