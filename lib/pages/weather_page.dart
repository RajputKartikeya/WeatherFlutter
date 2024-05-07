import 'package:flutter/material.dart';
import 'package:weatherapp/service/weather_service.dart';
import '../models/weather_model.dart';
import 'package:lottie/lottie.dart';
class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  //api key

  final _weatherService=WeatherService('c2fcc3861254237b175e3916a1d197eb');
  Weather? _weather;

  //fetch weather
  _fetchWeather() async{
    // get the current city
    String cityName= await _weatherService.getCurrentCity();

    //get weather for city

    try{
      final weather =await _weatherService.getWeather(cityName);
      setState(() {
        _weather=weather;
      });
    }
    catch(e){
      print(e);
    }
  }
  //weather animation
  String getWeatherAnimation(String ? mainCondition){
    if(mainCondition==null) return 'assets/sunny.json'; //default to sunny

    switch(mainCondition.toLowerCase()){
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
        case 'dust':
        case 'fog':
          return 'assets/cloud.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
      return 'assets/rain.json';
      case 'thunderstrom':
        return 'assets/thunder.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';


    }
  }
  //intial state
  @override
  void initState(){
    super.initState();

    //fetch weather on startup
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
        child:Column(
          mainAxisAlignment:MainAxisAlignment.center,
          children:[
            //city name
            Text(_weather?.cityName ?? "loading city..."),
            //weather animation
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
            //temperature
            Text('${_weather?.temperature.round()}°C'),
            //weather condition
            Text(_weather?.mainCondition ?? "")
          ],
        ),
      )
    );
  }
}
