import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/route_controller.dart';
import 'package:flutter_map/flutter_map.dart' as flutter_map;
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'controller.dart';
import 'package:latlong2/latlong.dart';

class RealTimeMap extends StatelessWidget {
  final RouteController routeController = Get.put(RouteController());
  final TransportController transportController =
      Get.put(TransportController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Route Demo"),
      ),
      body: RefreshIndicator(
        onRefresh: () => routeController.onRefresh(),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GetBuilder<RouteController>(
                  init: RouteController(),
                  builder: (controller) {
                    if (controller.isLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (controller.errorServerData.isNotEmpty) {
                      return Center(child: Text(controller.errorServerData));
                    } else if (controller.routeModel.data == null ||
                        controller.routeModel.data!.isEmpty) {
                      return Center(child: Text("No data available"));
                    } else {
                      return Stack(
                        children: [
                          SizedBox(
                            height: 500,
                            child: flutter_map.FlutterMap(
                              mapController: controller.mapController,
                              options: flutter_map.MapOptions(
                                onPositionChanged: (position, hasGesture) {
                                  controller.isMapInteracting = hasGesture;
                                  print('${position.hasGesture}');
                                  print('${position.center}');

                                  double zoomLevel = position.zoom!;

                                  // Adjust marker size based on zoom level
                                  double iconSize = (zoomLevel - 14) * 11;
                                  double iconSize1 = (zoomLevel + 14) * 20;
                                  controller.updateMarkerIconSize(
                                      iconSize, iconSize1);

                                  //current zoom
                                  controller.currentZoom = position.zoom!;
                                  print(
                                      'Zoom difference: ${controller.currentZoom}');
                                },
                                // initialCenter: controller.currentLocation ??
                                //     const LatLng(26.658733, 87.269963),
                                // initialZoom: 17.0,
                                initialCenter: controller.savedMapPosition ??
                                    controller.currentLocation!,
                                initialZoom: controller.savedMapZoom ?? 17.0,

                                maxZoom: 18,
                                minZoom: 14,
                                // onMapReady: () {
                                //   controller.mapController.mapEventStream
                                //       .listen((evt) {
                                //     controller.getBusInfo();
                                //   });
                                // },
                              ),
                              children: [
                                controller.isRoadTile
                                    ? flutter_map.TileLayer(
                                        urlTemplate:
                                            'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                                        // subdomains: ['a', 'b', 'c'],
                                        userAgentPackageName:
                                            'dev.fleaflet.flutter_map.example',
                                        // userAgentPackageName: 'com.example.app',
                                      )
                                    : flutter_map.TileLayer(
                                        urlTemplate:
                                            'https://server.arcgisonline.com/ArcGIS/rest/services/{layer}/MapServer/tile/{z}/{y}/{x}',
                                        additionalOptions: {
                                            'layer': 'World_Imagery'
                                            // 'layer': 'World_Street_Map'
                                          }),
                                flutter_map.MarkerLayer(
                                  rotate: true,
                                  markers: [
                                    if (controller.currentZoom > 16)
                                      flutter_map.Marker(
                                        rotate: true,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.6,
                                        height: 80,
                                        point: controller.currentLocation ??
                                            const LatLng(26.658733, 87.269963),
                                        child: Container(
                                          // color: Colors.amber,
                                          child: Stack(
                                            children: [
                                              Center(
                                                child: controller
                                                            .vehicleModel
                                                            .data![0]
                                                            .additionalAttributes
                                                            ?.movementMetrics
                                                            ?.speed
                                                            ?.value ==
                                                        0.0
                                                    ? Icon(
                                                        Icons.directions_bus,
                                                        size:
                                                            controller.iconSize,
                                                        color: Colors.red,
                                                      )
                                                    : Image.asset(
                                                        'images/blue.gif',
                                                        // width: 30,
                                                        // height: 30,
                                                        width:
                                                            controller.iconSize,
                                                        height:
                                                            controller.iconSize,
                                                      ),
                                              ),
                                              // Text above the bus icon
                                              Positioned(
                                                top: 10,
                                                left: 0,
                                                right: 0,
                                                child: Center(
                                                  child: Text(
                                                    controller.vehicleModel
                                                        .data![0].lastLocation
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 12,
                                                      color: controller
                                                                  .vehicleModel
                                                                  .data![0]
                                                                  .additionalAttributes
                                                                  ?.movementMetrics
                                                                  ?.speed
                                                                  ?.value ==
                                                              0.0
                                                          ? Colors.red
                                                          : Colors.blue,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    if (controller.currentZoom < 16)
                                      flutter_map.Marker(
                                        rotate: true,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.6,
                                        height: 80,
                                        point: controller.currentLocation ??
                                            const LatLng(26.658733, 87.269963),
                                        child: Container(
                                          // color: Colors.amber,
                                          child: Stack(
                                            children: [
                                              Center(
                                                  child: controller
                                                              .vehicleModel
                                                              .data![0]
                                                              .additionalAttributes
                                                              ?.movementMetrics
                                                              ?.speed
                                                              ?.value ==
                                                          0.0
                                                      ? Image.asset(
                                                          'images/redgps.png',
                                                          width: controller
                                                              .iconSize1,
                                                          height: controller
                                                              .iconSize1,
                                                        )
                                                      : Image.asset(
                                                          'images/gps32.png',
                                                          width: controller
                                                              .iconSize1,
                                                          height: controller
                                                              .iconSize1,
                                                        )),
                                              // Text above the bus icon
                                              Positioned(
                                                top: 10,
                                                left: 0,
                                                right: 0,
                                                child: Center(
                                                  child: Text(
                                                    controller.vehicleModel
                                                        .data![0].lastLocation
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 12,
                                                      color: controller
                                                                  .vehicleModel
                                                                  .data![0]
                                                                  .additionalAttributes
                                                                  ?.movementMetrics
                                                                  ?.speed
                                                                  ?.value ==
                                                              0.0
                                                          ? Colors.red
                                                          : Colors.blue,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                flutter_map.PolylineLayer(
                                  polylines: [
                                    flutter_map.Polyline(
                                      points: [
                                        controller.originLocation!,
                                        controller.destinationLocation!,
                                      ],
                                      color: Colors.blue,
                                      strokeWidth: 3.0,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: MediaQuery.of(context).size.height * 0.2,
                            right: MediaQuery.of(context).size.width * 0.1,
                            child: IconButton(
                                onPressed: () {
                                  controller.updateTileLayer();
                                },
                                icon: Icon(
                                  Icons.map,
                                  color: Colors.blue,
                                  size: 40,
                                )),
                          ),
                          Positioned(
                            bottom: MediaQuery.of(context).size.height * 0.1,
                            right: MediaQuery.of(context).size.width * 0.1,
                            child: IconButton(
                                onPressed: () {
                                  controller.getBusInfo();
                                },
                                icon: Icon(
                                  Icons.gps_fixed,
                                  color: Colors.blue,
                                  size: 40,
                                )),
                          ),
                        ],
                      );
                    }
                  }),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                      onPressed: () {
                        routeController.startLiveTracking();
                      },
                      child: Text("Live")),
                  TextButton(
                      onPressed: () {
                        routeController.stopLiveTracking();
                      },
                      child: Text("Stop Live")),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
