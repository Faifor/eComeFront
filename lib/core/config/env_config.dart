enum BuildFlavor {
  dev,
  stage,
  prod,
}

class EnvConfig {
  const EnvConfig({
    required this.apiBaseUrl,
    required this.environment,
    required this.flavor,
  });

  final String apiBaseUrl;
  final String environment;
  final BuildFlavor flavor;

  static Future<EnvConfig> load() async {
    const environment = String.fromEnvironment(
      'APP_ENV',
      defaultValue: 'dev',
    );

    return EnvConfig(
      apiBaseUrl: const String.fromEnvironment(
        'API_BASE_URL',
        defaultValue: 'https://api.example.com',
      ),
      environment: environment,
      flavor: BuildFlavorX.fromEnvironment(environment),
    );
  }
}

extension BuildFlavorX on BuildFlavor {
  static BuildFlavor fromEnvironment(String environment) {
    switch (environment) {
      case 'prod':
        return BuildFlavor.prod;
      case 'stage':
        return BuildFlavor.stage;
      case 'dev':
      default:
        return BuildFlavor.dev;
    }
  }
}
