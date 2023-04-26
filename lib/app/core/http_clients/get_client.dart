import 'package:crud_agendamento/app/core/exceptions/rest_client_exception.dart';
import 'package:crud_agendamento/app/core/http_clients/rest_client.dart';
import 'package:get/get.dart';

class _GetConnect extends GetConnect {
  _GetConnect(String baseURL) {
    httpClient.baseUrl = baseURL;
  }
}

class GetClient extends RestClient {
  late final _GetConnect _client;
  GetClient() {
    _client = _GetConnect(baseURL);
  }

  @override
  Future get(String path, {Map<String, dynamic>? query}) async {
    final res = await _client.get(path, query: query);
    _exception(res);
    return res.body;
  }

  @override
  Future delete(String path, {Map<String, dynamic>? query}) async {
    final res = await _client.delete(path, query: query);
    _exception(res);
    return res.body;
  }

  @override
  Future post(
    String path, {
    required Map<String, dynamic> data,
    query,
  }) async {
    final res = await _client.post(path, data, query: query);
    _exception(res);
    return res.body;
  }

  @override
  Future put(
    String path, {
    required Map<String, dynamic> data,
    query,
  }) async {
    final res = await _client.put(path, data, query: query);
    _exception(res);
    return res.body;
  }

  void _exception(Response<dynamic> res) {
    if (res.hasError) {
      throw RestClientException(message: res.statusText, code: res.statusCode);
    }
  }
}
