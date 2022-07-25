import 'dart:convert';
import 'dart:developer';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

//import 'package:fms_flutter/core/init/cache/shared_preferences_manager.dart';

class CoreDio with DioMixin implements Dio {
  @override
  final BaseOptions options;
  late InterceptorsWrapper _tokenInterceptor;

  CoreDio(this.options) {
    options = this.options;

    _setTokenInterceptor();
    interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        print('********************');
        print('REQUEST: ${options.method} | ${options.uri}');
        print('Headers');
        log(options.headers.toString());
        print('Body');
        log(options.data.toString());
        print('********************');
        /*if (await CommonHelper.isTokenExpired()) {
          refreshToken(options, handler);
        } else {
          return handler.next(options);
        }*/
        return handler.next(options);
        //TODO: refresh token aktif edilecek
      },
      onResponse: (response, handler) {
        print('********************');
        print('RESPONSE');
        log('STATUS ${response.statusCode}');
        log(response.data.toString());
        print('********************');
        return handler.next(response);
      },
      onError: (error, handler) {
        print('********************');
        print('ERROR');
        print('STATUS ${error.response?.statusCode}');
        print(error.response);
        log(error.response?.data.toString() ?? '');
        print('********************');
        return handler.next(error);
      },
    ));

    interceptors.add(this._tokenInterceptor);
    httpClientAdapter = DefaultHttpClientAdapter();
  }

  _setTokenInterceptor() {
    this._tokenInterceptor = InterceptorsWrapper(onRequest: (options, handler) {
      options.headers["Authorization"] = "Bearer token";
      return handler.next(options);
    });
  }

  deleteToken() {
    this.interceptors.remove(this._tokenInterceptor);
  }

  updateToken(String token) async {
    this.interceptors.remove(this._tokenInterceptor);
    this._tokenInterceptor = InterceptorsWrapper(onRequest: (options, handler) {
      options.headers["Authorization"] = "Bearer " + token;
    });
    this.interceptors.add(this._tokenInterceptor);
  }

  Future<void> refreshToken(
      RequestOptions options, RequestInterceptorHandler handler) async {
    print('******************** REFRESH TOKEN ********************');
  }
}
