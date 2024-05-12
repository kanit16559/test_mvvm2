

import '../../core/network/dio_network.dart';
import '../../core/utils/injections.dart';
import '../../repository/pokemonlist_repository.dart';
import '../../services/pokemonlist_service.dart';

initPokemonListInjections(){
  locator.registerSingleton<PokemonListService>(PokemonListService(dio: DioNetwork.dio));
  locator.registerSingleton<PokemonListRepository>(PokemonListRepository(pokemonService: locator<PokemonListService>()));
}