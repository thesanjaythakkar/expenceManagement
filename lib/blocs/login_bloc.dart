import 'package:flutter_auth_web/models/user_model.dart';
import 'package:rxdart/rxdart.dart';

import '../resources/repository.dart';

class LoginBloc {
  final _repository = Repository();
  final _userdata = PublishSubject<UserModel>();

  Observable<UserModel> get userlogin => _userdata.stream;

  CallUserLogoin(String email, String password) async {
    await _repository.Userlogin(email, password,
        (success, usermodel, errormsg) {
      if (success) {
        _userdata.sink.add(usermodel);
      } else {
        _userdata.sink.addError(errormsg);
      }
    });
  }

  CallUserRegister(String email, String password) async {
    await _repository.UserRegidter(email, password,
        (success, usermodel, errormsg) {
      if (success) {
        _userdata.sink.add(usermodel);
      } else {
        _userdata.sink.addError(errormsg);
      }
    });
  }

  CallUserSignOut() async {
    await _repository.UserSignOut((success, usermodel, errormsg) {
          if (success) {
            _userdata.sink.add(usermodel);
          } else {
            _userdata.sink.addError(errormsg);
          }
        });
  }

  dispose() {
    _userdata.close();
  }
}

final bloclogin = LoginBloc();
