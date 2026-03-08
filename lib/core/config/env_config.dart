class EnvConfig {
  const EnvConfig({
    required this.apiBaseUrl,
    required this.environment,
  });

  final String apiBaseUrl;
  final String environment;

  static Future<EnvConfig> load() async {
    return const EnvConfig(
      apiBaseUrl: String.fromEnvironment(
        'API_BASE_URL',
        defaultValue: 'https://api.example.com',
      ),
      environment: String.fromEnvironment(
        'APP_ENV',
        defaultValue: 'dev',
      ),
    );
  }
}
