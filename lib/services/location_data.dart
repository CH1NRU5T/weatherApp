import 'package:my_weather_app/services/networking.dart';

class LocationData {
  LocationData({required this.latitude, required this.longitude});
  String apiKey = 'a69c69345fe0fbb2e7c89600bd788e1e';
  double latitude;
  double longitude;
  // NetworkHelper networkHelper = NetworkHelper(url: url);

  dynamic getCurrentLocationData() async {
    String currentDataUrl =
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric';
    NetworkHelper networkHelper = NetworkHelper(url: currentDataUrl);
    var currentLocationData = await networkHelper.getData();
    return currentLocationData;
    // print(currentLocationData);
  }

  dynamic getFourDaysData() async {
    String fourDaysDataUrl =
        'https://api.openweathermap.org/data/2.5/forecast?lat=$latitude&lon=$longitude&cnt=4&appid=$apiKey&units=metric';
    NetworkHelper networkHelper = NetworkHelper(url: fourDaysDataUrl);
    var fourDaysData = await networkHelper.getData();
    return fourDaysData;
    // print(fourDaysData);
  }
}
