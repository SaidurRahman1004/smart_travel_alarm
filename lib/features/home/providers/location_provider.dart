import 'package:flutter/cupertino.dart';
import 'package:smart_travel_alarm/constants/app_strings.dart';

import '../../../services/location_service.dart';

//enum for location state
enum LocationFetchState { initial, loading, success, error }

class LocationProvider extends ChangeNotifier {
  final LocationService _locationService = LocationService();
  //Display Location in Screen
  String _displayAddress = "";
  String get displayAddress => _displayAddress;
//error
  String _errorMessage = "";
  String get errorMessage => _errorMessage;

  LocationFetchState _state = LocationFetchState.initial;
  LocationFetchState get state => _state;

  Future<void> fetchLocationAndAddress() async {
    //set loading state initially
    _state = LocationFetchState.loading;
    notifyListeners();
    final result = await _locationService.getLocation();
    if (result.hasError) {
      _state = LocationFetchState.error;
      _errorMessage = result.error ?? AppStrings.errorOcrd;
      debugPrint(" Location Error: $_errorMessage");
    }else{
      _state = LocationFetchState.success;
      _displayAddress = result.address ?? AppStrings.UknLocation;
      debugPrint(" Location fetched: $_displayAddress");
    }
    notifyListeners();
  }
  //restart
  void resetState() {
    _state = LocationFetchState.initial;
    notifyListeners();
  }
}
