import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:test_mvvm2/view_models/pokemonlist_viewmodel/state/pokemonlist_state.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../core/result/app_result.dart';
import '../../models/pokemonlist_model/pokemon_model.dart';
import '../../repository/pokemonlist_repository.dart';

class PokemonListViewModel extends ChangeNotifier {
  final PokemonListRepository pokemonListRepository;

  PokemonListViewModel({
    required this.pokemonListRepository,
  }) {
    initState();
  }

  PokemonListState get state => _state;

  late PokemonListState _state;

  RefreshController get refreshController => _refreshController;

  final RefreshController _refreshController = RefreshController();

  final int _offSet = 21;

  void initState(){
    _state = PokemonListState(
      offset: 0,
    );
  }

  Future<void> fetchData({bool isNewFetch = false}) async {
    if(isNewFetch == true){
      _state = _state.copyWith(
          status: AppPokemonListStatus.loading,
          value: [],
          offset: 0
      );
      notifyListeners();
    }

    final AppResult<List<PokemonModel>> appResult = await pokemonListRepository.fetchData(_state.offset);

    appResult.whenWithResult((result) {
      List<PokemonModel>? listValue = [];
      if(_state.value == null || _state.value!.isEmpty){
        listValue = List.from(result.value);
      }else{
        listValue.addAll(_state.value!);
        listValue.addAll(result.value);
      }

      _state = _state.copyWith(
        status: AppPokemonListStatus.success,
        offset: result.value.isEmpty ? _state.offset : _state.offset + _offSet,
        value: listValue,
      );
    }, (error) {
      _state = _state.copyWith(status: AppPokemonListStatus.failure);
    });

    notifyListeners();
  }

  void onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    await fetchData(isNewFetch: true);
    _refreshController.refreshCompleted();
  }

  void onLoading() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    await fetchData();
    _refreshController.loadComplete();
  }

}