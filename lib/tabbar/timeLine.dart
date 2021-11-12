import 'package:flutter/material.dart';

class timeLine extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _timeLine();
  }
}

class _timeLine extends State<timeLine> {
  @override
  Widget build(BuildContext context) {
    Widget kupont = new Container(
      alignment: Alignment.topLeft,
      margin: new EdgeInsets.only(top: 10.0),
      child:
      Text("クーポン", style: TextStyle(fontWeight: FontWeight.bold)),
    );
    Widget point = new Container(
      alignment: Alignment.topLeft,
      margin: new EdgeInsets.only(top: 10.0),
      child:
      Text("ポイント", style: TextStyle(fontWeight: FontWeight.bold)),
    );

    Widget details = new Container(
      alignment: Alignment.topLeft,
      margin: new EdgeInsets.only(top: 10.0),
      child:new Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child:new Text("詳しいはこちら->", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Expanded(
            flex: 4,
            child:Text("htpps://mishimashi"),
          ),
          Expanded(
            flex: 3,
            child:new Text("...", style: TextStyle(fontWeight: FontWeight.bold)),
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
                Image.asset("images/kupon.png"),
                details,
              ],
            ),
          ),
          new Container(
            child: new Column(
              children: [
                point,
                Image.asset("images/kupon.png"),
                details,
              ],
            ),
          ),
          new Container(
            child: new Column(
              children: [
                kupont,
                Image.asset("images/kupon.png"),
                details,
              ],
            ),
          ),
          new Container(
            child: new Column(
              children: [
                point,
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
