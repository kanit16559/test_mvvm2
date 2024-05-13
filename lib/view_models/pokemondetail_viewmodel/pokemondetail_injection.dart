
import '../../core/network/dio_network.dart';
import '../../core/utils/injections.dart';
import '../../repository/pokemondetail_repository.dart';
import '../../services/pokemondetail_service.dart';

initPokemonDetailInjections(){
  locator.registerSingleton<PokemonDetailService>(PokemonDetailService(dio: DioNetwork.dio));
  locator.registerSingleton<PokemonDetailRepository>(PokemonDetailRepository(pokemonDetailService: locator<PokemonDetailService>()));
}