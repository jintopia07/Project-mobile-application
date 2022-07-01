class UserDetails{
  String? displayName;
  String? email;
  String? photoURL;

  UserDetails({ required this.displayName , required this.email, required this.photoURL});


  UserDetails.fromJson(Map<String, dynamic> json){
    displayName = json["displayName"];
    email = json["email"];
    photoURL = json["photoURL"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['displayName'] = displayName;
    data['email'] = email;
    data['photoURL'] = photoURL;


    return data;

  }
}