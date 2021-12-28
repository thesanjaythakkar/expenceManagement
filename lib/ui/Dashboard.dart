import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_auth_web/blocs/Expense_bloc.dart';
import 'package:flutter_auth_web/healper/FontName.dart';
import 'package:flutter_auth_web/healper/PrefsName.dart';
import 'package:flutter_auth_web/healper/helper.dart';
import 'package:flutter_auth_web/healper/myColor.dart';
import 'package:flutter_auth_web/healper/sharedpref.dart';
import 'package:flutter_auth_web/models/Expense.dart';
import 'package:flutter_auth_web/widget/ColumnCenter.dart';
import 'package:flutter_auth_web/widget/ColumnFooter.dart';
import 'package:flutter_auth_web/widget/ColumnHeader.dart';


class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<Expense> litems = new List();
  int currentpage = 1;


  @override
  void initState() {
    Prefs.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {},
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            margin: EdgeInsets.all(30),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(3)),
                //color: Hexcolor("#16C395"),
                border: Border.all(color: Colors.black38, width: 2)),
            child: Container(
              child: Column(
                children: [
                  ColumnHeader(),
                  SizedBox(
                    height: 2,
                    child: Container(color: Colors.black38),
                  ),
                  ColumnCenter(),
                  SizedBox(
                    height: 2,
                    child: Container(color: Colors.black38),
                  ),
                  ColumnFooter(
                    callbackAdd: () {
                    },
                    total: '000',
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget ColumnCenter() {
    blocExpense.CallAllExpense(Prefs.getString(PrefsName.user_authid));
    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - 160,
          child: StreamBuilder(
                  stream: blocExpense.fetchExpense,
                  builder: (_, snapshot) {
                    if (snapshot.hasData) {
                      litems = new List();
                      litems = snapshot.data;
                      return ListviewBuid(litems);
                    }
                    return Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height - 160,
                        margin: EdgeInsets.only(
                            top: 5, bottom: 5, left: 50, right: 50),
                        child: Center(child: new CircularProgressIndicator()),
                      ),
                    );
                  })

        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
