import 'package:dio/dio.dart';

import '../constants/application_constants.dart';
import 'client.dart';
import 'core_dio.dart';

class NetworkManager {
  late APIClient apiClient;
  late Dio _coreDio;
  static const _timeout = 60000;

  NetworkManager() {
    final baseOptions = BaseOptions(
      baseUrl: ApplicationConstants.baseUrl,
      connectTimeout: _timeout,
      receiveTimeout: _timeout,
    );

    _coreDio = CoreDio(baseOptions);
    apiClient = APIClient(_coreDio);
  }
}
