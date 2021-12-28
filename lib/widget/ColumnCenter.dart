import 'dart:js';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_auth_web/blocs/Expense_bloc.dart';
import 'package:flutter_auth_web/models/Expense.dart';
import 'package:hexcolor/hexcolor.dart';


Widget ListviewBuid(List<Expense> listdata) {
  // ignore: missing_required_param
  return ListView.separated(
    separatorBuilder: (context, index) => Divider(
      color: Colors.black,
      thickness: 1,
      height: 1,
    ),
    itemCount: listdata.length,
    itemBuilder: (BuildContext ctxt, int Index) {
      return new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: _tableData(listdata[Index],Index),
      );
    },
  );
}

List<Widget> _tableData(Expense model,int Index) {
  var result = List<Widget>();
  result.add(_datavalueNumber((Index+1).toString()));
  result.add(_datavalueTitle(model.title));
  result.add(_datavalueExpense(model.expense.toString()));
  result.add(_datavalueDelete(model.docis,Index));
  return result;
}

Widget _datavalueNumber(String text) {
  return Container(
    height: 50,
    width: 100,
    //color: Colors.white,
    padding: EdgeInsets.only(left: 15),
    alignment: Alignment.centerLeft,
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 14,
          color: HexColor("#000000"),
          fontWeight: FontWeight.normal),
    ),
  );
}

Widget _datavalueTitle(String text) {
  return Expanded(
    child: Container(
      height: 50,
      //color: Colors.white,
      padding: EdgeInsets.only(left: 15),
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 14,
            color: HexColor("#000000"),
            fontWeight: FontWeight.normal),
      ),
    ),
  );
}

Widget _datavalueExpense(String text) {
  return Container(
    margin: EdgeInsets.only(right: 10),
    height: 50,
    //color: Colors.white,
    padding: EdgeInsets.only(left: 15),
    alignment: Alignment.centerLeft,
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 14,
          color: HexColor("#000000"),
          fontWeight: FontWeight.normal),
    ),
  );
}

Widget _datavalueDelete(String docid,int index) {
  return InkWell(
    onTap:() {
      blocExpense.CallDeleteExpense(docid,index);
    },
    child:  Container(
      margin: EdgeInsets.only(right: 10),
      height: 50,
      //color: Colors.white,
      padding: EdgeInsets.only(left: 15),
      alignment: Alignment.centerLeft,
      child: Text(
        "Delete",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 14,
            color: Colors.red,
            fontWeight: FontWeight.normal),
      ),
    ),
  );
}