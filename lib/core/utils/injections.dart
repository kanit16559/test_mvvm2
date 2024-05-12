import 'package:get_it/get_it.dart';

import '../../view_models/pokemonlist/pokemonlist_injections.dart';
import '../network/dio_network.dart';
import 'log/app_logger.dart';

final GetIt locator = GetIt.instance;

Future<void> initInjections() async {
  await initDioInjections();
  await initPokemonListInjections();
}


Future<void> initDioInjections() async {
  initRootLogger();
  DioNetwork.initDio();
}