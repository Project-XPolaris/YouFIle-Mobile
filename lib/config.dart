class ApplicationConfig {
  static final ApplicationConfig _singleton = ApplicationConfig._internal();
  String serviceUrl;
  String username;
  String token;

  factory ApplicationConfig() {
    return _singleton;
  }

  ApplicationConfig._internal();
}
