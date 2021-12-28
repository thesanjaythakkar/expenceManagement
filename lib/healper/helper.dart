import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:email_validator/email_validator.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_auth_web/Widget/CircularLoadingWidget.dart';
import 'package:flutter_auth_web/config/app_config.dart' as config;


class Helper {
  BuildContext context;

  Helper.of(BuildContext _context) {
    this.context = _context;
  }

  // for mapping data retrieved form json array
  static getData(Map<String, dynamic> data) {
    return data['data'] ?? [];
  }

  static String getComaseparated(List<String> data) {
    String finallocations = "";

    if (data.length > 0) {
      finallocations = data.join(', ');
    }

    return finallocations;
  }

  static int getIntData(Map<String, dynamic> data) {
    return (data['data'] as int) ?? 0;
  }

  static bool getBoolData(Map<String, dynamic> data) {
    return (data['data'] as bool) ?? false;
  }

  static String getPerPageData() {
    return "100000";
  }

  static getObjectData(Map<String, dynamic> data) {
    return data['data'] ?? new Map<String, dynamic>();
  }

  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        .buffer
        .asUint8List();
  }

  static List<Icon> getStarsList(double rate, {double size = 18}) {
    var list = <Icon>[];
    list = List.generate(rate.floor(), (index) {
      return Icon(Icons.star, size: size, color: Color(0xFFFFB24D));
    });
    if (rate - rate.floor() > 0) {
      list.add(Icon(Icons.star_half, size: size, color: Color(0xFFFFB24D)));
    }
    list.addAll(
        List.generate(5 - rate.floor() - (rate - rate.floor()).ceil(), (index) {
      return Icon(Icons.star_border, size: size, color: Color(0xFFFFB24D));
    }));
    return list;
  }

  static OverlayEntry overlayLoader(context) {
    OverlayEntry loader = OverlayEntry(builder: (context) {
      final size = MediaQuery.of(context).size;
      return Positioned(
        height: size.height,
        width: size.width,
        top: 0,
        left: 0,
        child: Material(
          color: Colors.black12,
          child:
              CircularLoadingWidget(height: MediaQuery.of(context).size.height),
        ),
      );
    });
    return loader;
  }

  static SnackbarCustomMsg(BuildContext context, String msg) {
    Flushbar(
      message: msg,
      animationDuration: Duration(microseconds: 10),
      duration: Duration(seconds: 2),
      flushbarPosition: FlushbarPosition.BOTTOM,
      flushbarStyle: FlushbarStyle.GROUNDED,
    )..show(context);
  }

  static SnackbarCustom(BuildContext context, String title, String msg) {
    Flushbar(
      message: msg,
      animationDuration: Duration(microseconds: 10),
      duration: Duration(seconds: 2),
      flushbarPosition: FlushbarPosition.BOTTOM,
      flushbarStyle: FlushbarStyle.GROUNDED,
    )..show(context);
  }

  static Widget ShowCenterLoader(context) {
    return Center(
        child: CircularProgressIndicator(
            backgroundColor: config.AppColors().accentDarkColor(1)));
  }


  static hideLoader(OverlayEntry loader) {
    Timer(Duration(milliseconds: 500), () {
      try {
        loader?.remove();
      } catch (e) {}
    });
  }

  static String limitString(String text,
      {int limit = 24, String hiddenText = "..."}) {
    return text.substring(0, min<int>(limit, text.length)) +
        (text.length > limit ? hiddenText : '');
  }

  static String getCreditCardNumber(String number) {
    String result = '';
    if (number != null && number.isNotEmpty && number.length == 16) {
      result = number.substring(0, 4);
      result += ' ' + number.substring(4, 8);
      result += ' ' + number.substring(8, 12);
      result += ' ' + number.substring(12, 16);
    }
    return result;
  }

  static bool ValidEmail(String email) {
    /*  bool emailValid = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$').hasMatch(email);
    return emailValid;*/

    bool emailValid = EmailValidator.validate(email);
    return emailValid;
  }

  static bool ValidAmount(String number) {
    //bool onlynumber = RegExp(r'^[0-9]*$').hasMatch(number);
    bool onlynumber = RegExp(r'^[0-9\. ]*$').hasMatch(number);
    return onlynumber;
  }

  static bool ValidPhone(String phone) {
    bool PhoneValid = RegExp(r'^(?:[+0]9)?[0-9]{10}$').hasMatch(phone);
    return PhoneValid;
  }

  static bool ValidOnlyNumber(String number) {
    //bool onlynumber = RegExp(r'^[0-9]*$').hasMatch(number);
    bool onlynumber = RegExp(r'^[0-9()#+ ]*$').hasMatch(number);
    return onlynumber;
  }

  static bool isPasswordCompliant(String password) {
    if (password == null || password.isEmpty) {
      return false;
    }

    bool hasUppercase = password.contains(new RegExp(r'[A-Z]'));
    bool hasDigits = password.contains(new RegExp(r'[0-9]'));
    bool hasLowercase = password.contains(new RegExp(r'[a-z]'));
    bool hasSpecialCharacters =
        password.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    bool hasMinLength = password.length >= 8;

    //return hasDigits & hasUppercase & hasLowercase & hasSpecialCharacters & hasMinLength;
    return hasDigits & hasUppercase & hasSpecialCharacters & hasMinLength;
  }

  static Size textSize(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text, style: style),
        maxLines: 1,
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.size;
  }

}
