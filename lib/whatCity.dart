import 'dart:math';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'main.dart';
import 'package:http/http.dart' as http;

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
    appBar: new AppBar(
    title: new Text("Lol")
    ),
  body: new ChooseCity(myCity, myCityKey)
    );
  }
}

class PostCity {
  final String city;
  final String cityKey;
  PostCity({this.city, this.cityKey});

  factory PostCity.fromJson(List<dynamic> json) {
    print(json[0]["LocalizedName"]);
    print(json[0]["Key"]);
    return PostCity(
        city: json[0]["LocalizedName"].toString(),
        cityKey: json[0]["Key"].toString()
    );
  }
}

class ChooseCity extends StatefulWidget {
  final String city = myCity;
  final String cityKey = myCityKey;

  ChooseCity (city, cityKey);

  @override
  State<StatefulWidget> createState() {
    return new ChooseCityState();
  }
}

class ChooseCityState extends State<ChooseCity> {
  String city;
  String cityKey;
  final _formKey = GlobalKey<FormState>();

  void pressButton(city) {
    setState(() {
      http.get("http://dataservice.accuweather.com//locations/v1/cities/search?apikey=$accessKey&q=$city").then((response) {
        PostCity cityInformation;
        cityInformation = PostCity.fromJson(jsonDecode(response.body));
        if (cityInformation != null && cityInformation != [])
          this.cityKey = cityInformation.cityKey;
        ChooseCity(city, cityKey);
        myCityKey = cityKey;
        myCity = cityInformation.city;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10.0),
        child: new Form(
            key: _formKey,
            child:
            new Column(
              children: <Widget>[
                new Text('Имя пользователя:', style: TextStyle(fontSize: 20.0),),
                new TextFormField(validator: (value){
                  if (value.isEmpty || value == null) return 'Пожалуйста введите свой город';
                  else {
                    city = value;
                  }
                }),

                new SizedBox(height: 20.0),

                new RaisedButton(onPressed: (){
                  if(_formKey.currentState.validate())
                    Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content:
                          Text('Форма успешно заполнена'),
                          backgroundColor: Colors.green,) );


                  print("Button was pressed $city");
                  if (city != null) {
                    pressButton(city);
                  }
                  else
                    print("city = null (((");
                }, child: Text('Проверить'), color: Colors.blue, textColor: Colors.white,),
              ],
            )
        )
    );
  }
}