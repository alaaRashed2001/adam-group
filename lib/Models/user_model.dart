class LoginResponseModel {
  String? accessToken;
  String? tokenType;
  UserModel? user;

  LoginResponseModel();

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
  }
}

class UserModel {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? address;
  String? city;
  String? emailVerifiedAt;
  int? isAdmin;

  UserModel();

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    city = json['city'];
    emailVerifiedAt = json['email_verified_at'];
    isAdmin = json['is_admin'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['phone'] = phone;
    map['address'] = address;
    map['city'] = city;
    map['email_verified_at'] = emailVerifiedAt;
    map['is_admin'] = isAdmin;

    return map;
  }
}
