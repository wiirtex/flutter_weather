import 'dart:math';

import 'package:flutter/material.dart';

class Pows2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new Pows2State();
  }
}

class Pows2State extends State {
  @override
  Widget build(BuildContext context) {

    return new ListView.builder(itemBuilder: (context, i){
      if (i.isOdd) return new Divider();
      final int index = i ~/ 2;

      return ListTile(title: new Text("2 ^ $index = ${pow(2, index)}"),);
    });
  }
}

void main() {
  runApp(
    new MaterialApp(
        debugShowCheckedModeBanner: false,
        home: new Scaffold(
            appBar: new AppBar(
              title: new Text("here"),
            ),
            body: new Pows2()
        )
    )
  );
}
