import 'dart:convert';

import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart' as crypto;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/application_constants.dart';
import '../../../network/network_manager.dart';
import '../../home/domain/comicsresult.dart';

class ComicRepository {
  final NetworkManager networkManager;

  late final int timeStamp;
  late final int offset = 0;

  int get getTimestamp => DateTime.now().millisecondsSinceEpoch;
  String get hash {
    timeStamp = getTimestamp;

    return generateMd5(
        '$timeStamp${ApplicationConstants.privateKey}${ApplicationConstants.publicKey}');
  }

  ComicRepository({
    required this.networkManager,
  });
  Future<Comics> fetch() async {
    return await networkManager.apiClient.fetchComics(
        ApplicationConstants.publicKey, hash, timeStamp, offset, 12);
  }

  String generateMd5(String data) {
    var content = const Utf8Encoder().convert(data);
    var md5 = crypto.md5;
    var digest = md5.convert(content);
    return hex.encode(digest.bytes);
  }
}

final comicRepositoryProvider = Provider<ComicRepository>(
    ((ref) => ComicRepository(networkManager: NetworkManager())));

final comicProvider = FutureProvider<Comics>(((ref) {
  return ref.read(comicRepositoryProvider).fetch();
}));
