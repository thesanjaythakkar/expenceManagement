import 'package:flutter_auth_web/models/Expense.dart';
import 'package:rxdart/rxdart.dart';

import '../resources/repository.dart';

class ExpenseBloc {
  List<Expense> myexpenselist;
  final _repository = Repository();
  final _updateExpense = PublishSubject<double>();
  final _userExpense = PublishSubject<Expense>();
  final _fetchExpense = PublishSubject<List<Expense>>();

  Observable<Expense> get userExpense => _userExpense.stream;

  Observable<double> get updateExpense => _updateExpense.stream;

  Observable<List<Expense>> get fetchExpense => _fetchExpense.stream;

  CallAddExpense(String title, String amount, String authid) async {
    await _repository.AddExpense(title, amount, authid,
        (success, usermodel, errormsg) {
      if (success) {
        myexpenselist.add(usermodel);
        var amount = myexpenselist
            .map((e) => e.expense)
            .reduce((value, element) => (value + element));
        _updateExpense.sink.add(amount);
        _fetchExpense.sink.add(myexpenselist);
      } else {
        _fetchExpense.sink.addError(errormsg);
      }
    });
  }

  CallUpdateExpense(String title, String amount, String authid, String docid,
      int index) async {
    await _repository.UpdateExpense(title, amount, authid, docid,
        (success, usermodel, errormsg) {
      if (success) {
        myexpenselist.insert(index, usermodel);
        var amount = myexpenselist
            .map((e) => e.expense)
            .reduce((value, element) => (value + element));
        _updateExpense.sink.add(amount);
        _fetchExpense.sink.add(myexpenselist);
      } else {
        _fetchExpense.sink.addError(errormsg);
      }
    });
  }

  CallDeleteExpense(String docid, int index) async {
    await _repository.DeleteExpense(docid, (success, usermodel, errormsg) {
      if (success) {
        myexpenselist.removeAt(index);
        var amount = myexpenselist
            .map((e) => e.expense)
            .reduce((value, element) => (value + element));
        _updateExpense.sink.add(amount);
        _fetchExpense.sink.add(myexpenselist);
      } else {
        _fetchExpense.sink.addError(errormsg);
      }
    });
  }

  CallDeleteAllExpense(String authid) async {
    await _repository.DeleteAllExpense(authid, (success, usermodel, errormsg) {
      if (success) {
        myexpenselist.clear();
        _updateExpense.sink.add(0);
        _fetchExpense.sink.add(myexpenselist);
      } else {
        _fetchExpense.sink.addError(errormsg);
      }
    });
  }

  CallAllExpense(String authid) async {
    myexpenselist = new List();

    await _repository.FetchExpense(authid, (success, expenselist, errormsg) {
      if (success) {
        myexpenselist.clear();
        myexpenselist.addAll(expenselist);
        var amount = myexpenselist
            .map((e) => e.expense)
            .reduce((value, element) => (value + element));
        _updateExpense.sink.add(amount);
        _fetchExpense.sink.add(expenselist);
      } else {
        _fetchExpense.sink.addError(errormsg);
      }
    });
  }

  dispose() {
    _userExpense.close();
  }
}

final blocExpense = ExpenseBloc();
