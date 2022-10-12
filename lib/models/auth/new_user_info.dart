// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class NewUserInfo {
  String firstName;
  String middleName;
  String lastName;
  String email;
  String address;
  String aadharNo;
  bool isTransporter;
  bool active = false;
  NewUserInfo(
    this.firstName,
    this.middleName,
    this.lastName,
    this.email,
    this.address,
    this.aadharNo,
    this.isTransporter,
    this.active,
  );

  bool get isValid =>
      firstName.isNotEmpty &&
      lastName.isNotEmpty &&
      middleName.isNotEmpty &&
      email.isNotEmpty &&
      (isTransporter ? aadharNo.length == 12 : true) &&
      address.isNotEmpty;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
      'email': email,
      'address': address,
      'aadharNo': aadharNo,
      'isTransporter': isTransporter,
      'active': active,
    };
  }

  factory NewUserInfo.fromMap(Map<String, dynamic> map) {
    return NewUserInfo(
      map['firstName'] as String,
      map['middleName'] as String,
      map['lastName'] as String,
      map['email'] as String,
      map['address'] as String,
      map['aadharNo'] as String,
      map['isTransporter'] as bool,
      map['active'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory NewUserInfo.fromJson(String source) =>
      NewUserInfo.fromMap(json.decode(source) as Map<String, dynamic>);
}
