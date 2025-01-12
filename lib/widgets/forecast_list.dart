import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:weatherapp/utils/utils.dart';
import '../models/weather_model.dart';

class ForecastList extends StatelessWidget {
  final List<Forecast> forecast;

  const ForecastList({super.key, required this.forecast});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Forecast for the next 3 days',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
        ),
        ListView.builder(
          itemCount: forecast.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final dayForecast = forecast[index];
            return ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Card(
                elevation: 0,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                color: Colors.white.withOpacity(0.2),
                child: ListTile(
                  leading: Image.network(
                    'https://openweathermap.org/img/wn/${dayForecast.icon}@2x.png',
                    width: 40,
                    height: 40,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${dayForecast.temperature.toStringAsFixed(1)}°C',
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        dayForecast.description,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  trailing: Text(
                    Utils().convertToDayString(dayForecast.date),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
