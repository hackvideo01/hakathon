import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class homeTab extends StatelessWidget {

  // late final String sentDateJst;
  //
  // get sentDateFormatted  {
  //   initializeDateFormatting("ja_JP");
  //
  //   DateTime datetime = DateTime.parse(sentDateJst); // StringからDate
  //
  //   var formatter = new DateFormat('yyyy/MM/dd(E) HH:mm', "ja_JP");
  //   var formatted = formatter.format(datetime); // DateからString
  //   return formatted;
  // }
  String DayMonth = new DateFormat('MM-dd ( E )','en_US').format(DateTime.now());
  final margin = const EdgeInsets.only(bottom: 10.0, right: 10.0, left: 10.0);

  final TextField _txtwalk = new TextField(
    decoration: new InputDecoration(
      hintText: "徒歩"
    ),
  );

  final backColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width; // Using this line I got the device screen width
    GoogleMapController myController;

    final LatLng _center = const LatLng(45.521563, -122.677433);

    void _onMapCreated(GoogleMapController controller) {
      myController = controller;
    }
    return new Scaffold(
      body: new SafeArea(//I didnt add appbar. this will add necessary padding for status bar.
        child: new Column(
          children: <Widget>[
           new Container(
             child: Text(DayMonth + "の徒歩",style: TextStyle(fontWeight: FontWeight.bold),),
           ),
            new Container(
              child: _txtwalk,
            ),
            new Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 10.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}