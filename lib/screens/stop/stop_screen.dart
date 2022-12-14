import 'package:flutter/material.dart';
import 'package:gtfs_db/gtfs_db.dart';
import 'package:transit/database/database_service.dart';
import 'package:transit/models/db.dart';
import 'package:transit/navigator_routes.dart';
import 'package:transit/screens/trip/trip_screen.dart';
import 'package:transit/widgets/app_future_loader.dart';

class StopScreen extends StatelessWidget {
  final Stop stop;

  const StopScreen({super.key, required this.stop});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(stop.stop_name),
      ),
      body: AppFutureBuilder<List<TripsWithStopTimes>>(
        future: DatabaseService.get(context).getStopTimesForStop(
          stop,
          DateTime.now(),
        ),
        builder: (context, tripsWithTimes) {
          return ListView.separated(
            itemCount: tripsWithTimes.length,
            separatorBuilder: (context, i) => Divider(height: 1),
            itemBuilder: (context, index) {
              final tripWithTime = tripsWithTimes[index];

              return TripStopTimeListTile(
                stop: stop,
                route: tripWithTime.route,
                trip: tripWithTime.trip,
                stopTime: tripWithTime.stopTime,
              );
            },
          );
        },
      ),
    );
  }
}

class TripStopTimeListTile extends StatelessWidget {
  final Stop stop;
  final StopTime stopTime;
  final Trip trip;
  final TransitRoute route;

  const TripStopTimeListTile({
    super.key,
    required this.stop,
    required this.stopTime,
    required this.route,
    required this.trip,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: Exercise 2 and 4
    return ListTile(
      leading: Container(
        decoration: BoxDecoration(
          color: route.parsedRouteColor,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            route.route_short_name ?? '',
            style: TextStyle(color: route.parsedRouteTextColor),
          ),
        ),
      ),
      title: Text(trip.trip_headsign ?? ''),
      trailing: Text(stopTime.departure_time),
      subtitle: Text(route.route_long_name),


      onTap: (){
        //print(trip.trip_headsign ?? '');\
        Navigator.pushNamed(
          context,
          NavigatorRoutes.routeTrip,
          arguments: TripScreenArguments(
              stop: stop,
              route: route,
              trip: trip,
          ),
        );
      },
    );
  }
}
