import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_auth_web/blocs/login_bloc.dart';
import 'package:flutter_auth_web/healper/FontName.dart';
import 'package:flutter_auth_web/healper/PrefsName.dart';
import 'package:flutter_auth_web/healper/ToastUtils.dart';
import 'package:flutter_auth_web/healper/helper.dart';
import 'package:flutter_auth_web/healper/myColor.dart';
import 'package:flutter_auth_web/healper/mystyles.dart';
import 'package:flutter_auth_web/healper/sharedpref.dart';
import 'package:hexcolor/hexcolor.dart';

import '../RouteNames.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _textloginEmail = TextEditingController();
  final _textloginPass = TextEditingController();
  bool _validloginEmail = false,
      _validloginPass = false,
      passwordVisible = true;

  final FocusNode fnemail = FocusNode();
  final FocusNode fnpass = FocusNode();

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
            color: HexColor("#F0F1F6"),
            height: MediaQuery.of(context).size.width < 900
                ? MediaQuery.of(context).size.height
                : MediaQuery.of(context).size.height / 1.5,
            width: MediaQuery.of(context).size.width < 900
                ? MediaQuery.of(context).size.width
                : MediaQuery.of(context).size.width / 3,
            child: Container(
              padding: EdgeInsets.all(30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  color: Colors.white),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Login Now",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontFamily: FontName.Poppins,
                          fontWeight: FontWeight.w700),
                    ),
                    _emailPasswordWidget(),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                          color: myColor.first_color),
                      child: FlatButton(
                        padding: const EdgeInsets.only(right: 5),
                        hoverColor: Colors.transparent,
                        disabledColor: Colors.transparent,
                        onPressed: () {
                          submitSignIn();
                        },
                        child: Text(
                          'Sign IN',
                          style: TextStyle(
                              color: myColor.white,
                              fontFamily: FontName.Poppins,
                              fontWeight: FontWeight.w600,
                              fontSize: 13),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                          color: myColor.first_color),
                      child: FlatButton(
                        padding: const EdgeInsets.only(right: 5),
                        hoverColor: Colors.transparent,
                        disabledColor: Colors.transparent,
                        onPressed: () {
                          submitSignUp();
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                              color: myColor.white,
                              fontFamily: FontName.Poppins,
                              fontWeight: FontWeight.w600,
                              fontSize: 13),
                        ),
                      ),
                    ),
                    StreamBuilder(
                      stream: bloclogin.userlogin,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          print(snapshot.data.email);
                          print(snapshot.data.password);
                          print(snapshot.data.id);

                          Prefs.setString(PrefsName.user_Email, snapshot.data.email);
                          Prefs.setString(PrefsName.user_Password, snapshot.data.password);
                          Prefs.setString(PrefsName.user_authid, snapshot.data.id);

                          Future.delayed(const Duration(milliseconds: 500), () {
                            navigationPage();
                          });

                          return Container(
                            height: 50,
                            child: Text("Success",style: MyStyles.TitleStyleSemibold,),
                          );
                        } else if (snapshot.hasError) {
                          print(snapshot.error);
                          //Helper.SnackbarCustomMsg(context,snapshot.error.toString());
                          //ToastUtils.showCustomToast(context, snapshot.error.toString(), false);

                          return Container(
                            height: 50,
                            child: Text(snapshot.error.toString(),style: MyStyles.TitleStyleSemibold,),
                          );
                        }
                        return Container(
                          height: 1,
                          width: 1,
                          child: Text(""),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void navigationPage() {
    Navigator.of(context).pushNamed(RouteNames.Dashboard);
  }

  Widget _emailPasswordWidget() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[
          _entryFieldEmail(),
          _entryFieldPassword(),
        ],
      ),
    );
  }

  Widget _entryFieldEmail() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
            controller: _textloginEmail,
            focusNode: fnemail,
            autofocus: true,
            decoration: InputDecoration(
              errorText: _validloginEmail ? 'Email can\'t be empty' : null,
              contentPadding: EdgeInsets.all(8),
              focusColor: Colors.transparent,
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black12, width: 1.0)),
              fillColor: HexColor("#FFFFFF"),
              hintText: "Email",
              hintStyle: TextStyle(
                fontSize: 13,
                color: Colors.black45,
                fontFamily: FontName.Poppins,
                fontWeight: FontWeight.w500,
              ),
              labelStyle: TextStyle(
                fontSize: 13,
                color: Colors.black,
                fontFamily: FontName.Poppins,
                fontWeight: FontWeight.w500,
              ),
            ),
            onSubmitted: (value) {
              fnemail.unfocus();
              FocusScope.of(context).requestFocus(fnpass);
            },
          )
        ],
      ),
    );
  }

  Widget _entryFieldPassword() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
            controller: _textloginPass,
            focusNode: fnpass,
            obscureText: passwordVisible,
            decoration: InputDecoration(
              errorText: _validloginPass ? 'Password can\'t be empty' : null,
              contentPadding: EdgeInsets.all(8),
              suffixIcon: IconButton(
                icon: Icon(
                  passwordVisible ? Icons.visibility_off : Icons.visibility,
                  color: Colors.black38,
                ),
                onPressed: () {
                  setState(() {
                    passwordVisible = !passwordVisible;
                  });
                },
              ),
              focusColor: Colors.transparent,
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black12, width: 1.0),
              ),
              fillColor: HexColor("#FFFFFF"),
              hintText: "Password",
              hintStyle: TextStyle(
                fontSize: 13,
                color: Colors.black45,
                fontFamily: FontName.Poppins,
                fontWeight: FontWeight.w500,
              ),
              labelStyle: TextStyle(
                fontSize: 13,
                color: Colors.black,
                fontFamily: FontName.Poppins,
                fontWeight: FontWeight.w500,
              ),
            ),
            onSubmitted: (value) {
              fnpass.unfocus();
              submitSignIn();
            },
          )
        ],
      ),
    );
  }

  void submitSignIn() {
    if (_textloginEmail.text.isEmpty) {
      _validloginEmail = true;
      setState(() {});
    } else if (_textloginPass.text.isEmpty) {
      _validloginEmail = false;
      _validloginPass = true;
      setState(() {});
    } else {
      bloclogin.CallUserLogoin(_textloginEmail.text.toString(), _textloginPass.text.toString());
    }
  }

  void submitSignUp() {
    if (_textloginEmail.text.isEmpty) {
      _validloginEmail = true;
      setState(() {});
    } else if (_textloginPass.text.isEmpty) {
      _validloginEmail = false;
      _validloginPass = true;
      setState(() {});
    } else {
      bloclogin.CallUserRegister(_textloginEmail.text.toString(), _textloginPass.text.toString());
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
