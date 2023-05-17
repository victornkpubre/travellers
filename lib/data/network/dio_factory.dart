

import 'package:dio/dio.dart';
import 'package:travellers/app/app_constants.dart';
import 'package:travellers/app/app_pref.dart';

const String APPLICATION_JSON = "application/json";
const String CONTENT_TYPE = "content-type";
const String ACCEPT = "accept";
const String AUTHORIZATION = "authorization";
const String DEFAULT_LANGUAGE = "language";

class DioFactory {
  AppPreferences _appPreferences;
  DioFactory(this._appPreferences);


  Future<Dio> getDio() async {
    Dio dio = Dio();
    int _timeout = 1;

    String? token = await _appPreferences.getUserToken();

    Map<String, String> headers = {
      CONTENT_TYPE: APPLICATION_JSON,
      ACCEPT:APPLICATION_JSON,
      AUTHORIZATION: token??AppConstants.token,
    };

    dio.options = BaseOptions (
      baseUrl: AppConstants.baseUrl,
      connectTimeout: Duration(minutes: _timeout),
      receiveTimeout: Duration(minutes: _timeout),
      headers: headers
    );

    return dio;
  }
}
