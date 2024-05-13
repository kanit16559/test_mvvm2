import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_mvvm2/screens/views/pokemondetail_page/pokemondetail_page.dart';
import 'package:test_mvvm2/screens/views/pokemonlist_view/pokemonlist_page.dart';

import '../../models/pokemonlist_model/pokemon_model.dart';

class AppRouter {
  static String currentRoute = "/";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    currentRoute = settings.name ?? "/";
    switch(settings.name){
      case '/pokemonlist_page':
        return CupertinoPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (_) => const PokemonListPage(),
        );
      case '/pokemondetail_page':
        return CupertinoPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (_) {
            final argument =  settings.arguments as PokemonModel;
            return PokemonDetailPage(pokemonModel: argument);
          },
        );
      default:
        return CupertinoPageRoute(
          settings: RouteSettings(name: settings.name),
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}