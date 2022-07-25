import 'package:get_it/get_it.dart';

import '../features/characters/data/character_repository.dart';
import '../features/characters/domain/marvelresult.dart';
import '../network/network_manager.dart';

final getIt = GetIt.I;
void setup() {
  getIt.registerLazySingleton(() => NetworkManager());
  getIt.registerLazySingleton(
      () => CharacterRepository(networkManager: getIt<NetworkManager>()));
}
