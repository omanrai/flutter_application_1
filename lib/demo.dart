  
  
  
  
  // Future getBusRoute() async {
  //   print("inside bus route");

  //   // Set headers
  //   _dio.options.headers['User-Authentication'] = authToken;

  //   try {
  //     print('try of bus route');
  //     final response = await _dio.get(urlRoute);
  //     print(response.data);
  //     print(response.data['status']);

  //     if (response.statusCode == 200) {
  //       print("inside stats code");

  //       routeModel = RouteModel.fromJson(response.data);
  //       //can you print lat and long in here
  //       // Print latitude and longitude
  //       if (routeModel.data != null && routeModel.data!.isNotEmpty) {
  //         // Assign the first latitude and longitude to lat and long variables
  //         originLat = routeModel.data![0].lat!;
  //         originLong = routeModel.data![0].lng!;
  //         destinationLat = routeModel.data![1].lat!;
  //         destinationLong = routeModel.data![1].lng!;
  //         print(originLat);
  //         print(originLong);
  //         print(destinationLat);
  //         print(destinationLong);
  //         destinationLocation = LatLng(destinationLat, destinationLong);

  //         currentLocation = LatLng(originLat, originLong);
  //         originLocation = LatLng(originLat, originLong);
  //       } else {
  //         print('No data available');
  //       }
  //     } else {
  //       errorServerData = response.data.toString();

  //       print('errorServerData :' + errorServerData.toString());
  //     }
  //   } on DioException catch (err) {
  //     print("dio catch");

  //     if (err.response == null) {
  //       Get.snackbar(
  //         "Error",
  //         "No Internet Connection",
  //         backgroundColor: Colors.amber,
  //         snackPosition: SnackPosition.BOTTOM,
  //       );

  //       errorServerData = "No Internet Connection";
  //       print(errorServerData);
  //     } else {
  //       errorServerData = err.response?.data?.toString() ?? "Unknown error";

  //       print('errorServerData :' + errorServerData);
  //     }
  //   } catch (e) {
  //     print("inside catch");
  //     var serverError = e.toString();
  //     print('serverError :' + serverError);
  //   } finally {
  //     isLoading = false;
  //     update();
  //   }
  //   return null;
  // }
