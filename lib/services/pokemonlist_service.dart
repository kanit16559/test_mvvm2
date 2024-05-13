

import 'package:dio/dio.dart';
import 'package:test_mvvm2/core/result/app_result.dart';
import 'package:test_mvvm2/datasource/pokemonlist_datasource.dart';
import 'package:test_mvvm2/models/pokemonlist_model/pokemon_model.dart';

import '../core/utils/constant.dart';

class PokemonListService implements PokemonListDataSource {

  final Dio dio;

  PokemonListService({
    required this.dio
  });

  final pathUrl = "/pokemon?limit=21";

  @override
  Future<AppResult<List<PokemonModel>>> fetchData(int params) async {
    try{
      final response = await dio.get("${Constant.baseUrl}$pathUrl&offset=$params");
      final pokemonListInMap = response.data["results"] as List<dynamic>;
      List<PokemonModel> data = pokemonListInMap.map((userMap) => PokemonModel.fromJson(userMap as Map<String, dynamic>)).toList();
      return Success(value: data);
    }on DioException catch(error){
      return Error(dioException: error, errorObject: error.response?.data);
    }


    // return pokemonListInMap.map((userMap) => PokemonModel.fromJson(userMap as Map<String, dynamic>)).toList();
  }

}