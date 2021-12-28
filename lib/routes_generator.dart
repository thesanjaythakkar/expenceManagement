import 'package:flutter/material.dart';
import 'package:flutter_auth_web/RouteNames.dart';
import 'package:flutter_auth_web/ui/Dashboard.dart';
import 'package:flutter_auth_web/ui/Loginpage.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;
    List<String> pathComponents = settings.name.split('/');
    // final Map<String, dynamic> arguments = settings.arguments;
    print(pathComponents[1]);
    print(pathComponents);
    switch ("/" + pathComponents[1]) {
      case RouteNames.login:
        return MaterialPageRoute(builder: (_) => LoginPage());

      case RouteNames.Dashboard:
        return MaterialPageRoute(builder: (_) => Dashboard());
      default:
        print("------------> final       ->>>>>>>>>>>>/" + pathComponents[1]);
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
