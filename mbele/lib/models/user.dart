class UserModel {
  String? username;
  String email;
  String password;

  UserModel({
    this.username,
    required this.email,
    required this.password,
  });

  loginToJson() {
    return {"email": email, "password": password};
  }

  registerJson() {
    return {"Username": username, "email": email, "password": password};
  }
}

class LoginUser {
  String email;
  String password;

  LoginUser({required this.email, required this.password});
}
