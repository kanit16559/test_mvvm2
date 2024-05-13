import 'package:get_it/get_it.dart';

import '../../view_models/pokemondetail_viewmodel/pokemondetail_injection.dart';
import '../../view_models/pokemonlist_viewmodel/pokemonlist_injections.dart';
import '../network/dio_network.dart';
import 'log/app_logger.dart';

final GetIt locator = GetIt.instance;

Future<void> initInjections() async {
  await initDioInjections();
  await initPokemonListInjections();
  await initPokemonDetailInjections();
}


Future<void> initDioInjections() async {
  initRootLogger();
  DioNetwork.initDio();
}