class WeatherModel {
  final String city;
  final double temperature;
  final String description;
  final String icon;
  final int humidity;
  final List<Forecast> forecast;

  WeatherModel({
    required this.city,
    required this.temperature,
    required this.description,
    required this.icon,
    required this.humidity,
    required this.forecast,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    final forecastList = (json['forecast'] as List)
        .map((forecastJson) => Forecast.fromJson(forecastJson))
        .toList();

    return WeatherModel(
      city: json['name'] ?? 'Unknown',
      temperature: json['main']['temp']?.toDouble() ?? 0.0,
      description: json['weather'][0]['description'] ?? 'No description',
      icon: json['weather'][0]['icon'] ?? '01d',
      humidity: json['main']['humidity'] ?? 0,
      forecast: forecastList,
    );
  }
}

class Forecast {
  final DateTime date;
  final double temperature;
  final double feelsLike;
  final String description;
  final String icon;
  final int humidity;
  final double windSpeed;

  Forecast({
    required this.date,
    required this.temperature,
    required this.feelsLike,
    required this.description,
    required this.icon,
    required this.humidity,
    required this.windSpeed,
  });

  factory Forecast.fromJson(Map<String, dynamic> json) {
    return Forecast(
      date: DateTime.parse(json['dt_txt']),
      temperature: json['main']['temp']?.toDouble() ?? 0.0,
      feelsLike: json['main']['feels_like']?.toDouble() ?? 0.0,
      description: json['weather'][0]['description'] ?? 'No description',
      icon: json['weather'][0]['icon'] ?? '01d',
      humidity: json['main']['humidity'] ?? 0,
      windSpeed: json['wind']['speed']?.toDouble() ?? 0.0,
    );
  }
}
