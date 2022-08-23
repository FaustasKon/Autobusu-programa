import 'package:flutter/material.dart';
import 'package:gtfs_db/gtfs_db.dart';
import 'package:transit/constants.dart';
import 'package:transit/database/database_service.dart';
import 'package:transit/widgets/map/layers/stops_marker_layer.dart';
import 'package:transit/widgets/map/transit_map.dart';

import '../../widgets/app_future_loader.dart';

class StopsMapTab extends StatelessWidget {
  const StopsMapTab({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Exercise 6
    final database = DatabaseService.get(context);
    return AppFutureBuilder<List<Stop>>(
      future: database.getAllStops(),
      builder: (BuildContext context, stops) {
        return TransitMap(
          center: defaultLatLng,
          stopsLayer: StopsMarkerLayer(
            stops: stops,
          ),
        );
      },
    );
  }
}
