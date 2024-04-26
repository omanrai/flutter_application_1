import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/flutter_map.dart' show MapEvent, MapEventSource;
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

import 'model.dart';
import 'route_model.dart';

class RouteController extends GetxController {
  bool isBtnClicked = false;
  bool isLoading = true;

  Dio _dio = Dio();
  var errorServerData = '';
  var dioResponseError = "";
  double originLong = 0.0;
  double originLat = 0.0;
  double destinationLong = 0.0;
  double destinationLat = 0.0;
  LatLng? currentLocation;
  LatLng? originLocation;
  LatLng? destinationLocation;
  String authToken = "br4oKUSZxNaxf_-txuBg";
  double currentZoom = 0.0;

  LatLng? savedMapPosition;
  double? savedMapZoom;

  bool isMapInteracting = false;

  late MapController mapController;

  late VehicleModel vehicleModel; // Store VehicleModel object

  late RouteModel routeModel; // Store VehicleModel object

  String urlVehicle =
      "https://marketplace.loconav-nepal.com/api/v1/vehicles?page=1&per_page=10&number=P102001KA4998&fetch_motion_status=true&fetch_odometer_reading=true&fetch_share_link=true&fetch_mobilization_details=true";

  String urlRoute =
      "https://marketplace.loconav-nepal.com/api/v1/maps/route?origin=26.658733,87.269963&destination=26.6150895,87.1563861";

  String osmBaseUrl = "https://router.project-osrm.org/route/v1/driving/";

  @override
  void onInit() {
    // TODO: implement onInit
    // getBusRoute();
    // getBusInfo();
    // Start fetching bus information at regular intervals
    // Timer.periodic(Duration(seconds: 2), (timer) {
    //   getBusInfo();
    //   print("Timer executed");
    // });
    mapController = MapController();
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    stopLiveTracking();
    super.onClose();
  }

  Timer? liveTrackingTimer;

  // Method to start live tracking

  void startLiveTracking() {
    // Save the current map position and zoom level
    savedMapPosition = mapController.camera.center;
    savedMapZoom = mapController.camera.zoom;

    // Start the timer to fetch bus info every 2 seconds
    liveTrackingTimer = Timer.periodic(Duration(milliseconds: 300), (timer) {
      // if (!isMapInteracting) {
      //   print("interact");
      //   savedMapPosition = mapController.camera.center;
      //   savedMapZoom = mapController.camera.zoom;
      //   getBusInfo();
      // }
      savedMapPosition = mapController.camera.center;
      savedMapZoom = mapController.camera.zoom;
      // isMapInteracting = false;
      getBusInfo();

      update();
    });

    // Listen to map position changes
  }

  // Method to stop live tracking
  void stopLiveTracking() {
    liveTrackingTimer?.cancel();

    // Restore map position and zoom level if available
    if (savedMapPosition != null && savedMapZoom != null) {
      mapController.moveAndRotate(savedMapPosition!, savedMapZoom!, 5);
    }

    update();
  }

  Future onRefresh() async {
    // await getBusRoute();
    await getBusInfo();

    print("route refres indicator");
  }


  Future getBusInfo() async {
    print("inside bus Info");

    // Set headers
    _dio.options.headers['User-Authentication'] = authToken;

    try {
      print('try of bus info');
      final response = await _dio.get(urlVehicle);
      print(response.data);
      print(response.data['status']);

      if (response.statusCode == 200) {
        print("inside stats code");
        // Parse JSON response and store in vehicleModel
        vehicleModel = VehicleModel.fromJson(response.data);
        final long = vehicleModel
            .data![0].additionalAttributes!.movementMetrics!.location!.long;
        final lat = vehicleModel
            .data![0].additionalAttributes!.movementMetrics!.location!.lat;

        currentLocation = LatLng(lat!, long!);
        // savedMapPosition = mapController.camera.center;
        savedMapZoom = mapController.camera.zoom;
        mapController.moveAndRotate(currentLocation!, savedMapZoom!, 5);
        // mapController.move(currentLocation!, savedMapZoom!);

        update();
      } else {
        errorServerData = response.data.toString();

        print('errorServerData :' + errorServerData.toString());
      }
    } on DioException catch (err) {
      print("dio catch");

      if (err.response == null) {
        Get.snackbar(
          "Error",
          "No Internet Connection",
          backgroundColor: Colors.amber,
          snackPosition: SnackPosition.BOTTOM,
        );

        errorServerData = "No Internet Connection";
        print(errorServerData);
      } else {
        errorServerData = err.response?.data?.toString() ?? "Unknown error";

        print('errorServerData :' + errorServerData);
      }
    } catch (e) {
      print("inside catch");
      var serverError = e.toString();
      print('serverError :' + serverError);
    } finally {
      isLoading = false;
      update();
    }
    return null;
  }

  double? iconSize = 50.0;
  double? iconSize1 = 50.0;
  void updateMarkerIconSize(double iconSize, double iconSize1) {
    this.iconSize = iconSize;
    this.iconSize1 = iconSize1;
    update();
  }

  bool isRoadTile = true;
  bool isGreenMapTile = false;
  void updateTileLayer() {
    if (isRoadTile) {
      isRoadTile = false;
      isGreenMapTile = true;
    } else {
      isGreenMapTile = false;
      isRoadTile = true;
    }
    update(); // Update the UI
  }
}
