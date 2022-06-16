import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:my_weather_app/services/location_data.dart';
import '../main.dart';
import 'package:my_weather_app/constants.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen(
      {required this.currentLocationData, required this.fourDaysData});

  var currentLocationData;
  var fourDaysData;

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  List<Color> backgroundColor = cloudy;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialiseData();
  }

  double? temperature;
  double? windSpeed;
  int? humidity;
  String? cityName;
  String? iconUrl;
  String? weatherDescription;
  List<String> fourDaysDataTime = [];
  List fourDaysDataIconUrl = [];
  List<double> fourDaysDataTemperature = [];

  void initialiseData() {
    setState(() {
      temperature = widget.currentLocationData['main']['temp'] + 0.0;
      windSpeed = widget.currentLocationData['wind']['speed'] + 0.0;
      humidity = widget.currentLocationData['main']['humidity'];
      cityName = widget.currentLocationData['name'];
      iconUrl =
          'https://openweathermap.org/img/wn/${widget.currentLocationData['weather'][0]['icon']}@4x.png';
      weatherDescription = widget.currentLocationData['weather'][0]['main'];
      for (int i = 0; i < 3; i++) {
        fourDaysDataTime.add(DateFormat('MMM dd \nhh:mm a').format(
            DateTime.fromMillisecondsSinceEpoch(
                (widget.fourDaysData['list'][i]['dt'] * 1000).toInt())));
        fourDaysDataIconUrl.add(
            'https://openweathermap.org/img/wn/${widget.fourDaysData['list'][i]['weather'][0]['icon']}@4x.png');
        fourDaysDataTemperature
            .add(widget.fourDaysData['list'][i]['main']['temp'] + 0.0);
      }
      backgroundColor =
          getGradient(widget.currentLocationData['weather'][0]['id']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        textTheme: TextTheme(
          bodyText2: TextStyle(
            color: Color(0xff2B2F60),
          ),
        ),
      ),
      home: Scaffold(
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: backgroundColor),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Row(
                    textBaseline: TextBaseline.ideographic,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: Icon(
                          FontAwesomeIcons.locationDot,
                          color: Color(0xff2B2F60),
                          size: 30,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          cityName ?? 'cityName',
                          style: TextStyle(
                              color: Color(0xff2B2F60),
                              fontWeight: FontWeight.bold,
                              fontSize: 30),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                ), // top row
                MainContainer(
                    windSpeed: windSpeed,
                    humidity: humidity,
                    temperature: temperature,
                    weatherDescription: weatherDescription,
                    iconUrl: iconUrl), // mid container
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FourDayContainer(
                        iconUrl: fourDaysDataIconUrl[0],
                        temp: fourDaysDataTemperature[0].toInt(),
                        time: fourDaysDataTime[0]),
                    FourDayContainer(
                        iconUrl: fourDaysDataIconUrl[1],
                        temp: fourDaysDataTemperature[1].toInt(),
                        time: fourDaysDataTime[1]),
                    FourDayContainer(
                        iconUrl: fourDaysDataIconUrl[2],
                        temp: fourDaysDataTemperature[2].toInt(),
                        time: fourDaysDataTime[2]),
                  ],
                ), // four days row
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WindAndHumidity extends StatelessWidget {
  WindAndHumidity({required this.windSpeed, required this.humidity});

  double windSpeed;
  int humidity;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                FontAwesomeIcons.wind,
                color: Colors.black54,
                size: 20,
              ),
              Text(
                '${windSpeed} km/hr',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                FontAwesomeIcons.droplet,
                color: Colors.black54,
                size: 20,
              ),
              Text(
                '$humidity%',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class MainContainer extends StatelessWidget {
  MainContainer(
      {required this.windSpeed,
      required this.humidity,
      required this.temperature,
      required this.weatherDescription,
      required this.iconUrl});

  double? temperature;
  double? windSpeed;
  int? humidity;
  String? iconUrl;
  String? weatherDescription;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        // decoration: BoxDecoration(color: Colors.red[200]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //1) how is weather icon
            Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    color: Colors.black45,
                    offset: Offset(1, 2),
                    spreadRadius: 0,
                    blurRadius: 70,
                    blurStyle: BlurStyle.normal),
              ]),
              child: Image.network(
                iconUrl!,
                height: 150,
                width: 150,
                fit: BoxFit.fill,
              ),
            ),
            // 2) how is weather desc
            Text(
              '$weatherDescription',
              style: TextStyle(
                color: Color(0xff2B2F60),
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            // 3) temp
            Text(
              '${temperature!.toInt().toString()}°',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 70,
                color: Color(0xff2B2F60),
                fontWeight: FontWeight.bold,
              ),
            ),
            // 4) row
            WindAndHumidity(
              humidity: humidity!,
              windSpeed: windSpeed!,
            ),
            // a) windspeed
            // b) humidity
          ],
        ),
      ),
    );
  }
}

class FourDayContainer extends StatelessWidget {
  FourDayContainer(
      {required this.iconUrl, required this.temp, required this.time});

  String time;
  String iconUrl;
  int temp;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(bottom: 50, left: 9, right: 9),
        padding: EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0x65ffffff),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              time.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            Image.network(iconUrl),
            Text(
              '${temp.toString()}°',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
