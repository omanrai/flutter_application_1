import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

import 'model.dart';

class TransportController extends GetxController {
  bool isBtnClicked = false;
  bool isLoading = true;
  bool isTransportationAvailable = false;
  Dio _dio = Dio();
  var errorServerData = '';
  var dioResponseError = "";
  var long = 0.0;
  var lat = 0.0;
  LatLng? currentLocation;
  late MapController mapController;

  late VehicleModel vehicleModel; // Store VehicleModel object

  String url =
      "https://marketplace.loconav-nepal.com/api/v1/vehicles?page=1&per_page=10&number=P102001KA4998&fetch_motion_status=true&fetch_odometer_reading=true&fetch_share_link=true&fetch_mobilization_details=true";

  @override
  void onInit() {
    // TODO: implement onInit
    getBusInfo();
    mapController = MapController();

    super.onInit();
  }

  Future onRefresh() async {
    await getBusInfo();
    print("transport refres indicator");
  }

  Future getBusInfo() async {
    print("inside bus Info");
    // Define the authentication token
    String authToken = "br4oKUSZxNaxf_-txuBg";

    // Set headers
    _dio.options.headers['User-Authentication'] = authToken;

    try {
      print('try of bus info');
      final response = await _dio.get(url);
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
        mapController.move(currentLocation!, 17);
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

  double? iconSize;
  void updateMarkerIconSize(double iconSize) {
    iconSize = iconSize;
    update();
  }
}
