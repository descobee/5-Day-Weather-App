import 'package:fifthlab_assessment/core/utilities/api_client.dart';
import 'package:fifthlab_assessment/services/weather_service.dart';
import 'package:get_it/get_it.dart';

/// Instance of GetIt Dependency Injection
final locator = GetIt.instance;

void setupLocator() {
  /// Register API Client
  locator.registerFactory<ApiClient>(ApiClient.new);

/// Register Weather Service Class
  locator.registerLazySingleton<WeatherService>(WeatherService.new);
}
