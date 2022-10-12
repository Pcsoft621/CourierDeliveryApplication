import 'dart:convert';

import 'package:easy_go/util/geopoint.dart';

class TransporterDetailsFormModel {
  final String aadharNo;
  final GeoPoint startLocation;
  final GeoPoint endLocation;
  final int timeRequiredInMinutes;
  final DateTime startTime;
  final DateTime endTime;
  final TravelingFrequency travelingFrequency;
  final TravelingMode travelingMode;

  TransporterDetailsFormModel(
    this.aadharNo,
    this.startLocation,
    this.endLocation,
    this.timeRequiredInMinutes,
    this.startTime,
    this.endTime,
    this.travelingFrequency,
    this.travelingMode,
  );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'aadharNo': aadharNo,
      'startLocation': startLocation.toMap(),
      'endLocation': endLocation.toMap(),
      'timeRequiredInMinutes': timeRequiredInMinutes,
      'startTime': startTime,
      'endTime': endTime,
      'travelingFrequency': travelingFrequency,
      'travelingMode': travelingMode,
    };
  }

  factory TransporterDetailsFormModel.fromMap(Map<String, dynamic> map) {
    return TransporterDetailsFormModel(
      map['aadharNo'] as String,
      GeoPoint.fromMap(map['startLocation'] as Map<String, dynamic>),
      GeoPoint.fromMap(map['endLocation'] as Map<String, dynamic>),
      map['timeRequiredInMinutes'] as int,
      DateTime.parse(map['startTime'] as String),
      DateTime.parse(map['endTime'] as String),
      map['travelingFrequency'] as TravelingFrequency,
      map['travelingMode'] as TravelingMode,
    );
  }

  String toJson() => json.encode(toMap());

  factory TransporterDetailsFormModel.fromJson(String source) =>
      TransporterDetailsFormModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
}

enum TravelingFrequency { daily, weekly, monthly, yearly }

enum TravelingMode { bus, train, car, bike }
