import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class homeTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _homeTab();
  }
}

class _homeTab extends State<homeTab> {
  String DayMonth =
      new DateFormat('MM/dd ( E )', 'en_US').format(DateTime.now());
  final margin = const EdgeInsets.only(bottom: 10.0, right: 10.0, left: 10.0);

  final TextField _txtwalk = new TextField(
    decoration: new InputDecoration(
        // hintText: "徒歩"
        ),
  );

  final TextField _txtwalkPoint = new TextField(
    decoration: new InputDecoration(
        // hintText: "Pt"
        ),
  );

  final TextField _txtCurentLocation = new TextField(
    decoration: new InputDecoration(
      hintText: "現在地",
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.green,
        ),
      ),
    ),
  );

  final TextField _txtTargetLocation = new TextField(
    decoration: new InputDecoration(
      hintText: "目的地　未設定",
      // contentPadding: new EdgeInsets.all(10.0),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.green,
        ),
      ),
    ),
  );

  final backColor = Colors.white;
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(35.11065656736633, 138.91525592742352);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  bool _flag = true;

  @override
  Widget build(BuildContext context) {
    Widget _DayMonth = new Container(
      alignment: Alignment.topLeft,
      child:
          Text(DayMonth + "の徒歩", style: TextStyle(fontWeight: FontWeight.bold)),
    );
    Widget walkPint = new Container(
      child: new Row(
        children: <Widget>[
          Expanded(flex: 3, child: _txtwalk),
          Expanded(
              flex: 1,
              child:
                  new Text("歩", style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(flex: 3, child: _txtwalkPoint),
          Expanded(
              flex: 1,
              child: new Text("Pt",
                  style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(
              flex: 2,
              child: new ElevatedButton(
                onPressed: () => setState(() => _flag = !_flag),
                child: Text("交換"),
                style: ElevatedButton.styleFrom(
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                  primary: _flag
                      ? Colors.red
                      : Color(0x0C547B), // This is what you need!
                ),
              )),
        ],
      ),
    );
    Widget Transfer = new Container(
      child: new Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: new Icon(Icons.add_circle_outline_sharp),
          ),
          Expanded(
              flex: 1,
              child: new Text("経由地",
                  style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(
            flex: 3,
            child: Text(""),
          ),
          Expanded(
            flex: 1,
            child: Text(""),
          ),
          Expanded(
            flex: 2,
            child: new Icon(Icons.import_export_sharp),
          ),
        ],
      ),
    );
    Widget CurentLocation = new Container(
      margin: new EdgeInsets.only(left: 5.5, right: 20.0, top: 5.0),
      height: 35.0,
      child: new Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: new Icon(Icons.my_location_rounded),
          ),
          Expanded(
            flex: 9,
            child: _txtCurentLocation,
          ),
        ],
      ),
    );
    Widget TargetLocation = new Container(
      margin: new EdgeInsets.only(left: 5.5, right: 20.0, top: 2.0),
      height: 35.0,
      child: new Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: new Icon(Icons.stop_circle_rounded),
          ),
          Expanded(
            flex: 9,
            child: _txtTargetLocation,
          ),
        ],
      ),
    );
    Widget Rout = new Container(
      child: new Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: new Icon(Icons.format_list_bulleted_rounded),
          ),
          Expanded(
              flex: 2,
              child: new Text("ルート検索条件",
                  style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(
            flex: 3,
            child: Text(""),
          ),
          Expanded(
            flex: 1,
            child: Text(""),
          ),
        ],
      ),
    );
    Widget Condition = new Container(
      child: new Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Column(
              children: <Widget>[
                new Icon(Icons.transfer_within_a_station),
                new Text("歩き", style: TextStyle(fontSize: 10.0)),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: <Widget>[
                new Icon(Icons.train_rounded),
                new Text("電車", style: TextStyle(fontSize: 10.0)),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: <Widget>[
                new Icon(Icons.directions_bus_filled_rounded),
                new Text("バス", style: TextStyle(fontSize: 10.0)),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: <Widget>[
                new Icon(Icons.car_rental),
                new Text("車", style: TextStyle(fontSize: 10.0)),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: <Widget>[
                new Icon(Icons.local_taxi),
                new Text("タクシー", style: TextStyle(fontSize: 10.0)),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: <Widget>[
                new Icon(Icons.power_input_outlined),
                new Text("その他の", style: TextStyle(fontSize: 10.0)),
              ],
            ),
          ),
        ],
      ),
    );
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'MishimaWalk',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: new Column(children: <Widget>[
        Expanded(
          child: Column(
            children: <Widget>[
              _DayMonth,
              walkPint,
              new Container(
                child: CurentLocation,
              ),
              Transfer,
              new Container(
                // margin: new EdgeInsets.only(left: 20.0, right: 20.0,top: 5.0),
                // decoration: new BoxDecoration(
                //     color: new Color.fromARGB(255, 240, 240, 240),
                //     border: new Border.all(width: 1.2,color: Colors.black12),
                //     borderRadius: const BorderRadius.all(const Radius.circular(10.0))
                // ),
                child: TargetLocation,
              ),
              Rout,
              Condition,
              new Container(
                margin: new EdgeInsets.only(left: 20.0, right: 20.0, top: 2.0),
                child: new Row(
                  children: <Widget>[
                    new Expanded(
                      child: new ElevatedButton(
                        onPressed: () => setState(() => _flag = !_flag),
                        child: Text("ルート検索"),
                        style: ElevatedButton.styleFrom(
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                          primary: _flag
                              ? Colors.red
                              : Color(0x0C547B), // This is what you need!
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
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
              zoom: 13.0,
            ),
          ),
        ),
      ]),
    );
  }
}
