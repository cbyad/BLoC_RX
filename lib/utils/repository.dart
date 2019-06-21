import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:rx_dart_sample/models/user.dart';

class Repository {
  final baseUrl = "https://fakerestapi.azurewebsites.net/api/Users";

  Future<List<User>> fetchUsers() async {
    print("Fetching Users");
    List<User> users = List<User>();
    final res = await http.get(baseUrl);

    if (res.statusCode == 200) {
      List<dynamic> body = json.decode(res.body);
      users = body.map((userMap) => User.fromJson(userMap)).toList();
      return users;
    }
    print("Resquest failed with ${res.statusCode}");
    return users;
  }
}
