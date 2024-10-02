import 'dart:convert';
import 'dart:developer';
import 'package:e_commerce_fake_store_api/core/network/api.dart';
import 'package:e_commerce_fake_store_api/data/models/user_login.dart';
import 'package:http/http.dart' as http;

class UserLoginRepo {

  Future<UserData> fetchUsers() async {
    try {
      const url = "$baseApi/users?limit=5";
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final parsedBody = jsonDecode(response.body);
        return UserData.fromJson(parsedBody);
      } else {
        log("error while parsing");
        throw Exception("failed to fetch from here");
      }
    } catch (e) {
      log("error while fetching $e");
      throw Exception("failed to fetch");
    }
  }

  Future<LoginToken?> loginUser(UserLogin user) async {
    final parsedBody = user.toJson();
    const url = "$baseApi/auth/login";
    final body = parsedBody;
    try {
      final response = await http.post(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode(body));
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);

        return LoginToken.fromJson(body);
      } else {
        log("error while loggin in ${response.statusCode}");
        throw Exception("error");
      }
    } catch (e) {
      log("error while logging in $e");
      throw Exception("error");
    }
  }
}
