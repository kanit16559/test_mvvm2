

import 'package:test_mvvm2/core/result/app_result.dart';
import 'package:test_mvvm2/datasource/pokemonlist_datasource.dart';
import 'package:test_mvvm2/models/pokemon_model.dart';
import 'package:test_mvvm2/services/pokemonlist_service.dart';

class PokemonListRepository implements PokemonListDataSource {

  final PokemonListService pokemonService;

  PokemonListRepository({
    required this.pokemonService
  });

  @override
  Future<AppResult<List<PokemonModel>>> fetchData(int params) {
    return pokemonService.fetchData(params);
  }

}