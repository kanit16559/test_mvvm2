import 'package:test_mvvm2/core/result/app_result.dart';
import 'package:test_mvvm2/models/pokemondetail_model/pokemondetail_model.dart';

import '../datasource/pokemondetail_datasource.dart';
import '../services/pokemondetail_service.dart';

class PokemonDetailRepository implements PokemonDetailDataSource{

  final PokemonDetailService pokemonDetailService;

  PokemonDetailRepository({
    required this.pokemonDetailService
  });

  @override
  Future<AppResult<PokemonDetailModel>> getDataDetail(int id) {
    return pokemonDetailService.getDataDetail(id);
  }

}