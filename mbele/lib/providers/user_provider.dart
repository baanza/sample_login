import 'package:flutter/foundation.dart';
import 'package:mbele/models/user.dart';
import 'package:mbele/services/servicer.dart';

class UserProvider extends ChangeNotifier {
  //variables
  bool _logged = false;
  UserModel? currentUser;
  String _username = "";

  bool get logged => _logged;

  String get username => _username;

  set username(String us) {
    _username = us;
    notifyListeners();
  }

  // set user(UserModel currrent) {
  //   currentUser = currrent;
  //   notifyListeners();
  // }

  //login

  Future login(UserModel user) async {
    _logged = false;
    notifyListeners();
    Map response = await loginUser(user);
    if (response["status"] == 200) {
      _logged = true;
      _username = response["username"];
      notifyListeners();
    }
  }

  //register
  Future register(UserModel s) async {
    _logged = false;
    notifyListeners();
    int response = await registerUser(s);
    if (response == 1) {
      _logged = true;
      notifyListeners();
    }
  }

  logout() {
    currentUser = null;
    _username = " ";
    _logged = false;
    notifyListeners();
  }
}
