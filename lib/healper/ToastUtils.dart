import 'dart:async';

import 'package:flutter/material.dart';

import 'ToastMessageAnimation.dart';
import 'helper.dart';

class ToastUtils {
  static Timer toastTimer;
  static OverlayEntry _overlayEntry;

  static void showCustomToast(BuildContext context, String message, bool flag) {

    if (toastTimer == null || !toastTimer.isActive) {
      _overlayEntry = createOverlayEntry(context, message, flag);
      Overlay.of(context).insert(_overlayEntry);
      toastTimer = Timer(Duration(seconds: 2), () {
        if (_overlayEntry != null) {
          _overlayEntry.remove();
        }
      });
    }
  }

  static OverlayEntry createOverlayEntry(
      BuildContext context, String message, bool flag) {
    final textStyle = TextStyle(fontSize: 18, color: Color(0xFFFFFFFF));

    final Size txtSize = Helper.textSize(message, textStyle);

    double widthmsg = txtSize.width + 80;

    return OverlayEntry(
        builder: (context) => Container(
              margin: EdgeInsets.only(bottom: 100),
              alignment: Alignment.bottomCenter,
              width: widthmsg,
              height: 50,
              child: ToastMessageAnimation(Material(
                elevation: 10.0,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: 50,
                  width: widthmsg,
                  padding:
                      EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                    color: flag ? Colors.lightGreen : Colors.redAccent,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.white,
                      width: 3,
                    ),
                  ),
                  child: Row(
                    children: [
                      flag
                          ? Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(left: 10),
                              width: 30,
                              height: 30,
                              child: Image.asset(
                                "images/success.png",
                                width: 20,
                                height: 20,
                              ),
                            )
                          : Container(
                              alignment: Alignment.center,
                        margin: EdgeInsets.only(left: 10),
                              width: 30,
                              height: 30,
                              child: Image.asset(
                                "images/error.png",
                                width: 25,
                                height: 25,
                              ),
                            ),

                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          message,
                          textAlign: TextAlign.start,
                          softWrap: true,
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xFFFFFFFF),
                          ),
                        ),
                      )
                    ],
                  ),

                  /* Align(
                      alignment: Alignment.center,
                      child: Text(
                        message,
                        textAlign: TextAlign.center,
                        softWrap: true,
                        style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFFFFFFFF),
                        ),
                      ),
                    )*/
                ),
              )),
            ));
  }
}
