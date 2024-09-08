import 'package:geolocator/geolocator.dart';

class LocationService {
  static Future<Position> getCurrentLocation() async {
    await Geolocator.requestPermission();
    return await Geolocator.getCurrentPosition();
  }
}
