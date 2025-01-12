import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';

class WeatherService {
  final String apiKey = '960b849cf085416efc824a040b0165c8';

  Future<WeatherModel> fetchWeather(String city, String unit) async {
    final currentWeatherUrl =
        'https://api.openweathermap.org/data/2.5/weather?q=$city&units=$unit&appid=$apiKey';

    final forecastUrl =
        'https://api.openweathermap.org/data/2.5/forecast?q=$city&units=$unit&appid=$apiKey';

    try {
      final currentResponse = await http
          .get(Uri.parse(currentWeatherUrl))
          .timeout(const Duration(seconds: 10));
          
      final forecastResponse = await http
          .get(Uri.parse(forecastUrl))
          .timeout(const Duration(seconds: 10));

      if (currentResponse.statusCode == 200 &&
          forecastResponse.statusCode == 200) {
        final currentData = json.decode(currentResponse.body);
        final forecastData = json.decode(forecastResponse.body);

        final currentDate = DateTime.now().add(const Duration(days: 1));
        final dailyForecast = <Map<String, dynamic>>[];

        for (var item in forecastData['list']) {
          final forecastDate = DateTime.parse(item['dt_txt']);
          final isSameDay = dailyForecast.any((entry) {
            final entryDate = DateTime.parse(entry['dt_txt']);
            return entryDate.day == forecastDate.day &&
                entryDate.month == forecastDate.month &&
                entryDate.year == forecastDate.year;
          });

          if (!isSameDay &&
              forecastDate.isAfter(currentDate) &&
              forecastDate.difference(currentDate).inDays < 2) {
            dailyForecast.add(item);
          }
        }

        return WeatherModel.fromJson({
          ...currentData,
          'forecast': dailyForecast,
        });
      } else if (currentResponse.statusCode == 404) {
        throw Exception('City not found. Please try again.');
      } else {
        throw Exception('Unexpected error occurred. Please try again later.');
      }
    } on SocketException {
      throw Exception('No internet connection. Please check your connection.');
    } on TimeoutException {
      throw Exception('Request timed out. Please try again later.');
    } catch (e) {
      throw Exception('Failed to load weather data: $e');
    }
  }
}
