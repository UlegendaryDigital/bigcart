enum Flavor { dev, staging, prod }

class AppConfig {
  const AppConfig({
    required this.flavor,
    required this.apiBaseUrl,
  });

  final Flavor flavor;
  final String apiBaseUrl;

  static const AppConfig dev = AppConfig(
    flavor: Flavor.dev,
    apiBaseUrl: 'https://api.dev.bigcart.example',
  );
}
