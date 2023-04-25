abstract class RestClient {
  final baseURL = 'https://6446899b0431e885f01501b3.mockapi.io/api/v1/schedule';

  Future<dynamic> get(String path, {Map<String, dynamic>? query});
  Future<dynamic> post(String path,
      {required Map<String, dynamic> data, Map<String, dynamic>? query});
  Future<dynamic> put(String path,
      {required Map<String, dynamic> data, Map<String, dynamic>? query});
  Future<dynamic> delete(String path, {Map<String, dynamic>? query});
}
