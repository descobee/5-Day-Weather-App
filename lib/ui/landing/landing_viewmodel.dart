import 'package:fifthlab_assessment/core/constants/app_strings.dart';
import 'package:fifthlab_assessment/model/weather_model.dart';
import 'package:fifthlab_assessment/ui/ui_helpers/helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location/location.dart';

ChangeNotifierProvider<LandingViewModel> landingViewProvider =
    ChangeNotifierProvider<LandingViewModel>((ref) => LandingViewModel(ref));


/// This is the View Model class of the [LandingView].
class LandingViewModel extends ChangeNotifier {
  LandingViewModel(this.ref);

  final Ref ref;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool state) {
    _isLoading = state;
    notifyListeners();
  }

// Getter and setter methods for the weather model used in querying the network requests.
  WeatherModel? _model;
  WeatherModel? get model => _model;
  set model(WeatherModel? state) {
    _model = state;
    notifyListeners();
  }

/// This method is used in requesting permission for a
/// user's current location.
  Future<void> getUserLocation() async {
    try {
      isLoading = true;
      bool serviceEnabled = await Location.instance.serviceEnabled();
      if (!serviceEnabled) {
        bool isRequestGranted = await Location.instance.requestService();
        if (!isRequestGranted) {
          Helpers.log(AppStrings.requestNotGranted);
        }
      }
      PermissionStatus status = await Location.instance.hasPermission();
      if (status == PermissionStatus.denied) {
        status = await Location.instance.requestPermission();
        if (status != PermissionStatus.granted) {
          Helpers.log(AppStrings.requestNotGranted);
        }
      }
      isLoading = false;
    } catch (e) {
      isLoading = false;
      Helpers.log(AppStrings.locationFetchError);
    }
  }


/// This method is used in setting a user's current location.
  Future<void> setLocation() async {
    getUserLocation();
    final userLocation = await Location.instance.getLocation();
    _model = WeatherModel(
        latitude: userLocation.latitude!, longitude: userLocation.longitude!);
  }
}
