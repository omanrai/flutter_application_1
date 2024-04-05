// To parse this JSON data, do
//
//     final routeModel = routeModelFromJson(jsonString);

import 'dart:convert';

RouteModel routeModelFromJson(String str) =>
    RouteModel.fromJson(json.decode(str));

String routeModelToJson(RouteModel data) => json.encode(data.toJson());

class RouteModel {
  final bool? status;
  final List<Datum>? data;

  RouteModel({
    this.status,
    this.data,
  });

  factory RouteModel.fromJson(Map<String, dynamic> json) => RouteModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  final double? lat;
  final double? lng;

  Datum({
    this.lat,
    this.lng,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        lat: json["lat"]?.toDouble(),
        lng: json["lng"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
      };
}
