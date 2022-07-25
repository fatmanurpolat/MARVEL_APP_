import 'package:staj_projectt/src/features/characters/data/character_repository.dart';

import '../core/locator.dart';

class Repositories {
  final characterRepositoryProvider = getIt<CharacterRepository>();
}
