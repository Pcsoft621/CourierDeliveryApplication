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
      });

}