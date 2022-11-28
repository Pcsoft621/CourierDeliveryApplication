class Courier_Details{

  
  String courierName = "";
  String courierWeight = "";
  String locationFrom = "";
  String locationTo= "";
  String courierReceiverName = "";
  String courierReceiverId= "";
  String courierSender = "";
  String courierType = "";
  //bool isTransporter = false;
  String courierCharges="";
  String courierDescription="";
  String courierImageUrl="";
  String courierSenderName= "";
  String courierSenderId= "";
  String transporterId ="";
  String transporterName ="";
  bool isRequestedByTransporter=false;

  bool get isValid=>
    courierName.isNotEmpty&&
    courierWeight.isNotEmpty&&
    locationFrom.isNotEmpty&&
    locationTo.isNotEmpty&&
    courierReceiverName.isNotEmpty&&
    courierReceiverId.isNotEmpty&&
    courierSender.isNotEmpty&&
    courierType.isNotEmpty&&

    courierCharges.isNotEmpty&&
    courierDescription.isNotEmpty&&
    courierImageUrl.isNotEmpty&&
    courierSenderName.isNotEmpty&&
    courierSenderId.isNotEmpty&&
    transporterId.isEmpty;




   Map<String, dynamic> get json => Map.of({
        "courierName": courierName,
        "courierCharges": courierCharges,
        "courierType": courierType,
        "courierWeight":courierWeight,
        "courierDescription":courierDescription,
        "courierImageUrl":courierImageUrl,
        "courierReceiverName": courierReceiverName,
        "courierReceiverId": courierReceiverId,
        "courierSenderName": courierSenderName,
        "courierSenderId": courierSenderId,
        "locationFrom":locationFrom,
        "locationTo":locationTo,
        "transporterId":transporterId,
        "transporterName":transporterName,
        "isRequestedByTransporter":isRequestedByTransporter
      });

}