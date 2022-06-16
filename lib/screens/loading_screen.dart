import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import '../services/location.dart';
import '../services/location_data.dart';
import 'location_screen.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double? lat, long;

  Location location = Location();

  void getCurrentLocation() async {
    Position position = await location.getCurrentPosition();
    lat = position.latitude;
    long = position.longitude;
    getDataAndPush();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentLocation();
  }

  void getDataAndPush() async {
    LocationData locationData = LocationData(longitude: long!, latitude: lat!);
    var currentLocationData = await locationData.getCurrentLocationData();
    var fourDaysData = await locationData.getFourDaysData();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(
          currentLocationData: currentLocationData, fourDaysData: fourDaysData);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.orange,
          size: 200,
        ),
      ),
    );
  }
}
