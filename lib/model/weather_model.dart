
/// This class is used in assigning the query parameters
/// for fetching the weather and forecast for a paticular location.
/// This was done to make the network calls less cumbersome and tidy.
class WeatherModel {
  final double latitude;
  final double longitude;
  WeatherModel({
    required this.latitude,
    required this.longitude,
  });
}