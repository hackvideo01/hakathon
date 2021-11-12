import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class quest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _quest();
  }
}

class _quest extends State<quest> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'クエスト',
          style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: new ListView(children: <Widget>[
        new Container(
          child: new Column(
            children: [
              new Container(
                margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'チュートリアルクエスト',
                  ),
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(360, 80),
                      primary: Colors.amber,
                      textStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)
                  ),
                ),
              ),
            ],
          ),
        ),
        new Container(
          child: new Column(
            children: [
              new Container(
                margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    '満喫ルート',
                  ),
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(360, 80),
                      primary: Colors.amberAccent,
                      textStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)
                  ),
                ),
              ),
            ],
          ),
        ),
        new Container(
          child: new Column(
            children: [
              new Container(
                margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    '今季限定企画',
                  ),
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(360, 80),
                      primary: Colors.blueAccent,
                      textStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)
                  ),
                ),
              ),
            ],
          ),
        ),
        new Container(
          child: new Column(
            children: [
              new Container(
                margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    '今季限定',
                  ),
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(360, 80),
                      primary: Colors.green,
                      textStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)
                  ),
                ),
              ),
            ],
          ),
        ),
        new Container(
          child: new Column(
            children: [
              new Container(
                margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'うなぎをたべろ！',
                  ),
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(360, 120),
                      primary: Colors.red,
                      textStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
