import 'package:flutter/material.dart';
import '../services/weather_service.dart';

class WeatherCard extends StatelessWidget {
  final WeatherData weatherData;

  WeatherCard({required this.weatherData});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16),
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          children: [
            CustomPaint(
              size: Size(double.infinity, 200),
              painter: WavePainter(),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.white,
                        size: 30,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          weatherData.location,
                          style:
                              Theme.of(context).textTheme.headline5!.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),

                  Row(
                    children: [
                      Icon(
                        Icons.thermostat_outlined,
                        color: Colors.white,
                        size: 30,
                      ),
                      SizedBox(width: 10),
                      Text(
                        '${weatherData.temperature}°C',
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(
                        Icons.cloud,
                        color: Colors.white,
                        size: 30,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          weatherData.weatherDescription,
                          style:
                              Theme.of(context).textTheme.subtitle1!.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  // Additional Design Element
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      'Updated now',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontStyle: FontStyle.italic,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blueAccent
      ..style = PaintingStyle.fill;

    final path = Path()
      ..lineTo(0, size.height - 40)
      ..quadraticBezierTo(
        size.width / 4,
        size.height,
        size.width / 2,
        size.height - 40,
      )
      ..quadraticBezierTo(
        3 * size.width / 4,
        size.height - 80,
        size.width,
        size.height - 40,
      )
      ..lineTo(size.width, 0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
