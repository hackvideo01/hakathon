import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class homeTab extends StatelessWidget{
  String DayMonth = new DateFormat('MM/dd ( E )','en_US').format(DateTime.now());
  final margin = const EdgeInsets.only(bottom: 10.0, right: 10.0, left: 10.0);
  final TextField _txtwalk = new TextField(
    decoration: new InputDecoration(
        hintText: "徒歩"
    ),
  );

  final backColor = Colors.white;
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(35.11065656736633, 138.91525592742352);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          Expanded(
              child: _txtwalk,
          ),
          // Container(
          //     height: 40,
          //     color: Colors.grey
          // ),
          Expanded(
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 11.0,
                ),
              ),
          ),
        ]
    );
  }
}