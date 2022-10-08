class NewUserInfo {
  String firstName = "";
  String middleName = "";
  String lastName = "";
  String email = "";
  String address = "";
  bool isTransporter = false;

  NewUserInfo();

  bool get isValid =>
      firstName.isNotEmpty &&
      lastName.isNotEmpty &&
      middleName.isNotEmpty &&
      email.isNotEmpty &&
      address.isNotEmpty;

  Map<String, dynamic> get json => Map.of({
        "firstName": firstName,
        "lastName": lastName,
        "middleName": middleName,
        "email": email,
        "address": address,
        "isTransporter": isTransporter
      });
}
