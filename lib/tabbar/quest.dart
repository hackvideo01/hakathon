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
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: new Column(children: <Widget>[
        Expanded(
          child: Column(
            children: <Widget>[

            ],
          ),
        ),
        // Container(
        //     height: 40,
        //     color: Colors.grey
        // ),
        Expanded(
          child: Text("クエスト"),
        ),
      ]),
    );
  }
}
