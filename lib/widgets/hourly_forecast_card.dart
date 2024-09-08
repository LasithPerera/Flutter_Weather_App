import 'package:flutter/material.dart';
import '../services/weather_service.dart';

class HourlyForecastCard extends StatelessWidget {
  final HourlyForecast forecast;

  HourlyForecastCard({required this.forecast});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      elevation: 4,
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        title: Text(
            '${forecast.time} - ${forecast.temperature.toStringAsFixed(1)}°C'),
        subtitle: Text(forecast.weatherDescription),
        leading: Icon(Icons.cloud,
            color:
                Colors.blueAccent),
      ),
    );
  }
}
