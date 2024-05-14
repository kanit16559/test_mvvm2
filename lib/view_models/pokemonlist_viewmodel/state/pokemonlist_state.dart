
import '../../../models/pokemonlist_model/pokemon_model.dart';

enum AppPokemonListStatus { initial, loading, success, failure }

class PokemonListState {
  AppPokemonListStatus status;
  int offset;
  List<PokemonModel>? value;
  List<PokemonModel>? mainValue;

  PokemonListState({
    this.status = AppPokemonListStatus.initial,
    required this.offset,
    this.value,
    this.mainValue,
  });

  PokemonListState copyWith({
    AppPokemonListStatus? status,
    int? offset,
    List<PokemonModel>? value,
    List<PokemonModel>? mainValue,
  }) {
    return PokemonListState(
      status: status ?? this.status,
      offset: offset ?? this.offset,
      value: value ?? this.value,
      mainValue: mainValue ?? this.mainValue,
    );
  }

  @override
  String toString() {
    return 'PokemonListState(status: $status, value: $value)';
  }
}