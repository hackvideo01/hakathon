// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hakathon/timeLineList.dart';
import 'package:intl/intl.dart';
import 'package:hakathon/timeLineData.dart';
import 'package:geolocator/geolocator.dart';

class timeLine extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _timeLine();
  }
}

class _timeLine extends State<timeLine> {
  Position _location = Position(latitude: 0.0, longitude: 0.0);

  void _displayCurrentLocation() async {
    final location = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _location = location;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget kupont = new Container(
      alignment: Alignment.topLeft,
      margin: new EdgeInsets.only(top: 10.0),
      child: Text("クーポン", style: TextStyle(fontWeight: FontWeight.bold)),
    );
    Widget point = new Container(
      alignment: Alignment.topLeft,
      margin: new EdgeInsets.only(top: 10.0),
      child: Text("ポイント", style: TextStyle(fontWeight: FontWeight.bold)),
    );
    // Widget link = new InkWell(
    //     child: new Text('https://mishimawalk/image21/〜'),
    //     onTap: () => launch('https://strategic.jp')
    // );
    Widget details = new Container(
      alignment: Alignment.topLeft,
      margin: new EdgeInsets.only(top: 10.0),
      child: new Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: new Text("詳しいはこちら->",
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Expanded(
            flex: 4,
            child: Text("htpps://mishimashi"),
          ),
          Expanded(
            flex: 3,
            child:
                new Text("...", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'タイムライン',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: new ListView(
        children: [
          new Container(
            child: new Column(
              children: [
                kupont,
                // FlatButton(
                //   child: new Text("${_location.latitude}, ${_location.longitude}"),
                //   color: Colors.green,
                //   onPressed: () {
                //     _displayCurrentLocation();
                //   },
                // )
                Image.asset("images/kupon.png"),
                details,
              ],
            ),
          ),
          new Container(
            child: new Column(
              children: [
                point,
                // FlatButton(
                //   child: new Text("${_location.latitude}, ${_location.longitude}"),
                //   color: Colors.green,
                //   onPressed: () {
                //     _displayCurrentLocation();
                //   },
                // )
                Image.asset("images/kupon.png"),
                details,
              ],
            ),
          ),
          new Container(
            child: new Column(
              children: [
                kupont,
                // FlatButton(
                //   child: new Text("${_location.latitude}, ${_location.longitude}"),
                //   color: Colors.green,
                //   onPressed: () {
                //     _displayCurrentLocation();
                //   },
                // )
                Image.asset("images/kupon.png"),
                details,
              ],
            ),
          ),
          new Container(
            child: new Column(
              children: [
                point,
                // FlatButton(
                //   child: new Text("${_location.latitude}, ${_location.longitude}"),
                //   color: Colors.green,
                //   onPressed: () {
                //     _displayCurrentLocation();
                //   },
                // )
                Image.asset("images/kupon.png"),
                details,
              ],
            ),
          )
        ],
      ),
    );
  }
}
