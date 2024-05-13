import 'package:test_mvvm2/models/pokemondetail_model/pokemondetail_model.dart';

enum AppPokemonDetailStatus { initial, loading, success, failure }

class PokemonDetailState {
  AppPokemonDetailStatus status;
  PokemonDetailModel? value;

  PokemonDetailState({
    required this.status,
    this.value
  });


  PokemonDetailState copyWith({
    AppPokemonDetailStatus? status,
    PokemonDetailModel? value
  }){
    return PokemonDetailState(
      status: status ?? this.status,
      value: value ?? this.value
    );
  }

}