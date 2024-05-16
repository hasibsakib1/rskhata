import 'package:dio/dio.dart';

import '../../main.dart';
import '../api.dart';
import '../shared_pref.dart';


class RequestBase {

  Dio dio = Dio();

  Future<dynamic> get(String url) async {
    dio.options = await getOptions();
    final response = await dio.get(url);
    log.i(response.data); 
    return response;
  }

  Future<dynamic> post(String url, dynamic data) async {
    dio.options = await getOptions();
    final response = await dio.post(url, data: data);
    log.i(response.data); 
    return response;
  }

  Future<dynamic> delete(String url) async {
    final response = await dio.delete(url);
    log.i(response.data); 
    return response;
  }

  Future<BaseOptions> getOptions() async{
    final apiToken = await getApiToken();
    print(apiToken);
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl, 
      headers: {
        'Authorization' : 'Bearer $apiToken'
      },
    );
    return options;
  }

  Future<String> getApiToken() async{
    final apiKey = await SharedPref.getString("api_key") ?? "";
    return apiKey;
  }
}