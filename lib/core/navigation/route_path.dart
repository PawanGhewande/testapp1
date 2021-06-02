class RoutePath {
  final String id;

  RoutePath.home() : id = "home";

  // expose the pages to be used by application
  bool get isHome => id == 'home';
}
