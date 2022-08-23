import 'package:flutter/material.dart';
import 'package:gtfs_db/gtfs_db.dart';
import 'package:transit/database/database_service.dart';

import '../../widgets/app_future_loader.dart';

class RoutesTab extends StatelessWidget {
  const RoutesTab({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Exercise 5
    final database = DatabaseService.get(context);

    return AppFutureBuilder<List<TransitRoute>>(
      future: database.getAllRoutes(),
      builder: (BuildContext context, routes) {
        return ListView.builder(
          itemCount: routes.length,
          itemBuilder: (context, index) {
            return ListTile(
                title: Text(routes[index].route_long_name),
                leading: Container(
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
                ),
            );
          },
        );
      },
    );
  }
}
