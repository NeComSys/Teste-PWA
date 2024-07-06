// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

class UserResponseModel {
  String? uid;
  String? email;
  String? full_name;
  String? uidContact;

  UserResponseModel({
    this.uid,
    this.email,
    this.full_name,
    this.uidContact,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'full_name': full_name,
      'uidContact': uidContact,
    };
  }

  factory UserResponseModel.fromMap(Map<String, dynamic> map) {
    return UserResponseModel(
      uid: map['uid'],
      email: map['email'],
      full_name: map['full_name'],
      uidContact: map['uidContact'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserResponseModel.fromJson(String source) =>
      UserResponseModel.fromMap(json.decode(source));
}
