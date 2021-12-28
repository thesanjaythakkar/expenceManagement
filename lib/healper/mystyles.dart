import 'package:flutter/material.dart';
import 'package:flutter_auth_web/healper/myColor.dart';
import 'package:hexcolor/hexcolor.dart';


import 'FontName.dart';

class MyStyles {

  static final textAppbar = TextStyle(
      color: Colors.white,
      fontFamily: FontName.Poppins,
      fontWeight: FontWeight.w400,
      fontSize: 13
  );

  static final textDrawerMenu = TextStyle(
      color: Colors.black54,
      fontSize: 13,
      fontFamily: FontName.Poppins,
      fontWeight: FontWeight.w500
  );

  static final TitleStyleBold = TextStyle(
    fontFamily: FontName.Poppins,
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: myColor.black,
  );

  static final TitleStyleSemibold = TextStyle(
    fontFamily: FontName.Poppins,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: myColor.black,
  );


  static final textCompnayAddEdit = TextStyle(
      color: Colors.black,
      fontFamily: FontName.Poppins,
      fontWeight: FontWeight.w400,
      fontSize: 13
  );


  static final textlabeDepartAddEdit = TextStyle(
      fontFamily: FontName.Poppins,
      fontWeight: FontWeight.w300,
      fontSize: 13
  );

  static Color _hexToColor(String code) {
    return Color(int.parse(code.substring(0, 6), radix: 16) + 0xFF000000);
  }

  static final textdropdownstyle =   TextStyle(
      color: HexColor("#293F52"),
      fontWeight: FontWeight.w400,
      fontFamily: FontName.Poppins,
      fontSize: 13)
  ;

}
