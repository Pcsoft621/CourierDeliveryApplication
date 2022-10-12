// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class GeoPoint {
  final double latitude;
  final double longitude;

  const GeoPoint(this.latitude, this.longitude)
      : assert(latitude >= -90 && latitude <= 90),
        assert(longitude >= -180 && longitude <= 180);

  @override
  bool operator ==(Object other) =>
      other is GeoPoint &&
      other.latitude == latitude &&
      other.longitude == longitude;

  @override
  int get hashCode => Object.hash(latitude, longitude);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory GeoPoint.fromMap(Map<String, dynamic> map) {
    return GeoPoint(
      map['latitude'] as double,
      map['longitude'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory GeoPoint.fromJson(String source) =>
      GeoPoint.fromMap(json.decode(source) as Map<String, dynamic>);
}
