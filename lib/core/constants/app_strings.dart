class AppStrings {
  /// Singleton instance of class [AppStrings]
  AppStrings._();

  // App Icons
  static const String clearIcon = "assets/icons/clear.png";
  static const String partlySunnyIcon = "assets/icons/partlysunny.png";
  static const String rainIcon = "assets/icons/rain.png";

  // App Images
  static const String sunny = "assets/images/forest_sunny.png";
  static const String rainy = "assets/images/forest_rainy.png";
  static const String cloudy = "assets/images/forest_cloudy.png";

  static const String requestNotGranted =
      "Location access has not been granted";
  static const String locationFetchError = "Failed to get your location";
  static const String weatherFetchError =
      "Failed to get the weather for your location";
  static const String forecastFetchError =
      "Failed to get the weather forecast for your location";
  static const String alert = "Notice!";
  static const String retry = 'Retry';
  static const String cancel = 'Cancel';
  static const String currentTemp = "Current";
  static const String minTemp = "Min";
  static const String maxTemp = "Max";
}
