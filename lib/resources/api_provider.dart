import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_auth_web/healper/FirestoreName.dart';
import 'package:flutter_auth_web/models/Expense.dart';
import 'package:flutter_auth_web/models/user_model.dart';
import 'package:flutter_auth_web/resources/repository.dart';

class ApiProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  static final firestoreInstance = FirebaseFirestore.instance;

  Future<void> UserRegister(
      String email, String password, CallBack callBack) async {
    print(">>>>" + email);
    print(">>>>" + password);

    await Firebase.initializeApp();
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User user = userCredential.user;

      if (user != null) {
        assert(user.uid != null);
        assert(user.email != null);

        String uid = user.uid;
        String userEmail = user.email;

        UserModel userModel =
            new UserModel(id: uid, email: userEmail, password: password);
        assert(!user.isAnonymous);
        assert(await user.getIdToken() != null);

        callBack(true, userModel, "");
      }
    } on FirebaseAuthException catch (e) {
      /*if (e.code == 'user-not-found') {
        callBack(false, null, "No user found for that email.");
      } else if (e.code == 'wrong-password') {
        callBack(false, null, "Wrong password provided for that user..");
      } else {

      }*/
      callBack(false, null, e.message);
    }
  }

  Future<void> UserLogin(
      String email, String password, CallBack callBack) async {
    // Initialize Firebase
    await Firebase.initializeApp();

    print(">>>>" + email);
    print(">>>>" + password);

    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User user = userCredential.user;

      if (user != null) {
        // checking if uid or email is null
        assert(user.uid != null);
        assert(user.email != null);

        String uid = user.uid;
        String userEmail = user.email;

        UserModel userModel =
            new UserModel(id: uid, email: userEmail, password: password);
        assert(!user.isAnonymous);
        assert(await user.getIdToken() != null);

        final User currentUser = _auth.currentUser;
        assert(user.uid == currentUser.uid);
        callBack(true, userModel, "");
      }
    } on FirebaseAuthException catch (e) {
      callBack(false, null, e.message);
    }
  }

  Future<void> UserSignOut(CallBack callBack) async {
    await Firebase.initializeApp();

    try {
      await _auth.signOut();
      callBack(false, null, "SignOut");
    } on FirebaseAuthException catch (e) {
      callBack(false, null, e.message);
    }
  }

  Future<void> AddExpense(
      String title, String amount, String authid, CallBack callBack) async {
    await Firebase.initializeApp();

    DocumentReference docRef =
        await firestoreInstance.collection(FirestoreName.Expense).add({
      "title": title,
      "expense": double.parse(amount),
      "authid": authid,
    });

    Expense expense = new Expense();
    expense.docis = docRef.id.toString();
    expense.title = title.toString();
    expense.expense = double.parse(amount);
    expense.authid = authid;

    callBack(true, expense, "");

  }

  Future<void> UpdateExpense(String title, String amount, String authid,
      String documentid, CallBack callBack) async {
    await Firebase.initializeApp();

    await firestoreInstance
        .collection(FirestoreName.Expense)
        .doc(documentid)
        .update({
      "title": title,
      "expense": double.parse(amount),
      "authid": authid,
    });

    Expense expense = new Expense();
    expense.docis = documentid;
    expense.title = title.toString();
    expense.expense = double.parse(amount);
    expense.authid = authid;

    callBack(true, expense, "");
  }

  Future<void> DeleteExpense(String documentid, CallBack callBack) async {
    await Firebase.initializeApp();

    await firestoreInstance
        .collection(FirestoreName.Expense)
        .doc(documentid)
        .delete();

    callBack(true, null, "Remove");
  }

  Future<void> DeleteAllExpense(String authid, CallBackArray CallBack) async {
    QuerySnapshot qs = await firestoreInstance
        .collection(FirestoreName.Expense)
        .where("authid", isEqualTo: authid)
        .get();

    List<Expense> expenselist = new List<Expense>();

    if (qs.docs.isNotEmpty) {
      qs.docs.forEach((element) {
        element.reference.delete();
      });
      CallBack(true, expenselist, "");
    } else {
      CallBack(false, null, "datanotefound");
    }
  }


  Future<void> getAllExpense(String authid, CallBackArray CallBack) async {
    QuerySnapshot qs = await firestoreInstance
        .collection(FirestoreName.Expense)
        .where("authid", isEqualTo: authid)
        .get();

    List<Expense> expenselist = new List<Expense>();

    if (qs.docs.isNotEmpty) {
      qs.docs.forEach((element) {
        expenselist.add(new Expense(
          docis: element.id.toString(),
          title: element.data()["title"].toString(),
          expense: element.data()["expense"],
          authid: element.data()["authid"].toString(),
        ));
      });

      CallBack(true, expenselist, "");
    } else {
      CallBack(false, null, "datanotefound");
    }
  }
}
