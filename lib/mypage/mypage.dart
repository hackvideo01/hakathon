import 'package:flutter/material.dart';
import 'package:hakathon/mypage/mypage-body.dart';
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
        body: new ListView(
      children: <Widget>[
        new Container(
          color: Colors.orange[700],
          child: new Padding(
            padding: const EdgeInsets.all(8.0),
            child: MypageBody(),
          ),
        ),
        new Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Text("ご利用可能なポイント",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange[700],
                    )),
              ),
            ),
            Text("クーポン交換履歴",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange[700],
                )),
          ],
        ),
        new Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Text("50,917",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ),
          ],
        ),
        new Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Text("合計ポイント",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange[700],
                    )),
              ),
            ),
          ],
        ),
        new Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Text("240,666",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ),
          ],
        ),
      ],
    )
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
