import 'package:flutter/material.dart';
import 'package:wishywish/Pages/HomePage/myhome_page.dart';
import '../Pages/WelcomePage/welcome_page.dart';
import 'wishy_route_path.dart';

class WishyRouterDelegate extends RouterDelegate<WishyRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<WishyRoutePath> {
  String? pathName;
  bool isError = false;

  @override
  GlobalKey<NavigatorState> get navigatorKey => GlobalKey<NavigatorState>();

  @override
  WishyRoutePath get currentConfiguration {
    if (pathName == null) {
      WishyRoutePath.welcomePage();
    }
    return WishyRoutePath.myHomesPage(pathName);
  }

  void onClick(String path) {
    pathName = path;
    notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(
            key: const ValueKey('WelcomePage'),
            child: WelcomePage(onClick: onClick)),
        if (pathName != null)
          MaterialPage(key: ValueKey(pathName), child: const MyHomePage())
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) return false;

        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(WishyRoutePath configuration) async {
    if (configuration.isUnknown) {
      pathName = null;
      isError = true;
      return;
    }

    if (configuration.isMyHomePage) {
      if (configuration.pathName != null) {
        pathName = configuration.pathName;
        isError = false;
        return;
      } else {
        isError = true;
        return;
      }
    } else {
      pathName = null;
    }
  }
}
