import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:gtfs_db/gtfs_db.dart';
import 'package:gtfs_realtime_bindings/gtfs_realtime_bindings.dart' as rt;
import 'package:latlong2/latlong.dart';

class VehiclePositionMarkersLayer {
  final List<rt.VehiclePosition> vehiclePositions;
  final List<Trip> trips;
  final List<TransitRoute> routes;

  VehiclePositionMarkersLayer({
    required this.vehiclePositions,
    required this.trips,
    required this.routes,
  });

  MarkerLayerOptions buildLayer() {
    return MarkerLayerOptions(
      markers: [
        for (final vehiclePosition in vehiclePositions)
          Marker(
            point: LatLng(
              vehiclePosition.position.latitude,
              vehiclePosition.position.longitude,
            ),
            anchorPos: AnchorPos.align(AnchorAlign.center),
            width: 20,
            height: 20,
            builder: (context) {
              // TODO: Exercise 7
              return Container(
                  decoration: BoxDecoration(
                    color: routes[index].parsedRouteColor,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      routes[index].route_short_name ?? '',
                      style: TextStyle(color: routes[index].parsedRouteTextColor),
                    ),
                  ),
                );
            },
          ),
      ],
    );
  }
}
