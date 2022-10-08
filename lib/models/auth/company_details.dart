class CompanyDetails {
  String companyName = "";
  String companyAddress = "";
  String companyPhoneNumber = "";
  String companyType = "";
  String companyIdentityUrl = "";

  Map<String, dynamic> get json => Map.of({
        "companyName": companyName,
        "companyAddress": companyAddress,
        "companyPhoneNumber": companyPhoneNumber,
        "companyType": companyType,
        "companyIdentityUrl": companyIdentityUrl
      });
}
