import 'dart:async';

import 'package:flutter_auth_web/models/Expense.dart';
import 'package:flutter_auth_web/models/user_model.dart';

import 'api_provider.dart';

typedef CallBack<T> = void Function(bool status, T model, String erromsg);

typedef CallBackArray = void Function(bool status,  List<Expense> expenselist, String erromsg);

class Repository {
  final apiProvider = ApiProvider();

  Future<void> Userlogin(
          String email, String password, CallBack callBack) =>
      apiProvider.UserLogin(email, password, callBack);

  Future<void> UserRegidter(
          String email, String password, CallBack callBack) =>
      apiProvider.UserRegister(email, password, callBack);

  Future<void> UserSignOut(CallBack callBack) => apiProvider.UserSignOut(callBack);

  Future<void> FetchExpense(String authid, CallBackArray callBack) =>
      apiProvider.getAllExpense(authid, callBack);

  Future<void> AddExpense(
      String title, String amount,String authid, CallBack callBack) =>
      apiProvider.AddExpense(title, amount,authid, callBack);

  Future<void> UpdateExpense(
      String title, String amount,String authid,String docid, CallBack callBack) =>
      apiProvider.UpdateExpense(title, amount,authid,docid, callBack);

  Future<void> DeleteExpense(String docid, CallBack callBack) =>
      apiProvider.DeleteExpense(docid, callBack);

  Future<void> DeleteAllExpense(String docid, CallBack callBack) =>
      apiProvider.DeleteAllExpense(docid, callBack);
}
