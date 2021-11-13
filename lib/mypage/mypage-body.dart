import 'dart:math';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class MypageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ProfilePic(),
        Container(
          margin: new EdgeInsets.all(5),
          padding: new EdgeInsets.all(5),
          child: new Column(
            children: <Widget>[
              new SizedBox(
                height: 25,
                child: Text(
                  "佐藤　良太様",
                  style: TextStyle(
                      fontFamily: "Arial",
                      fontSize: 16,
                      height: 1,
                      color: Colors.white),
                ),
              ),
              new SizedBox(
                height: 26,
                child: Text(
                  "プラチナ",
                  style: TextStyle(
                      fontFamily: "Arial",
                      fontSize: 24,
                      height: 1,
                      color: Colors.white),
                ),
              ),
              SizedBox(
                height: 20,
                child: Text(
                  "特典 >",
                  style: TextStyle(
                      fontFamily: "Arial",
                      fontSize: 14,
                      height: 1,
                      color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        GaugeEclip(),
        new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                // padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Text("12,00歩/25,000歩",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    )),
              ),
            ),
            // Text("クーポン交換履歴",
            //     style: TextStyle(
            //       fontSize: 18,
            //       fontWeight: FontWeight.bold,
            //       color: Colors.orange[700],
            //     )),
          ],
        ),
      ],
    );
  }
}

class ProfilePic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 115,
      width: 115,
      margin: new EdgeInsets.all(5),
      padding: new EdgeInsets.all(5),
      child: Stack(
        fit: StackFit.expand,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage("images/avata.png"),
          ),
          // Positioned(
          //   child: SizedBox(
          //     height: 46,
          //     width: 46,
          //     child: flatbu(
          //       onPressed: () {},
          //       // child: svgPic,
          //     ),
          // ))
        ],
      ),
    );
  }
}

class GaugeEclip extends StatelessWidget {
  // const GaugeEclip({
  //   Key? key,
  // }) : super(key: key);
  double _volumeValue = 40;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: new EdgeInsets.all(0),
        padding: new EdgeInsets.all(0),
        child: SfRadialGauge(
          axes: <RadialAxis>[
            RadialAxis(
                minimum: 0,
                maximum: 100,
                showLabels: false,
                showTicks: false,
                axisLineStyle: AxisLineStyle(
                  cornerStyle: CornerStyle.bothFlat,
                  color: Colors.yellowAccent[50],
                  thickness: 60,
                ),
                // minimum: 0,
                // maximum: 25000,
                pointers: <GaugePointer>[
                  RangePointer(
                    value: _volumeValue,
                    cornerStyle: CornerStyle.bothFlat,
                    width: 60,
                    color: Colors.yellow,
                    sizeUnit: GaugeSizeUnit.logicalPixel,
                  )
                ],
                annotations: <GaugeAnnotation>[
                  GaugeAnnotation(
                      angle: 90,
                      axisValue: 5,
                      positionFactor: 0.2,
                      widget: Text(_volumeValue.ceil().toString(),
                          style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)))
                ])
          ],
        ));
  }
}
