import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/controller.dart';
import 'package:flutter_application_1/map.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class RealTimeMap extends StatefulWidget {
  @override
  _RealTimeMapState createState() => _RealTimeMapState();
}

class _RealTimeMapState extends State<RealTimeMap> {
  final TransportController transportController =
      Get.put(TransportController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Real-Time Vehicle Tracking'),
      ),
      body: GetBuilder<TransportController>(
        builder: (controller) => Stack(
          children: [
            FlutterMap(
              mapController: transportController.mapController,
              options: MapOptions(
                initialCenter: transportController.currentLocation ??
                    const LatLng(26.658733, 87.269963),
                initialZoom: 17.0,
                maxZoom: 19,
                minZoom: 14,
                // Add this to calculate zoom level and adjust marker size
                onPositionChanged: (position, hasGesture) {
                  double zoomLevel = position.zoom!;
                  // Adjust marker size based on zoom level
                  double iconSize =
                      (zoomLevel - 14) * 10; // Adjust this value as needed
                  controller.updateMarkerIconSize(iconSize);
                },
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: ['a', 'b', 'c'],
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 90.0,
                      height: 90.0,
                      point: transportController.currentLocation ??
                          const LatLng(26.658733, 87.269963),
                      child: Icon(
                        Icons.directions_bus,
                        size: controller.iconSize,
                        color: controller
                                    .vehicleModel
                                    .data![0]
                                    .additionalAttributes
                                    ?.movementMetrics
                                    ?.motionStatus ==
                                "no_network"
                            ? Colors.red
                            : Colors.blue,
                      ),
                    ),
                    
                  ],
                ),
              ],
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
        ),
      ),
    );
  }
}
