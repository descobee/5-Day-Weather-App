import 'package:fifthlab_assessment/core/utilities/api_client.dart';
import 'package:fifthlab_assessment/core/utilities/service_locator.dart';
import 'package:fifthlab_assessment/model/network_response.dart';
import 'package:fifthlab_assessment/model/weather_model.dart';
import 'package:fifthlab_assessment/model/weather_response_model.dart';
import 'package:fifthlab_assessment/services/network_service.dart';
import 'package:fifthlab_assessment/ui/ui_helpers/helpers.dart';

/// This class serves as an implementation of the [BaseNetworkService].
/// It serves as the service for every weather network feature
/// within the application.
class WeatherService extends BaseNetworkService {
  /// Locator instance of the [ApiClient]
  final _client = locator<ApiClient>();

  final baseUrl = "https://api.openweathermap.org/data/";
  final version = "2.5/";
  final apiKey = "a4ef14af4595858cb248567dc5e63958";

/// This method serves as the network call to get the weather for
/// the user's current locatation.
  Future<NetworkResponse> getWeather(WeatherModel weatherModel) async {
   Helpers.logc("Attempting to fetch weather...");
      try {
      final response = await _client.get(
          "$baseUrl${version}weather?lat=${weatherModel.latitude}&lon=${weatherModel.longitude}&appid=$apiKey");
      Helpers.logc("Response fetched successfuly $response");
      
      Helpers.logc("Parsing response to weather response model...");
      final weather = WeatherResponseModel.fromJson(response);
      Helpers.logc("Parsed response successfuly $weather");
      return NetworkResponse(response: weather);
    } catch (e) {
      Helpers.logc(e.toString());
      return NetworkResponse(error: ErrorResponse(message: e.toString()));
    }
  }


/// This method serves as the network call to get the 5-day 
/// weather forecast for the user's current locatation.
  Future<NetworkResponse> getForecast(WeatherModel weatherModel) async {
    try {
      Helpers.logc("Attempting to fetch the weather forecast...");
      final response = await _client.get(
          "$baseUrl${version}forecast?lat=${weatherModel.latitude}&lon=${weatherModel.longitude}&appid=$apiKey");
      Helpers.logc("Response fetched successfuly $response");
      
      Helpers.logc("Parsing response to weather forecast model...");
      final forecast = WeatherForecastResponseModel.fromJson(response);
      Helpers.logc("Parsed response successfuly $forecast");
      return NetworkResponse(response: forecast);
    } catch (e) {
      Helpers.logc(e.toString());
      return NetworkResponse(error: ErrorResponse(message: e.toString()));
    }
  }

  @override
  Future<void> clear() async {}
}
