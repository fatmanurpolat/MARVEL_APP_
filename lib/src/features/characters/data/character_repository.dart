import 'dart:convert';

// ignore: depend_on_referenced_packages
import 'package:convert/convert.dart';
// ignore: depend_on_referenced_packages
import 'package:crypto/crypto.dart' as crypto;
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/application_constants.dart';
import '../../../network/network_manager.dart';
import '../character_id/character_id.dart';
import '../domain/marvelresult.dart';

class CharacterRepository extends ChangeNotifier {
  final NetworkManager networkManager;

  int timeStamp = 0;
  int offset = 0;

  int get getTimestamp => DateTime.now().millisecondsSinceEpoch;
  String get hash {
    timeStamp = getTimestamp;

    return generateMd5(
        '$timeStamp${ApplicationConstants.privateKey}${ApplicationConstants.publicKey}');
  }

  CharacterRepository({
    required this.networkManager,
  });
  Future<MarvelResult> fetch() async {
    print('fetchhhh offset: $offset');
    final result = await networkManager.apiClient.fetchCharacters(
        ApplicationConstants.publicKey, hash, timeStamp, offset, 20);

    //istek başarılı ise offset 20 arttırılır
    if (result.code == 200) {
      offset = offset + 20;
      notifyListeners();
    } else {
      throw Exception("Error status code: ${result.code}");
    }

    return result;
  }

  Future<CharacterId> fetchCharacterDetails(String characterId) async {
    print('fetchhhh offset: $offset');
    final result = await networkManager.apiClient.fetchCharacterDetail(
        characterId, ApplicationConstants.publicKey, hash, timeStamp);

    //istek başarılı ise offset 20 arttırılır
    if (result.code == 200) {
      notifyListeners();
    } else {
      throw Exception("Error status code: ${result.code}");
    }

    return result;
  }

  String generateMd5(String data) {
    var content = const Utf8Encoder().convert(data);
    var md5 = crypto.md5;
    var digest = md5.convert(content);
    return hex.encode(digest.bytes);
  }
}

final characterRepositoryProvider = Provider<CharacterRepository>(((ref) {
  return CharacterRepository(networkManager: NetworkManager());
}));

final charactersProvider = FutureProvider<MarvelResult>(((ref) {
  return ref.read(characterRepositoryProvider).fetch();
}));

final charPagesProvider =
    FutureProvider<List<MarvelResultDataResults>>(((ref) async {
  final List<MarvelResultDataResults> chars = [];
  final repo = ref.watch(characterRepositoryProvider);
  final result = (await repo.fetch()).data?.results;
  chars.addAll(result as List<MarvelResultDataResults>);
  return chars;
}));

final charactersDetailProvider =
    FutureProvider.autoDispose.family<CharacterId, String>(((ref, characterId) {
  return ref
      .read(characterRepositoryProvider)
      .fetchCharacterDetails(characterId);
}));
