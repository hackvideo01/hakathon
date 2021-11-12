import 'dart:async';
import 'package:hakathon/secrets.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:address_search_field/address_search_field.dart';


import 'dart:math' show cos, sqrt, asin;

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

  bool _flag = true;

  final LatLng _center = const LatLng(35.11065656736633, 138.91525592742352);

  CameraPosition _initialLocation = CameraPosition(target: LatLng(35.11065656736633, 138.91525592742352),zoom: 18.0,);
  late GoogleMapController mapController;

  late Position _currentPosition;
  String _currentAddress = '';

  final startAddressController = TextEditingController();
  final destinationAddressController = TextEditingController();

  // final startAddressFocusNode = FocusNode();
  final desrinationAddressFocusNode = FocusNode();

  String _startAddress = '';
  String _destinationAddress = '';
  String? _placeDistance;

  Set<Marker> markers = {};

  PolylinePoints polylinePoints = new PolylinePoints();
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Widget _textField({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String label,
    required String hint,
    required double width,
    required Icon prefixIcon,
    Widget? suffixIcon,
    required Function(String) locationCallback,
  }) {
    return Container(
      width: width * 0.8,
      child: TextField(
        onChanged: (value) {
          locationCallback(value);
        },
        controller: controller,
        focusNode: focusNode,
        decoration: new InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(
              color: Colors.grey.shade400,
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(
              color: Colors.blue.shade300,
              width: 2,
            ),
          ),
          contentPadding: EdgeInsets.all(15),
          hintText: hint,
        ),
      ),
    );
  }

  // Method for retrieving the current location
  _getCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      setState(() {
        _currentPosition = position;
        print('CURRENT POS: $_currentPosition');
        mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(position.latitude, position.longitude),
              zoom: 18.0,
            ),
          ),
        );
      });
      await _getAddress();
    }).catchError((e) {
      print(e);
    });
  }

  // Method for retrieving the address
  _getAddress() async {
    try {
      var p = await placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      var place = p[0];

      setState(() {
        _currentAddress =
        " ${place.country}, ${place.postalCode}, ${place.locality},${place.name}";
        startAddressController.text = _currentAddress;
        _startAddress = _currentAddress;
      });
    } catch (e) {
      print(e);
    }
  }

  // Method for calculating the distance between two places
  Future<bool> _calculateDistance() async {
    try {
      // Retrieving placemarks from addresses
      List<Location> startPlacemark = await locationFromAddress(_startAddress);
      List<Location> destinationPlacemark =
      await locationFromAddress(_destinationAddress);

      // Use the retrieved coordinates of the current position,
      // instead of the address if the start position is user's
      // current position, as it results in better accuracy.
      double startLatitude = _startAddress == _currentAddress
          ? _currentPosition.latitude
          : startPlacemark[0].latitude;

      double startLongitude = _startAddress == _currentAddress
          ? _currentPosition.longitude
          : startPlacemark[0].longitude;

      double destinationLatitude = destinationPlacemark[0].latitude;
      double destinationLongitude = destinationPlacemark[0].longitude;

      String startCoordinatesString = '($startLatitude, $startLongitude)';
      String destinationCoordinatesString =
          '($destinationLatitude, $destinationLongitude)';

      // Start Location Marker
      Marker startMarker = Marker(
        markerId: MarkerId(startCoordinatesString),
        position: LatLng(startLatitude, startLongitude),
        infoWindow: InfoWindow(
          title: 'Start $startCoordinatesString',
          snippet: _startAddress,
        ),
        icon: BitmapDescriptor.defaultMarker,
      );

      // Destination Location Marker
      Marker destinationMarker = Marker(
        markerId: MarkerId(destinationCoordinatesString),
        position: LatLng(destinationLatitude, destinationLongitude),
        infoWindow: InfoWindow(
          title: 'Destination $destinationCoordinatesString',
          snippet: _destinationAddress,
        ),
        icon: BitmapDescriptor.defaultMarker,
      );

      // Adding the markers to the list
      markers.add(startMarker);
      markers.add(destinationMarker);

      print(
        'START COORDINATES: ($startLatitude, $startLongitude)',
      );
      print(
        'DESTINATION COORDINATES: ($destinationLatitude, $destinationLongitude)',
      );

      // Calculating to check that the position relative
      // to the frame, and pan & zoom the camera accordingly.
      double miny = (startLatitude <= destinationLatitude)
          ? startLatitude
          : destinationLatitude;
      double minx = (startLongitude <= destinationLongitude)
          ? startLongitude
          : destinationLongitude;
      double maxy = (startLatitude <= destinationLatitude)
          ? destinationLatitude
          : startLatitude;
      double maxx = (startLongitude <= destinationLongitude)
          ? destinationLongitude
          : startLongitude;

      double southWestLatitude = miny;
      double southWestLongitude = minx;

      double northEastLatitude = maxy;
      double northEastLongitude = maxx;

      // Accommodate the two locations within the
      // camera view of the map
      mapController.animateCamera(
        CameraUpdate.newLatLngBounds(
          LatLngBounds(
            northeast: LatLng(northEastLatitude, northEastLongitude),
            southwest: LatLng(southWestLatitude, southWestLongitude),
          ),
          100.0,
        ),
      );

      // Calculating the distance between the start and the end positions
      // with a straight path, without considering any route
      // double distanceInMeters = await Geolocator.bearingBetween(
      //   startLatitude,
      //   startLongitude,
      //   destinationLatitude,
      //   destinationLongitude,
      // );

      await _createPolylines(startLatitude, startLongitude, destinationLatitude,
          destinationLongitude);

      double totalDistance = 0.0;

      // Calculating the total distance by adding the distance
      // between small segments
      for (int i = 0; i < polylineCoordinates.length - 1; i++) {
        totalDistance += _coordinateDistance(
          polylineCoordinates[i].latitude,
          polylineCoordinates[i].longitude,
          polylineCoordinates[i + 1].latitude,
          polylineCoordinates[i + 1].longitude,
        );
      }

      setState(() {
        _placeDistance = totalDistance.toStringAsFixed(2);
        print('DISTANCE: $_placeDistance km');
      });

      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }

  // Formula for calculating distance between two coordinates
  // https://stackoverflow.com/a/54138876/11910277
  double _coordinateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  // Create the polylines for showing the route between two places
  _createPolylines(
      double startLatitude,
      double startLongitude,
      double destinationLatitude,
      double destinationLongitude,
      ) async {
    polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      Secrets.API_KEY, // Google Maps API Key
      PointLatLng(startLatitude, startLongitude),
      PointLatLng(destinationLatitude, destinationLongitude),
      // travelMode: TravelMode.transit,
      travelMode: TravelMode.driving,
      wayPoints: [PolylineWayPoint(location: "$startLatitude,$destinationLongitude")],
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }

    PolylineId id = PolylineId('poly');
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.red,
      points: polylineCoordinates,
      width: 3,
    );
    polylines[id] = polyline;
  }
  String currentAdrressButton = "現在地";
  void _showModal() {
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return new Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new ListTile(
                // leading: new Icon(Icons.music_note),
                title: new ElevatedButton(
                  onPressed: () {},
                  child: Row(
                    children: [
                      Text(
                        '最短ルート',
                      ),
                      new Icon(Icons.attach_money),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(360, 120),
                      primary: Colors.amber,
                      textStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)
                  ),
                ),
              ),
              new ListTile(
                // leading: new Icon(Icons.photo_album),
                title: new ElevatedButton(
                  onPressed: () {},
                  child: Row(
                    children: [
                      Text(
                        '満喫ルート',
                      ),
                      new Icon(Icons.attach_money),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(360, 120),
                      primary: Colors.amber,
                      textStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)
                  ),
                ),
              ),
              new ListTile(
                // leading: new Icon(Icons.videocam),
                title: new ElevatedButton(
                  onPressed: () {},
                  child: Row(
                    children: [
                      Text(
                        '満喫ルート　2！',
                      ),
                      new Icon(Icons.attach_money),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(360, 120),
                      primary: Colors.amber,
                      textStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)
                  ),
                ),
              ),
            ],
          );
        }
    );
  }
  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }
  @override
  Widget build(BuildContext context) {
    (_placeDistance==null)?_placeDistance="0.0":_placeDistance=_placeDistance;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    Widget _DayMonth = new Container(
      alignment: Alignment.topLeft,
      child:
          Text(DayMonth + "の徒歩", style: TextStyle(fontWeight: FontWeight.bold)),
    );
    Widget walkPint = new Container(
      child: new Row(
        children: <Widget>[
          Expanded(flex: 3, child: Text("$_placeDistance",style: TextStyle(decoration: TextDecoration.underline),)),
          Expanded(
              flex: 1,
              child:
                  new Text("km", style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(flex: 3, child: _txtwalkPoint),
          Expanded(
              flex: 1,
              child: new Text("Pt",
                  style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(
              flex: 2,
              child: new ElevatedButton(
                // onPressed: () => setState(() => _flag = !_flag),
                onPressed: () {
                  _showModal();
                },
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
          // Expanded(
          //   flex: 8,
          //   child: new Icon(Icons.my_location_rounded),
          // ),
          Expanded(
            flex: 9,
            child:FlatButton(
              child: new Text(currentAdrressButton),
              color: Colors.green,
              onPressed: () {
                _getAddress();
                currentAdrressButton = _currentAddress;
                _getCurrentLocation();
              },
            )
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
            child:
            _textField(
                label: '目的地未設定',
                hint: 'Choose destination',
                prefixIcon: Icon(Icons.looks_two),
                controller: destinationAddressController,
                focusNode: desrinationAddressFocusNode,
                width: width,
                locationCallback: (String value) {
                  setState(() {
                    _destinationAddress = value;
                  });
                }),
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
    return Container(
    child: new Scaffold(
      resizeToAvoidBottomInset: false,
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
                        onPressed: (_startAddress != '' &&
                            _destinationAddress != '')
                            ? () async {
                          _showModal();
                          // startAddressFocusNode.unfocus();
                          desrinationAddressFocusNode.unfocus();
                          setState(() {
                            if (markers.isNotEmpty) markers.clear();
                            if (polylines.isNotEmpty)
                              polylines.clear();
                            if (polylineCoordinates.isNotEmpty)
                              polylineCoordinates.clear();
                            _placeDistance = null;
                          });

                          _calculateDistance().then((isCalculated) {
                            if (isCalculated) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Distance Calculated Sucessfully'),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Error Calculating Distance'),
                                ),
                              );
                            }
                          });
                        }
                            : null,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'ルート検索'.toUpperCase(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
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
          child: Container(
            height: height,
            width: width,
            child:
            Scaffold(
              resizeToAvoidBottomInset: false,
              body: Stack(
                children: <Widget>[
                  GoogleMap(
                    markers: Set<Marker>.from(markers),
                    initialCameraPosition: _initialLocation,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: false,
                    mapType: MapType.normal,
                    zoomGesturesEnabled: true,
                    zoomControlsEnabled: false,
                    polylines: Set<Polyline>.of(polylines.values),
                    onMapCreated: (GoogleMapController controller) {
                      mapController = controller;
                    },
                  ),
                  SafeArea(
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10.0, bottom: 10.0),
                        child: ClipOval(
                          child: Material(
                            color: Colors.orange.shade100, // button color
                            child: InkWell(
                              splashColor: Colors.orange, // inkwell color
                              child: SizedBox(
                                width: 56,
                                height: 56,
                                child: Icon(Icons.my_location),
                              ),
                              onTap: () {
                                mapController.animateCamera(
                                  CameraUpdate.newCameraPosition(
                                    CameraPosition(
                                      target: LatLng(
                                        _currentPosition.latitude,
                                        _currentPosition.longitude,
                                      ),
                                      zoom: 18.0,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    ),
    );
  }
}
