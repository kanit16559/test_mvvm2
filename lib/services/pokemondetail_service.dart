
import 'package:dio/dio.dart';
import 'package:test_mvvm2/core/result/app_result.dart';
import 'package:test_mvvm2/models/pokemondetail_model/pokemondetail_model.dart';

import '../core/utils/constant.dart';
import '../datasource/pokemondetail_datasource.dart';

class PokemonDetailService implements PokemonDetailDataSource {
  final Dio dio;

  PokemonDetailService({
    required this.dio
  });

  @override
  Future<AppResult<PokemonDetailModel>> getDataDetail(int id) async{
    try{
      final response = await dio.get("${Constant.baseUrl}/pokemon/$id");
      final getData = response.data as Map<String, dynamic>;
      PokemonDetailModel pokemonDetailModel = PokemonDetailModel.fromJson(getData);
      return Success(value: pokemonDetailModel);
    }on DioException catch(error){
      return Error(dioException: error, errorObject: error.response?.data);
    }catch(error){
      return Error(errorMessage: "$error");
    }
  }

}