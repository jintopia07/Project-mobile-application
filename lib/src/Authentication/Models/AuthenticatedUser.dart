// @dart=2.9
class AuthenticatedUser {
  AuthenticatedUser({this.username, this.role});
  String username;
  String role;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map["Username"] = username;
    map["Role"] = role;
    return map;
  }

  AuthenticatedUser.fromJson(Map<String, dynamic> json) {
    username = json["Username"];
    role = json["Role"];
  }

  UserRole GetRole() {
    if (role == "member") {
      return UserRole.member;
    } else if (role == "employee") {
      return UserRole.employee;
    }
  }
}

enum UserRole { member, employee }

