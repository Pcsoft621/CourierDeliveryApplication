
class StudentDetails {
  String rollNo = "";
  String collegeName = "";
  String collegeAddress = "";
  String passoutYear = "";
  String specilization = "";
  String year = "";
  String studentIdentityUrl="";
  
  

  Map<String, dynamic> get json => Map.of({
        "rollNo":rollNo,
        "collegeName":collegeName,
        "collegeAddress":collegeAddress,
        "passoutYear":passoutYear,
        "specilization":specilization,
        "year":year,
        "studentIdentityUrl":studentIdentityUrl,

        
      });
}
