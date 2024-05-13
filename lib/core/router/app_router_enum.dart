enum AppRouteEnum {
  pokemonListPage,
  pokemonDetailPage
}

extension AppRouteExtension on AppRouteEnum {
  String get name {
    switch(this){
      case AppRouteEnum.pokemonListPage:
        return "/pokemonlist_page";
      default:
        return "/pokemondetail_page";
    }
  }
}