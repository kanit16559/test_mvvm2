

import '../core/result/app_result.dart';
import '../models/pokemondetail_model/pokemondetail_model.dart';

abstract class PokemonDetailDataSource {
  Future<AppResult<PokemonDetailModel>> getDataDetail(int id);
}