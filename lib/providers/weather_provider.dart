import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import '../services/weather_service.dart';

class WeatherProvider extends ChangeNotifier {
  WeatherModel? _weather;
  bool _isLoading = false;
  String _unit = 'metric'; // 'metric' for Celsius, 'imperial' for Fahrenheit
  String? _errorMessage;

  WeatherModel? get weather => _weather;
  bool get isLoading => _isLoading;
  String get unit => _unit;
  String? get errorMessage => _errorMessage;

  void switchUnit() {
    _unit = _unit == 'metric' ? 'imperial' : 'metric';
    fetchWeather('Bhopal');
    notifyListeners();
  }

  Future<void> fetchWeather(String city) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final weatherService = WeatherService();
      _weather = await weatherService.fetchWeather(city, _unit);
    } catch (e) {
      _errorMessage = e.toString();
      _weather = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
