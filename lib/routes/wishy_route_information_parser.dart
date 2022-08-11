import 'package:flutter/material.dart';
import 'package:wishywish/routes/wishy_route_path.dart';

class WishyRouteInformationParser
    extends RouteInformationParser<WishyRoutePath> {
  @override
  Future<WishyRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location.toString());

    if (uri.pathSegments.isEmpty) {
      return WishyRoutePath.welcomePage();
    }

    if (uri.pathSegments.length == 1) {
      final String pathName = uri.pathSegments.elementAt(0).toString();
      if (pathName == 'wishyboard') {
        WishyRoutePath.myHomesPage(pathName);
      }
    }
    return WishyRoutePath.unknownPage('error');
  }

  @override
  RouteInformation? restoreRouteInformation(WishyRoutePath configuration) {
    // Need to handle error scenario
    // if (configuration.isUnknown) {
    //   return const RouteInformation(location: '/error');
    // }
    if (configuration.isWelcomePage) {
      return const RouteInformation(location: '/');
    }
    if (configuration.isMyHomePage) {
      return RouteInformation(location: '/${configuration.pathName}');
    }

    return null;
  }
}
