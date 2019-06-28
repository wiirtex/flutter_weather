import 'package:flutter/material.dart';


class NewsFavourite extends StatefulWidget {
  final int _num;
  final bool _like;

  NewsFavourite(this._num, this._like);

  @override
  State<StatefulWidget> createState() {
    return new NewsFavouriteState(_num, _like);
  }
}

class NewsFavouriteState extends State<NewsFavourite> {
  int num;
  bool like = false;

  NewsFavouriteState(this.num, this.like);

  pressStar() {
    setState(() {
      like = !like;
      like ? num++ : num--;
    });
  }
  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: new EdgeInsets.all(5.0),
      child:    new Column(
        children: <Widget>[
          new Text("Favourite $num"),
          new IconButton(
              icon:
              Icon(
                like ? Icons.star : Icons.star_border,
                size: 30.0,
                color: Colors.blue[500],
              ),
              onPressed: pressStar
          )
        ],
      )
    );
  }
}



class News extends StatelessWidget {
  final String _title;
  final String _text;
  String _imageUrl;
  int _num;
  bool _like;

  News(this._title, this._text, {String imageUrl, num=0, like=false}) {
    _imageUrl = imageUrl;
    _num = num;
    _like = like;
  }

  @override
  Widget build(BuildContext context) {
    if (_imageUrl != '' && _imageUrl != null)
    return Container (
      height: 95.0,
      color: Colors.black12,
      child: new Row(
        children: <Widget>[
          new Image.network(
            _imageUrl,
            width: 95.0,
            height: 95.0,
            fit: BoxFit.cover,),
          new Expanded(
              child:
          new Container(
            padding: new EdgeInsets.all(5.0),
        child: new Column(
        children: <Widget>[
          new Text(_title,
            style: new TextStyle(fontSize: 20.0),
            overflow: TextOverflow.ellipsis,),
          new Expanded(
            child: new Text(_text,
              softWrap: true,
              textAlign: TextAlign.justify,
            )
          )
        ],
        ),
          )
          ),
          new NewsFavourite(_num, _like)
        ],
      ),
    );
    else
      return Container (
        height: 95.0,
        color: Colors.black12,
        child: new Row(
          children: <Widget>[
            new Expanded(
                child:
                new Container(
                  padding: new EdgeInsets.all(5.0),
                  child: new Column(
                    children: <Widget>[
                      new Text(_title,
                        style: new TextStyle(fontSize: 20.0),
                        overflow: TextOverflow.ellipsis,),
                      new Expanded(
                          child: new Text(_text,
                            softWrap: true,
                            textAlign: TextAlign.justify,)
                      )
                    ],
                  ),
                )
            ),
            new NewsFavourite(_num, _like)
          ],
        ),
      );
  }
}
void main() => runApp(
  new MaterialApp(
    debugShowCheckedModeBanner: false
    home: new Scaffold(
      appBar: new AppBar(),
      body: new News('Flutter good', 'Flutter very good', imageUrl: 'https://flutter.su/favicon.png', like: true, num: 97,),
    ),
  )
);
