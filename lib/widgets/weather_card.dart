import 'package:flutter/material.dart';
import 'package:weatherapp/utils/utils.dart';
import '../models/weather_model.dart';

class WeatherCard extends StatelessWidget {
  final WeatherModel weather;
  const WeatherCard({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 10,
      children: [
        Image.network(
          'https://openweathermap.org/img/wn/${weather.icon}@2x.png',
          height: 200,
          width: 200,
          fit: BoxFit.cover,
        ),
        Text(
          weather.description.toString().capitalizeEachWord(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
        Text(
          '${weather.temperature.toStringAsFixed(1)}°',
          style: TextStyle(
            color: Colors.white,
            fontSize: 50,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'Humidity: ${weather.humidity.toStringAsFixed(0)}%',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
