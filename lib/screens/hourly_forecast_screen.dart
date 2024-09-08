import 'package:flutter/material.dart';
import '../services/weather_service.dart';
import '../widgets/hourly_forecast_card.dart';

class HourlyForecastScreen extends StatefulWidget {
  final String location;

  HourlyForecastScreen({required this.location});

  @override
  _HourlyForecastScreenState createState() => _HourlyForecastScreenState();
}

class _HourlyForecastScreenState extends State<HourlyForecastScreen> {
  List<HourlyForecast>? _forecastData;

  @override
  void initState() {
    super.initState();
    _fetchHourlyForecast();
  }

  Future<void> _fetchHourlyForecast() async {
    try {
      final data = await WeatherService.getHourlyForecast(widget.location);
      setState(() {
        _forecastData = data;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load hourly forecast')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hourly Forecast'),
        backgroundColor: Colors.blueAccent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.indigo],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: _forecastData == null
          ? Center(
              child: SizedBox(
                height: 60,
                width: 60,
                child: CircularProgressIndicator(
                  strokeWidth: 6,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                ),
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: _forecastData!.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(bottom: 16),
                  child: HourlyForecastCard(forecast: _forecastData![index]),
                );
              },
            ),
    );
  }
}
