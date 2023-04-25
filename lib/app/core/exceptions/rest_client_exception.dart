class RestClientException implements Exception {
  final int? code;
  final String? message;
  RestClientException({
    this.message = "Algo deu errado",
    this.code,
  });

  @override
  String toString() => 'RestClientException(code: $code, message: $message)';
}
