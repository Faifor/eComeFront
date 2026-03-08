class AppHttpClient {
  AppHttpClient({required this.baseUrl});

  final String baseUrl;

  Future<Map<String, dynamic>> get(String path) async {
    return <String, dynamic>{
      'method': 'GET',
      'url': '$baseUrl$path',
    };
  }
}
