// To parse this JSON data, do
//
//     final vehicleModel = vehicleModelFromJson(jsonString);

import 'dart:convert';

VehicleModel vehicleModelFromJson(String str) =>
    VehicleModel.fromJson(json.decode(str));

String vehicleModelToJson(VehicleModel data) => json.encode(data.toJson());

class VehicleModel {
  final bool? status;
  final List<Datum>? data;
  final Pagination? pagination;

  VehicleModel({
    this.status,
    this.data,
    this.pagination,
  });

  factory VehicleModel.fromJson(Map<String, dynamic> json) => VehicleModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        pagination: json["pagination"] == null
            ? null
            : Pagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "pagination": pagination?.toJson(),
      };
}

class Datum {
  final int? id;
  final String? number;
  final String? currentTemperature;
  final String? gpsStatus;
  final double? lastLocatedAt;
  final String? lastLocation;
  final String? lastStatusReceivedAt;
  final StatusMessage? statusMessage;
  final Device? device;
  final Subscription? subscription;
  final AdditionalAttributes? additionalAttributes;
  final double? currentOdometerReading;
  final String? chassisNumber;
  final String? displayNumber;
  final int? createdAt;
  final int? updatedAt;
  final bool? isMobilized;

  Datum({
    this.id,
    this.number,
    this.currentTemperature,
    this.gpsStatus,
    this.lastLocatedAt,
    this.lastLocation,
    this.lastStatusReceivedAt,
    this.statusMessage,
    this.device,
    this.subscription,
    this.additionalAttributes,
    this.currentOdometerReading,
    this.chassisNumber,
    this.displayNumber,
    this.createdAt,
    this.updatedAt,
    this.isMobilized,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        number: json["number"],
        currentTemperature: json["current_temperature"],
        gpsStatus: json["gps_status"],
        lastLocatedAt: json["last_located_at"],
        lastLocation: json["last_location"],
        lastStatusReceivedAt: json["last_status_received_at"],
        statusMessage: json["status_message"] == null
            ? null
            : StatusMessage.fromJson(json["status_message"]),
        device: json["device"] == null ? null : Device.fromJson(json["device"]),
        subscription: json["subscription"] == null
            ? null
            : Subscription.fromJson(json["subscription"]),
        additionalAttributes: json["additional_attributes"] == null
            ? null
            : AdditionalAttributes.fromJson(json["additional_attributes"]),
        currentOdometerReading: json["current_odometer_reading"],
        chassisNumber: json["chassis_number"],
        displayNumber: json["display_number"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        isMobilized: json["is_mobilized"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "number": number,
        "current_temperature": currentTemperature,
        "gps_status": gpsStatus,
        "last_located_at": lastLocatedAt,
        "last_location": lastLocation,
        "last_status_received_at": lastStatusReceivedAt,
        "status_message": statusMessage?.toJson(),
        "device": device?.toJson(),
        "subscription": subscription?.toJson(),
        "additional_attributes": additionalAttributes?.toJson(),
        "current_odometer_reading": currentOdometerReading,
        "chassis_number": chassisNumber,
        "display_number": displayNumber,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "is_mobilized": isMobilized,
      };
}

class AdditionalAttributes {
  final MovementMetrics? movementMetrics;

  AdditionalAttributes({
    this.movementMetrics,
  });

  factory AdditionalAttributes.fromJson(Map<String, dynamic> json) =>
      AdditionalAttributes(
        movementMetrics: json["movement_metrics"] == null
            ? null
            : MovementMetrics.fromJson(json["movement_metrics"]),
      );

  Map<String, dynamic> toJson() => {
        "movement_metrics": movementMetrics?.toJson(),
      };
}

class MovementMetrics {
  final double? orientation;
  final Speed? speed;
  final Location? location;
  final String? motionStatus;
  final int? stateSinceTs;
  final String? ignition;
  final String? shareLink;

  MovementMetrics({
    this.orientation,
    this.speed,
    this.location,
    this.motionStatus,
    this.stateSinceTs,
    this.ignition,
    this.shareLink,
  });

  factory MovementMetrics.fromJson(Map<String, dynamic> json) =>
      MovementMetrics(
        orientation: json["orientation"],
        speed: json["speed"] == null ? null : Speed.fromJson(json["speed"]),
        location: json["location"] == null
            ? null
            : Location.fromJson(json["location"]),
        motionStatus: json["motion_status"],
        stateSinceTs: json["state_since_ts"],
        ignition: json["ignition"],
        shareLink: json["share_link"],
      );

  Map<String, dynamic> toJson() => {
        "orientation": orientation,
        "speed": speed?.toJson(),
        "location": location?.toJson(),
        "motion_status": motionStatus,
        "state_since_ts": stateSinceTs,
        "ignition": ignition,
        "share_link": shareLink,
      };
}

class Location {
  final double? lat;
  final String? address;
  final int? receivedTs;
  final double? long;

  Location({
    this.lat,
    this.address,
    this.receivedTs,
    this.long,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        lat: json["lat"]?.toDouble(),
        address: json["address"],
        receivedTs: json["received_ts"],
        long: json["long"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "address": address,
        "received_ts": receivedTs,
        "long": long,
      };
}

class Speed {
  final double? value;
  final String? unit;

  Speed({
    this.value,
    this.unit,
  });

  factory Speed.fromJson(Map<String, dynamic> json) => Speed(
        value: json["value"],
        unit: json["unit"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "unit": unit,
      };
}

class Device {
  final String? serialNumber;
  final String? countryCode;
  final String? phoneNumber;
  final String? deviceType;

  Device({
    this.serialNumber,
    this.countryCode,
    this.phoneNumber,
    this.deviceType,
  });

  factory Device.fromJson(Map<String, dynamic> json) => Device(
        serialNumber: json["serial_number"],
        countryCode: json["country_code"],
        phoneNumber: json["phone_number"],
        deviceType: json["device_type"],
      );

  Map<String, dynamic> toJson() => {
        "serial_number": serialNumber,
        "country_code": countryCode,
        "phone_number": phoneNumber,
        "device_type": deviceType,
      };
}

class StatusMessage {
  final String? receivedAt;

  StatusMessage({
    this.receivedAt,
  });

  factory StatusMessage.fromJson(Map<String, dynamic> json) => StatusMessage(
        receivedAt: json["received_at"],
      );

  Map<String, dynamic> toJson() => {
        "received_at": receivedAt,
      };
}

class Subscription {
  final DateTime? expiresAt;

  Subscription({
    this.expiresAt,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
        expiresAt: json["expires_at"] == null
            ? null
            : DateTime.parse(json["expires_at"]),
      );

  Map<String, dynamic> toJson() => {
        "expires_at": expiresAt?.toIso8601String(),
      };
}

class Pagination {
  final int? totalCount;
  final int? perPage;
  final int? currentPage;

  Pagination({
    this.totalCount,
    this.perPage,
    this.currentPage,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        totalCount: json["total_count"],
        perPage: json["per_page"],
        currentPage: json["current_page"],
      );

  Map<String, dynamic> toJson() => {
        "total_count": totalCount,
        "per_page": perPage,
        "current_page": currentPage,
      };
}
