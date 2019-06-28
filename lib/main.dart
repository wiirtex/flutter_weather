import 'dart:math';

import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class MyForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MyFormState();
  }
}

class MyFormState extends State<MyForm> {
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return new Form(
        key:_formkey,
        child:
        new Container(
            child: new Column(
              children: <Widget>[
                new Text("Name", style: new TextStyle(fontSize: 25.0),),
                new TextFormField(
                    validator: (value){
                      if (value == null)
                        return 'Enter yout name';
                    },
                ),

                new SizedBox(height: 20.0,),

                new Text("E-mail", style: new TextStyle(fontSize: 25.0),),
                new TextFormField(
                  validator: (value){
                    if (!EmailValidator.validate(value))
                      return "That's not e-mail";
                  },
                ),

                new SizedBox(height: 20.0,),

                new RaisedButton(onPressed: (){
                  if(_formkey.currentState.validate())
                    Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content:
                          Text('Форма успешно заполнена'
                          ),
                          backgroundColor: Colors.green,
                        )
                    );
                },
                  child:
                  new Text('Проверить'),
                  color: Colors.blue,
                  textColor: Colors.white,
                ),
              ],
            )
        )

    );
  }


}

void main() {
  runApp(
    new MaterialApp(
        debugShowCheckedModeBanner: false,
        home: new Scaffold(
            appBar: new AppBar(
              title: new Text("Form"),
            ),
            body: new MyForm()
        )
    )
  );
}
