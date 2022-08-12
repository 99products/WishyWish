import 'package:flutter/material.dart';
import 'package:wishywish/Pages/HomePage/myhome_page.dart';
import 'package:wishywish/Pages/PostPage/addpost_page.dart';
import '../Pages/WelcomePage/welcome_page.dart';
import 'wishy_route_path.dart';
import 'package:wishywish/Pages/ErrorPage/error_page.dart';
import 'pages.dart' as constant;

class WishyRouterDelegate extends RouterDelegate<WishyRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<WishyRoutePath> {
  String? pathName;
  bool isError = false;

  @override
  GlobalKey<NavigatorState> get navigatorKey => GlobalKey<NavigatorState>();

  @override
  WishyRoutePath get currentConfiguration {
    if (pathName == null) {
      return WishyRoutePath.welcomePage();
    }
    return WishyRoutePath.otherPage(pathName);
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
        if (isError)
          const MaterialPage(key: ValueKey('UnknownPage'), child: ErrorPage())
        else if (pathName == constant.home)
          MaterialPage(
              key: ValueKey(pathName), child: MyHomePage(onClick: onClick))
        else if (pathName == constant.create)
          MaterialPage(key: ValueKey(pathName), child: AddPost())
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) return false;

        pathName = null;
        isError = false;
        notifyListeners();

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

    if (configuration.isOtherPage) {
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
