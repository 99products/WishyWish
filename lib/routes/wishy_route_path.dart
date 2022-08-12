class WishyRoutePath {
  final String? pathName;
  final bool isUnknown;

  WishyRoutePath.welcomePage()
      : pathName = null,
        isUnknown = false;

  WishyRoutePath.otherPage(this.pathName) : isUnknown = false;

  WishyRoutePath.unknownPage(this.pathName) : isUnknown = true;

  bool get isWelcomePage => pathName == null;
  bool get isOtherPage => pathName != null;
}
