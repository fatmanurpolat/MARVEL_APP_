import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../features/characters/character_id/character_id.dart';
import '../features/characters/domain/marvelresult.dart';
import '../features/home/domain/comicsresult.dart';
import '../features/home/domain/eventresult.dart';

part 'client.g.dart';

// *** CLIENT *** //
@RestApi(baseUrl: "")
abstract class APIClient {
  factory APIClient(Dio dio, {String baseUrl}) = _APIClient;

  // ===== GET ===== //
  @GET('v1/public/characters')
  Future<MarvelResult> fetchCharacters(
    @Query("apikey") String apiKey,
    @Query("hash") String hash,
    @Query("ts") int ts,
    @Query("offset") int offset,
    @Query("limit") int limit,
  );

  @GET('/v1/public/characters/{characterId}')
  Future<CharacterId> fetchCharacterDetail(
    @Path("characterId") String characterId,
    @Query("apikey") String apiKey,
    @Query("hash") String hash,
    @Query("ts") int ts,
  );
  @GET('v1/public/events')
  Future<EventResult> fetchEvent(
    @Query("apikey") String apiKey,
    @Query("hash") String hash,
    @Query("ts") int ts,
  );
  @GET('v1/public/comics')
  Future<Comics> fetchComics(
    @Query("apikey") String apiKey,
    @Query("hash") String hash,
    @Query("ts") int ts,
    int offset,
    int i,
  );
}
