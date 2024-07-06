import 'dart:convert';

class AuthResponseModel {
  int? id;
  String? fullName;
  String? userName;
  String? email;
  String? language;
  // List<String>? claims;
  // List<String>? roles;
  bool? isVerified;
  String? jwToken;
  // String? issuedOn;
  String? expiresOn;
  String? refreshToken;

  AuthResponseModel({
    this.id,
    this.fullName,
    this.userName,
    this.email,
    this.language,
    // this.claims,
    // this.roles,
    this.isVerified,
    this.jwToken,
    // this.issuedOn,
    this.expiresOn,
    this.refreshToken,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullName': fullName,
      'userName': userName,
      'email': email,
      'language': language,
      // 'claims': claims,
      // 'roles': roles,
      'isVerified': isVerified,
      'jwToken': jwToken,
      // 'issuedOn': issuedOn,
      'expiresOn': expiresOn,
      'refreshToken': refreshToken,
    };
  }

  factory AuthResponseModel.fromMap(Map<String, dynamic> map) {
    return AuthResponseModel(
      id: map['id'],
      fullName: map['fullName'],
      userName: map['userName'],
      email: map['email'],
      language: map['language'],
      // claims: List<String>.from(map['claims']),
      // roles: List<String>.from(map['roles']),
      isVerified: map['isVerified'],
      jwToken: map['jwToken'],
      // issuedOn: map['issuedOn'],
      expiresOn: map['expiresOn'],
      refreshToken: map['refreshToken'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthResponseModel.fromJson(String source) =>
      AuthResponseModel.fromMap(json.decode(source));
}
