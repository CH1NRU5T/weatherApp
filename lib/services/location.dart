import 'package:geolocator/geolocator.dart';

class Location {
  LocationPermission? locationPermission;
  Future getCurrentPosition() async {
    try {
      locationPermission = await Geolocator.requestPermission();
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      print(position);
      return position;
    } catch (e) {
      print(e);
    }
  }
}
