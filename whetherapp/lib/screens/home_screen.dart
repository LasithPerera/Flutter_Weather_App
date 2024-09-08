import 'package:flutter/material.dart';
import '../services/weather_service.dart';
import '../widgets/weather_card.dart';
import '../widgets/location_selector.dart';
import 'hourly_forecast_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _location = 'Colombo';
  WeatherData? _weatherData;

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    try {
      final data = await WeatherService.getCurrentWeather(_location);
      setState(() {
        _weatherData = data;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load weather data')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.cloud, size: 30, color: Colors.white),
            SizedBox(width: 8),
            Text('Weather App',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.indigo],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, size: 30),
            onPressed: _fetchWeather,
          ),
        ],
      ),
      body: _weatherData == null
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
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.lightBlueAccent, Colors.blueAccent],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(30)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.3),
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    child: LocationSelector(
                      onLocationChanged: (newLocation) {
                        setState(() {
                          _location = newLocation;
                          _fetchWeather();
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: WeatherCard(weatherData: _weatherData!),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  HourlyForecastScreen(location: _location),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blueAccent,
                          padding: EdgeInsets.symmetric(vertical: 15),
                          textStyle: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          minimumSize:
                              Size(double.infinity, 50), // Full width button
                          shadowColor: Colors.blueAccent.withOpacity(0.5),
                          elevation: 5,
                        ),
                        child: Text('View Hourly Forecast'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
