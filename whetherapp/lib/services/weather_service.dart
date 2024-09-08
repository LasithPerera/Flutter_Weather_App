import 'dart:convert';
import 'package:http/http.dart' as http;

const String apiKey = 'dc3af3d5f7204f4f800175829240709';
const String baseUrl = 'https://api.weatherapi.com/v1';

class WeatherService {
  static Future<WeatherData?> getCurrentWeather(String location) async {
    final response = await http
        .get(Uri.parse('$baseUrl/current.json?key=$apiKey&q=$location'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return WeatherData.fromJson(data);
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  static Future<List<HourlyForecast>?> getHourlyForecast(
      String location) async {
    final response = await http.get(
        Uri.parse('$baseUrl/forecast.json?key=$apiKey&q=$location&hours=24'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['forecast']['forecastday'][0]['hour'] as List)
          .map((item) => HourlyForecast.fromJson(item))
          .toList();
    } else {
      throw Exception('Failed to load hourly forecast');
    }
  }
}

class WeatherData {
  final String location;
  final double temperature;
  final String weatherDescription;

  WeatherData(
      {required this.location,
      required this.temperature,
      required this.weatherDescription});

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      location: json['location']['name'],
      temperature: json['current']['temp_c'].toDouble(),
      weatherDescription: json['current']['condition']['text'],
    );
  }
}

class HourlyForecast {
  final String time;
  final double temperature;
  final String weatherDescription;

  HourlyForecast(
      {required this.time,
      required this.temperature,
      required this.weatherDescription});

  factory HourlyForecast.fromJson(Map<String, dynamic> json) {
    return HourlyForecast(
      time: json['time'],
      temperature: json['temp_c'].toDouble(),
      weatherDescription: json['condition']['text'],
    );
  }
}
