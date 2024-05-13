
import 'package:test_mvvm2/core/result/app_result.dart';

import '../models/pokemonlist_model/pokemon_model.dart';

abstract class PokemonListDataSource {
  Future<AppResult<List<PokemonModel>>> fetchData(int params);
}