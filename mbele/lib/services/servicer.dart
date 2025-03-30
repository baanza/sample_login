import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mbele/models/user.dart';

Future loginUser(UserModel user) async {
  try {
    var response = await http.post(
      Uri.parse("http://127.0.0.1:8000/auth/login/"),
      body: json.encode(user.loginToJson()),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      String username = json.decode(response.body)["username"];
      return {"status": 200, "username": username} as Map;
    } else {
      return {"status": 0} as Map;
    }
  } catch (e) {
    print(e.toString());
  }
}

Future registerUser(UserModel user) async {
  try {
    var response = await http.post(
      Uri.parse("http://127.0.0.1:8000/auth/register/"),
      body: json.encode(user.registerJson()),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      return 1;
    } else if (response.statusCode == 400) {
      return -1;
    } else {
      return 0;
    }
  } catch (e) {
    print(e.toString());
  }
}
