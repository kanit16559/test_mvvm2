import 'package:flutter/material.dart';
import 'package:test_mvvm2/repository/pokemondetail_repository.dart';
import 'package:test_mvvm2/view_models/pokemondetail_viewmodel/state/pokemondetail_state.dart';

import '../../core/result/app_result.dart';
import '../../models/pokemondetail_model/pokemondetail_model.dart';

class PokemonDetailViewModel extends ChangeNotifier {

  final PokemonDetailRepository pokemonDetailRepository;

  PokemonDetailViewModel({
    required this.pokemonDetailRepository
  }) {
    initState();
  }

  PokemonDetailState get state => _state;

  late PokemonDetailState _state;

  void initState(){
    _state = PokemonDetailState(
      status: AppPokemonDetailStatus.initial,
    );
  }

  int sumMaximumStats(List<Stats> states){
    int max = 200;
    Stats getValue = states.reduce((value, element) => value.baseStat > element.baseStat ? value : element);
    max = getValue.baseStat;
    return max;
  }


  Future<void> getDataDetail(int id) async{

    _state = _state.copyWith(
      status: AppPokemonDetailStatus.loading
    );
    notifyListeners();
    final AppResult<PokemonDetailModel> appResult = await pokemonDetailRepository.getDataDetail(id);

    appResult.whenWithResult((result) {
      _state = _state.copyWith(
        status: AppPokemonDetailStatus.success,
        value: result.value
      );
    }, (error) {
      _state = _state.copyWith(
        status: AppPokemonDetailStatus.failure,
        value: null
      );
    });
    notifyListeners();
  }



}


