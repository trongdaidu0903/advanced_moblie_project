import 'package:myapp_lettutors/envs/dev.dart' as dev;
import 'package:myapp_lettutors/envs/product.dart' as product;

enum Environment { dev, product }

class EnvironmentConfig {
  static Environment _currentEnvironment = Environment.dev;

  static void setEnvironment(Environment environment) {
    _currentEnvironment = environment;
  }

  static String get apiUrl {
    switch (_currentEnvironment) {
      case Environment.dev:
        return dev.apiUrl;
      case Environment.product:
        return product.apiUrl;
      default:
        return dev.apiUrl;
    }
  }
}
