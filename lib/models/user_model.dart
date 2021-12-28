class UserModel {
  String id;
  String email;
  String password;

  UserModel.fromJson(Map<String, dynamic> parsedJson) {
    print(parsedJson['results'].length);

    id = parsedJson['id'];
    email = parsedJson['email'];
    password = parsedJson['password'];
  }

  UserModel({
    this.id,
    this.email,
    this.password,
  });

  UserModel.Init();

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["email"] = email;
    map["password"] = password;
    return map;
  }

  Map toJson() => {
        'id': id,
        'email': email,
        'password': password,
      };
}
