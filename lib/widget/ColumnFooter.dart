import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_auth_web/blocs/Expense_bloc.dart';
import 'package:flutter_auth_web/healper/FontName.dart';
import 'package:flutter_auth_web/healper/PrefsName.dart';
import 'package:flutter_auth_web/healper/helper.dart';
import 'package:flutter_auth_web/healper/myColor.dart';
import 'package:flutter_auth_web/healper/mystyles.dart';
import 'package:flutter_auth_web/healper/sharedpref.dart';

class ColumnFooter extends StatefulWidget {
  String total;
  final VoidCallback _callbackAdd;

  ColumnFooter({
    @required VoidCallback callbackAdd,
    @required String total,
  })  : this.total = total,
        _callbackAdd = callbackAdd;

  @override
  _ColumnFooterState createState() => _ColumnFooterState();
}

class _ColumnFooterState extends State<ColumnFooter> {

  static final _textExpensetitle = TextEditingController();
  static final _textExpenseAmount= TextEditingController();
  static bool _validExpensetitle = false,
      _validExpenseAmount = false,
      _validExpenseAmount1 = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 50,
      color: Colors.black26,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: FlatButton(
              padding: const EdgeInsets.only(right: 5),
              hoverColor: Colors.transparent,
              disabledColor: Colors.transparent,
              onPressed: () {
                addExpenceDialog();
              },
              child: Text('Add Expense', style: MyStyles.TitleStyleBold),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: FlatButton(
              padding: const EdgeInsets.only(right: 5),
              hoverColor: Colors.transparent,
              disabledColor: Colors.transparent,
              onPressed: () {
               blocExpense.CallDeleteAllExpense(Prefs.getString(PrefsName.user_authid));
              },
              child: Text('Delete All', style: TextStyle(
                fontFamily: FontName.Poppins,
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.red,
              )),
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    "Total :",
                    style: MyStyles.TitleStyleSemibold,
                  ),
                ),
                StreamBuilder(
                    stream: blocExpense.updateExpense,
                    builder: (_, snapshot) {
                      if (snapshot.hasData) {
                        return  Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            snapshot.data.toString(),
                            style: MyStyles.TitleStyleSemibold,
                          ),
                        );
                      }
                      return  Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          "000",
                          style: MyStyles.TitleStyleSemibold,
                        ),
                      );
                    })
              ],
            ),
          )
        ],
      ),
    );
  }

  void addExpenceDialog(){
    showDialog(
      barrierColor: Colors.black26,
      context: context,
      useSafeArea: true,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return Align(
            alignment: Alignment(0, 0),
            child: Material(
              color: Colors.transparent,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: 300,
                    maxWidth: 500,
                    minHeight: 320,
                    maxHeight: 350,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.white, width: 1.0),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                        color: Colors.white),
                    padding: EdgeInsets.all(30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Add Expense',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: myColor.title,
                              fontWeight: FontWeight.w700,
                              fontFamily: FontName.Poppins,
                              fontSize: 20),
                        ),
                        new SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: <Widget>[
                            new Container(
                              width: 70,
                              child: Text(
                                "Title :",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                            ),
                            new Expanded(
                              child: TextField(
                                controller: _textExpensetitle,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Enter Title',
                                    errorText:
                                    _validExpensetitle
                                        ? "Title can't be empty"
                                        : null,
                                    isDense: true,
                                    contentPadding:
                                    EdgeInsets.all(12),
                                    fillColor: myColor.white,
                                    filled: true),
                                style: TextStyle(
                                    fontSize: 13.0,
                                    color: Colors.black),
                              ),
                            )
                          ],
                        ),
                        new SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: <Widget>[
                            new Container(
                              width: 70,
                              child: Text(
                                "Amount :",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                            ),
                            new Expanded(
                              child: TextField(
                                controller: _textExpenseAmount,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Enter Amount',
                                    errorText: _validExpenseAmount1
                                        ? "Enter valid amount"
                                        : _validExpenseAmount
                                        ? "Amount can't be empty"
                                        : null,
                                    isDense: true,
                                    contentPadding:
                                    EdgeInsets.all(12),
                                    fillColor: myColor.white,
                                    filled: true),
                                style: TextStyle(
                                    fontSize: 13.0,
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                        new SizedBox(
                          height: 30,
                        ),
                        new Row(
                          children: <Widget>[
                            new Expanded(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    _validExpensetitle = false;
                                    _validExpenseAmount1 = false;
                                    _validExpenseAmount = false;
                                    _textExpensetitle
                                        .clear();
                                    _textExpenseAmount
                                        .clear();
                                    Navigator.of(context).pop();
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.all(10.0),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5),
                                      ),
                                      color: Colors.redAccent),
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(
                                      color: myColor.white,
                                      fontFamily: FontName.Poppins,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            new SizedBox(
                              width: 30,
                            ),
                            new Expanded(
                              child: InkWell(
                                onTap: () async {
                                  print("Helllllo  Dailog");

                                  String title = _textExpensetitle.text;
                                  String amount = _textExpenseAmount.text;

                                  if (title.isEmpty) {
                                    _validExpensetitle = true;
                                    setState(() {});
                                  } else if (amount.isEmpty) {
                                    _validExpensetitle = false;
                                    _validExpenseAmount = true;
                                    setState(() {});
                                  }
                                  else if (Helper.ValidAmount(amount) !=
                                      true) {
                                    _validExpensetitle = false;
                                    _validExpenseAmount = false;
                                    _validExpenseAmount1 = true;
                                    setState(() {});
                                  } else {

                                    await blocExpense.CallAddExpense(title,amount,Prefs.getString(PrefsName.user_authid));

                                    _validExpensetitle = false;
                                    _validExpenseAmount1 = false;
                                    _validExpenseAmount = false;
                                    _textExpensetitle
                                        .clear();
                                    _textExpenseAmount
                                        .clear();

                                    Navigator.of(context).pop();

                                    widget._callbackAdd;
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.all(10.0),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5),
                                      ),
                                      color: myColor.first_color
                                  ),
                                  child: Text(
                                    "Submit",
                                    style: TextStyle(
                                      color: myColor.white,
                                      fontFamily: FontName.Poppins,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
      },
    );
  }
}
