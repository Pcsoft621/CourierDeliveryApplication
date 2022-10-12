class TravelDetails {
  String startLocation = "";
  String endLocation = "";
  String approxTravelingTime = "";
  String startTime = "";
  String endTime = "";
  String travelingMode = "";
  String travelingFrequency = "";

  Map<String, dynamic> get json => Map.of({
        "startLocation":startLocation,
        "endLocation": endLocation,
        "approxTravelingTime": approxTravelingTime,
        "startTime": startTime,
        "endTime": endTime,
        "travelingMode": travelingMode,
        "travelingFrequency":travelingFrequency
      });
}
