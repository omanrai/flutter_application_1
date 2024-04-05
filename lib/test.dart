// class RouteController extends GetxController {
//   final TransportController transportController = Get.put(TransportController());
//   Dio _dio = Dio();
//   // Other variables...

//   // Modify this URL to fetch route information from OSM API
//   String osmBaseUrl = "https://router.project-osrm.org/route/v1/driving/";

//   // Modify this method to fetch route information from OSM API
//   Future getBusRoute() async {
//     // Set headers
//     _dio.options.headers['User-Authentication'] = authToken;

//     try {
//       print('try of bus route');
//       final response = await _dio.get(urlRoute);
//       print(response.data);
//       print(response.data['status']);

//       if (response.statusCode == 200) {
//         print("inside stats code");

//         routeModel = RouteModel.fromJson(response.data);

//         if (routeModel.data != null && routeModel.data!.isNotEmpty) {
//           originLat = routeModel.data![0].lat!;
//           originLong = routeModel.data![0].lng!;
//           destinationLat = routeModel.data![1].lat!;
//           destinationLong = routeModel.data![1].lng!;

//           // Fetch route from OSM API
//           final osmResponse = await _dio.get(
//               "$osmBaseUrl$originLong,$originLat;$destinationLong,$destinationLat?overview=full");

//           // Parse route points from OSM response
//           if (osmResponse.statusCode == 200) {
//             var osmRoute = osmResponse.data['routes'][0]['geometry'];
//             List<dynamic> osmPoints = PolylinePoints().decodePolyline(osmRoute);
//             routePoints = osmPoints
//                 .map((point) => LatLng(point[0], point[1]))
//                 .toList();
//           } else {
//             print('Failed to fetch route from OSM');
//           }
//         } else {
//           print('No data available');
//         }
//       } else {
//         errorServerData = response.data.toString();
//         print('errorServerData :' + errorServerData.toString());
//       }
//     } on DioException catch (err) {
//       print("dio catch");
//       // Handle DioException...
//     } catch (e) {
//       print("inside catch");
//       // Handle other exceptions...
//     } finally {
//       isLoading = false;
//       update();
//     }
//     return null;
//   }

// }





// Text(
//                                               controller.vehicleModel.data![0]
//                                                   .lastLocation
//                                                   .toString(),
//                                               style: TextStyle(
//                                                 color: controller
//                                                             .vehicleModel
//                                                             .data![0]
//                                                             .additionalAttributes
//                                                             ?.movementMetrics
//                                                             ?.speed
//                                                             ?.value ==
//                                                         0.0
//                                                     ? Colors.red
//                                                     : Colors.blue,
//                                               ),
//                                             )





//  GetBuilder<RouteController>(
//                   init: RouteController(),
//                   builder: (controller) {
//                     if (controller.isLoading) {
//                       return Center(child: CircularProgressIndicator());
//                     } else if (controller.errorServerData.isNotEmpty) {
//                       return Center(child: Text(controller.errorServerData));
//                     } else if (controller.routeModel.data == null ||
//                         controller.routeModel.data!.isEmpty) {
//                       return Center(child: Text("No data available"));
//                     } else {
//                       return Container(
//                         color: Colors.amber,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             ListView.builder(
//                               shrinkWrap: true,
//                               itemCount: controller.routeModel.data!.length,
//                               itemBuilder: (context, index) {
//                                 final datum =
//                                     controller.routeModel.data![index];
//                                 return ListTile(
//                                   title: Text(
//                                       "Latitude: ${datum.lat}, Longitude: ${datum.lng}"),
//                                 );
//                               },
//                             ),
//                             // Center(
//                             //   child: Lottie.asset('images/blue.json',
//                             //       height: 500, width: 500, fit: BoxFit.fill),
//                             // ),
//                           ],
//                         ),
//                       );
//                     }
//                   }),
//               SizedBox(
//                 height: 20,
//               ),


    // flutter_map.MarkerLayer(
    //                               markers: [
    //                               if (controller.mapController.camera.maxZoom! <
    //                                     14)
    //                                   flutter_map.Marker(
    //                                     width:
    //                                         MediaQuery.of(context).size.width *
    //                                             0.6,
    //                                     height: 80,
    //                                     point: controller.currentLocation ??
    //                                         const LatLng(26.658733, 87.269963),
    //                                     child: Container(
    //                                       child: Image.asset(
    //                                         'images/gps.png',
    //                                         width: 30,
    //                                         height: 30,
    //                                       ),
    //                                     ),
    //                                   ),
    //                               if (controller.mapController.camera.minZoom! >=
    //                                     14)
    //                                   flutter_map.Marker(
    //                                       width: MediaQuery.of(context)
    //                                               .size
    //                                               .width *
    //                                           0.6,
    //                                       height: 80,
    //                                       point: controller.currentLocation ??
    //                                           const LatLng(
    //                                               26.658733, 87.269963),
    //                                       child: Container(
    //                                         child: Stack(
    //                                           children: [
    //                                             Center(
    //                                               child: controller
    //                                                           .vehicleModel
    //                                                           .data![0]
    //                                                           .additionalAttributes
    //                                                           ?.movementMetrics
    //                                                           ?.speed
    //                                                           ?.value ==
    //                                                       0.0
    //                                                   ? Image.asset(
    //                                                       'images/blue.gif',
    //                                                       width: 30,
    //                                                       height: 30,
    //                                                     )
    //                                                   : Icon(
    //                                                       Icons.directions_bus,
    //                                                       size: controller
    //                                                           .iconSize,
    //                                                       color: Colors.blue,
    //                                                     ),
    //                                             ),
    //                                             Positioned(
    //                                               top: 10,
    //                                               left: 0,
    //                                               right: 0,
    //                                               child: Center(
    //                                                 child: Text(
    //                                                   controller.vehicleModel
    //                                                       .data![0].lastLocation
    //                                                       .toString(),
    //                                                   style: TextStyle(
    //                                                     fontWeight:
    //                                                         FontWeight.w500,
    //                                                     fontSize: 12,
    //                                                     color: controller
    //                                                                 .vehicleModel
    //                                                                 .data![0]
    //                                                                 .additionalAttributes
    //                                                                 ?.movementMetrics
    //                                                                 ?.speed
    //                                                                 ?.value ==
    //                                                             0.0
    //                                                         ? Colors.red
    //                                                         : Colors.blue,
    //                                                   ),
    //                                                   overflow:
    //                                                       TextOverflow.ellipsis,
    //                                                 ),
    //                                               ),
    //                                             ),
    //                                           ],
    //                                         ),
    //                                       )),
    //                               ],
    //                             ),
                            