import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class myPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _myPage();
  }
}

class _myPage extends State<myPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   title: Text(
      //     'マイページ',
      //     style: TextStyle(color: Colors.black),
      //   ),
      //   centerTitle: true,
      // ),
      body: Center(
        child: new Image.asset(
          'images/login-image.png',
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
        ),
      ),
      // new Column(children: <Widget>[
      //   Expanded(
      //     child: Column(
      //       children: <Widget>[
      //
      //       ],
      //     ),
      //   ),
      //   // Container(
      //   //     height: 40,
      //   //     color: Colors.grey
      //   // ),
      //   Expanded(
      //     child: Text("MishimaWalk支払い"),
      //   ),
      // ]),
    );
  }
}
