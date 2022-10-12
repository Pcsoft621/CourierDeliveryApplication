class Courier_Details{

  /*productName=TextEditingController();
  final productWeight=TextEditingController();
  final locationFrom=TextEditingController();
  final locationTo=TextEditingController();
  final productReceiver=TextEditingController();
  final productCharges=TextEditingController();
  final productDescription=TextEditingController();*/
  String courierName = "";
  String courierWeight = "";
  String locationFrom = "";
  String locationTo= "";
  String courierReceiver = "";
  String courierType = "";
  //bool isTransporter = false;
  String courierCharges="";
  String courierDescription="";
  String courierImageUrl="";


   Map<String, dynamic> get json => Map.of({
        "courierName": courierName,
        "courierCharges": courierCharges,
        "courierType": courierType,
        "courierWeight":courierWeight,
        "courierDescription":courierDescription,
        "courierImageUrl":courierImageUrl,
        "courierReceiver": courierReceiver,
        "locationFrom":locationFrom,
        "locationTo":locationTo,
      });

}