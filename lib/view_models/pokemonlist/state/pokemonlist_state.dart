
import '../../../models/pokemon_model.dart';

enum AppPokemonListStatus { initial, loading, success, failure }

class PokemonListState {
  AppPokemonListStatus status;
  int offset;
  List<PokemonModel>? value;

  PokemonListState({
    this.status = AppPokemonListStatus.initial,
    required this.offset,
    this.value
  });

  PokemonListState copyWith({
    AppPokemonListStatus? status,
    int? offset,
    List<PokemonModel>? value,
  }) {
    return PokemonListState(
      status: status ?? this.status,
      offset: offset ?? this.offset,
      value: value ?? this.value,
    );
  }

  @override
  String toString() {
    return 'PokemonListState(status: $status, value: $value)';
  }
}