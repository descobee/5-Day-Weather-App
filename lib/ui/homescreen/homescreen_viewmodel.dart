// ignore_for_file: use_build_context_synchronously

import 'package:fifthlab_assessment/core/constants/app_strings.dart';
import 'package:fifthlab_assessment/core/utilities/service_locator.dart';
import 'package:fifthlab_assessment/model/weather_response_model.dart';
import 'package:fifthlab_assessment/services/weather_service.dart';
import 'package:fifthlab_assessment/ui/landing/landing_viewmodel.dart';
import 'package:fifthlab_assessment/ui/shared_widgets/custom_dialog.dart';
import 'package:fifthlab_assessment/ui/ui_helpers/app_colors.dart';
import 'package:fifthlab_assessment/ui/ui_helpers/helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

ChangeNotifierProvider<HomeScreenViewModel> homescreenProvider =
    ChangeNotifierProvider<HomeScreenViewModel>(
        (ref) => HomeScreenViewModel(ref));

/// This is the View Model class of the [HomescreenView].
class HomeScreenViewModel extends ChangeNotifier {
  HomeScreenViewModel(this.ref);

  final Ref ref;

  final _weatherService = locator<WeatherService>();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool state) {
    _isLoading = state;
    notifyListeners();
  }

// Getter and setter methods for the weather response model
  WeatherResponseModel? _weatherResponseModel;
  WeatherResponseModel? get weatherResponseModel => _weatherResponseModel;
  set weatherResponseModel(WeatherResponseModel? state) {
    _weatherResponseModel = state;
    notifyListeners();
    }


// Getter and setter variable for the weather forecast response model
  late WeatherForecastResponseModel _weatherResponseModelList;
  WeatherForecastResponseModel get weatherResponseModelList =>
      _weatherResponseModelList;
  set weatherResponseModelList(WeatherForecastResponseModel state) {
    _weatherResponseModelList = state;
    notifyListeners();
  }

/// This method is used in fetching the weather for the user's current location
  Future<void> getWeather(BuildContext context) async {
    var controller = ref.watch(landingViewProvider);
    try {
      isLoading = true;
      final response = await _weatherService.getWeather(controller.model!);
      if (response.hasError()) {
        CustomDialog.customDialog(context, () async {
          await _weatherService.getWeather(controller.model!);
        }, AppStrings.weatherFetchError);
      } else {
        Helpers.log("Weather has been successfully fetched!");
        isLoading = false;
        weatherResponseModel = response.response as WeatherResponseModel;
        notifyListeners();
        Helpers.log("Weather model successfully set.");
      }
    } catch (e) {
      Helpers.log(e.toString());
      isLoading = false;
    }
  }


/// This method is used in fetching the weather forecast
/// for the user's current location.
  Future<void> getForecast(BuildContext context) async {
    var controller = ref.watch(landingViewProvider);
    try {
      isLoading = true;
      final response = await _weatherService.getForecast(controller.model!);
      if (response.hasError()) {
        CustomDialog.customDialog(context, () async {
          await _weatherService.getForecast(controller.model!);
        }, AppStrings.forecastFetchError);
      } else {
        Helpers.log("Weather forecast has been successfully fetched!");
        isLoading = false;
        weatherResponseModelList =
            response.response as WeatherForecastResponseModel;
        Helpers.log("Weather forecast model successfully set!");
      }
    } catch (e) {
      isLoading = false;
    }
  }

/// Returns the string value of the weather image that will
/// be used in the homescreen.
  String weatherImage(String value) {
    switch (value) {
      case '01d':
        return AppStrings.sunny;
      case '02d':
        return AppStrings.cloudy;
      case '03d':
        return AppStrings.cloudy;
      case '04d':
        return AppStrings.cloudy;
      case '09d':
        return AppStrings.rainy;
      case '10d':
        return AppStrings.rainy;
      case '11d':
        return AppStrings.rainy;
      case '13d':
        return AppStrings.rainy;
      case '50d':
        return AppStrings.rainy;
      case '01n':
        return AppStrings.sunny;
      case '02n':
        return AppStrings.cloudy;
      case '10n':
        return AppStrings.rainy;
    }
    return AppStrings.sunny;
  }

/// Returns the string value of the scaffold color that will
/// be used in the homescreen.
  Color weatherColor(String value) {
    switch (value) {
      case '01d':
        return AppColors.sunny;
      case '02d':
        return AppColors.cloudy;
      case '03d':
        return AppColors.cloudy;
      case '04d':
        return AppColors.cloudy;
      case '09d':
        return AppColors.rainy;
      case '10d':
        return AppColors.rainy;
      case '11d':
        return AppColors.rainy;
      case '13d':
        return AppColors.rainy;
      case '50d':
        return AppColors.rainy;
      case '01n':
        return AppColors.sunny;
      case '02n':
        return AppColors.cloudy;
      case '10n':
        return AppColors.rainy;
    }
    return AppColors.sunny;
  }


/// Returns the string value of the weather icon that will
/// be used in the homescreen.
  String weatherIcons(String value) {
    switch (value) {
      case '01d':
        return AppStrings.clearIcon;
      case '02d':
        return AppStrings.partlySunnyIcon;
      case '03d':
        return AppStrings.partlySunnyIcon;
      case '04d':
        return AppStrings.partlySunnyIcon;
      case '09d':
        return AppStrings.rainIcon;
      case '10d':
        return AppStrings.rainIcon;
      case '11d':
        return AppStrings.rainIcon;
      case '13d':
        return AppStrings.rainIcon;
      case '50d':
        return AppStrings.rainIcon;
      case '01n':
        return AppStrings.clearIcon;
      case '02n':
        return AppStrings.partlySunnyIcon;
      case '10n':
        return AppStrings.rainIcon;
    }
    return AppStrings.clearIcon;
  }
}
