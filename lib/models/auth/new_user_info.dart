class NewUserInfo {
  String firstName = "";
  String middleName = "";
  String lastName = "";
  String email = "";
  String address = "";
  bool isTransporter = false;
  String adharNo="";
  String adharUrl="";
  String profileUrl="";

  NewUserInfo();

  bool get isValid =>
      firstName.isNotEmpty &&
      lastName.isNotEmpty &&
      middleName.isNotEmpty &&
      email.isNotEmpty &&
      address.isNotEmpty&&
      adharUrl.isNotEmpty&&
      adharNo.isNotEmpty&&
      profileUrl.isNotEmpty;

  Map<String, dynamic> get json => Map.of({
        "firstName": firstName,
        "lastName": lastName,
        "middleName": middleName,
        "email": email,
        "address": address,
        "isTransporter": isTransporter,
        "adharNo":adharNo,
        "adharUrl":adharUrl,
        "profileUrl":profileUrl,
      });
}
