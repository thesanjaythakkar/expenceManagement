import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hexcolor/hexcolor.dart';

Widget ColumnHeader() {
  return Container(
    height: 50,
    color: Colors.black26,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: _headerRow(),
    ),
  );
}

List<Widget> _headerRow() {
  var result = List<Widget>();
  result.add(_headerNumber("Number"));
  result.add(_headerTitle("Title"));
  result.add(_headerExpense("Expense"));
  result.add(_headerDelete("Delete"));
  return result;
}

Widget _headerNumber(String text) {
  return Container(
    height: 50,
    width: 100,
    padding: EdgeInsets.only(left: 15),
    alignment: Alignment.centerLeft,
    child: Text(
      text,
      textAlign: TextAlign.start,
      style: TextStyle(
          fontSize: 16,
          color: HexColor("#000000"),
          fontWeight: FontWeight.bold),
    ),
  );
}

Widget _headerTitle(String text) {
  return Expanded(
    child: Container(
      height: 50,
      padding: EdgeInsets.only(left: 15),
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        textAlign: TextAlign.start,
        style: TextStyle(
            fontSize: 16,
            color: HexColor("#000000"),
            fontWeight: FontWeight.bold),
      ),
    ),
  );
}

Widget _headerExpense(String text) {
  return Container(
    margin: EdgeInsets.only(right: 10),
    height: 50,
    padding: EdgeInsets.only(left: 15),
    alignment: Alignment.centerLeft,
    child: Text(
      text,
      textAlign: TextAlign.start,
      style: TextStyle(
          fontSize: 16,
          color: HexColor("#000000"),
          fontWeight: FontWeight.bold),
    ),
  );
}

Widget _headerDelete(String text) {
  return Container(
    margin: EdgeInsets.only(right: 10),
    height: 50,
    padding: EdgeInsets.only(left: 15),
    alignment: Alignment.centerLeft,
    child: Text(
      text,
      textAlign: TextAlign.start,
      style: TextStyle(
          fontSize: 16,
          color: HexColor("#000000"),
          fontWeight: FontWeight.bold),
    ),
  );
}
