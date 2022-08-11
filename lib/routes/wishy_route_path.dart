class WishyRoutePath {
  final String? pathName;
  final bool isUnknown;

  WishyRoutePath.welcomePage()
      : pathName = null,
        isUnknown = false;

  WishyRoutePath.myHomesPage(this.pathName) : isUnknown = false;

  WishyRoutePath.unknownPage(this.pathName) : isUnknown = true;

  bool get isWelcomePage => pathName == null;
  bool get isMyHomePage => pathName != null;
}
