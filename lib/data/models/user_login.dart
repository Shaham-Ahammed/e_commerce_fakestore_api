class UserData {
  List<UserLogin> users;
  UserData({required this.users});

  factory UserData.fromJson(List<dynamic> json) {
    return UserData(
      users: List<UserLogin>.from(json.map(
        (e) => UserLogin.fromJson(e),
      )),
    );
  }
}

class UserLogin {
  final String userName;
  final String passWord;
  final int id;

  UserLogin({
    required this.id,
    required this.userName,
    required this.passWord,
  });

  static const String idKey = "id";
  static const String userNameKey = "username";
  static const String passWordKey = "password";

  factory UserLogin.fromJson(Map<String, dynamic> map) {
    return UserLogin(
      id: map[idKey],
      userName: map[userNameKey],
      passWord: map[passWordKey],
    );
  }

  Map<String, dynamic> toJson() {
    return {userNameKey: userName, passWordKey: passWord};
  }
}

class LoginToken {
  final String token;
  LoginToken({required this.token});
  factory LoginToken.fromJson(Map<String, dynamic> json) {
    return LoginToken(token: json['token']);
  }
}
