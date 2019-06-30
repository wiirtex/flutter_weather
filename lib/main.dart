import 'dart:math';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'whatCity.dart';
import 'package:http/http.dart' as http;

String myCity = "Ufa";
String myCityKey = "292177";
String accessKey = "Gz8HKO1zorpYGAr2JvUj0VsEY10gFwu9";



class PostWeather {
  final String weatherText;
  final double temperature;

  PostWeather({this.weatherText, this.temperature});

  factory PostWeather.fromJson(List<dynamic> json) {
  print(json[0]["WeatherText"]);
  print(json[0]["Temperature"]["Metric"]["Value"]);
  return PostWeather(
    weatherText: json[0]["WeatherText"].toString(),
    temperature: json[0]["Temperature"]["Metric"]["Value"]
  );
  }
}

class First extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new AccuWeather('wer', 4);
  }
}


class AccuWeather extends StatefulWidget {
  final String _weather;
  final double _temp;
  AccuWeather(this._weather, this._temp);
  @override
  State<StatefulWidget> createState() {
    return new AccuWeatherState(_weather, _temp);
  }
}

class AccuWeatherState extends State<AccuWeather> {
  String _weather;
  double _temperature;

  AccuWeatherState(this._weather, this._temperature);
//TODO make sexy design
  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: EdgeInsets.all(10.0),
      child: new Column(
        children: <Widget>[
          new Text(myCity),
          new SizedBox(height: 25.0,),
          new Text(_weather),
          new SizedBox(height: 25.0,),
          new Text(_temperature.toString()),
          new SizedBox(height: 25.0,),
          new FlatButton(onPressed: () {
            print("Grre");
            PressBtn();
          },
              child: new Text("lol")),
          new SizedBox(height: 25.0,),
          new RaisedButton(
            onPressed: () {
              print("Navigator Push!");
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SecondScreen()));
            }, child: Text('Открыть второе окно')
          )
        ],
      ),
    );
  }

  void PressBtn() {
    setState(() {
      http.get(
          "http://dataservice.accuweather.com/currentconditions/v1/$myCityKey?apikey=$accessKey&language=ru-ru")
          .then((response) {

        PostWeather new_weather;
        new_weather = PostWeather.fromJson(jsonDecode(response.body));
        print(new_weather.weatherText);
        this._weather = new_weather.weatherText;
        this._temperature = new_weather.temperature.toDouble();
        AccuWeatherState(this._weather, this._temperature);
        print("So what");
      }).catchError((error) {
        print("Error $error");
      });
    });
  }
}

void main() {
  runApp(
    new MaterialApp(
        debugShowCheckedModeBanner: false,
        home: new Scaffold(
            appBar: new AppBar(
              title: new Text("Цуферук"),
            ),
            body: new First()
        )
    )
  );
}
