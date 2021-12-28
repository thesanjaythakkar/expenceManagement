import 'package:flutter/material.dart';
import 'package:flutter_auth_web/healper/sharedpref.dart';
import 'package:flutter_auth_web/routes_generator.dart';
import 'package:flutter_auth_web/config/app_config.dart' as config;
import 'package:flutter_auth_web/ui/Dashboard.dart';
import 'package:flutter_auth_web/ui/Loginpage.dart';
import 'package:hexcolor/hexcolor.dart';

main() async {
  await Prefs.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'vinciDASH',
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => LoginPage(),
        "/Dashboard": (context) => Dashboard(),
      },
      onGenerateRoute: RouteGenerator.generateRoute,
      theme: ThemeData(
        primaryColor: HexColor("#0CD5C2"),
        brightness: Brightness.light,
        accentColor: config.AppColors().mainColor(1),
        focusColor: config.AppColors().accentColor(1),
        hintColor: config.AppColors().secondColor(1),
      ),
    );
  }
}
