// @dart=2.9
class RequestAuthen {
  RequestAuthen(this.username, this.password);

  String username;
  String password;

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = <String, dynamic>{};
    json['Username'] = username;
    json['Password'] = password;
    return json;
  }
}
