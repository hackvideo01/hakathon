import 'package:flutter/material.dart';
import 'package:hakathon/tabbar/ranking.dart';
import 'tabbar/homeTab.dart';
import 'tabbar/myPage.dart';
import 'tabbar/quest.dart';
import 'tabbar/timeLine.dart';
import 'ranking/ranking.dart';
import 'tabbar/payment.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 6,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          // appBar: AppBar(
          //   backgroundColor: Colors.white,
          //   title: Text(
          //     'MishimaWalk',
          //     style: TextStyle(color: Colors.black),
          //   ),
          //   centerTitle: true,
          // ),
          bottomNavigationBar: menu(),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              new homeTab(),
              new timeLine(),
              new quest(),
              new RankingRankings(title: "ranking"),
              new payment(),
              new myPage(),
            ],
          ),
        ),
      ),
    );
  }

  Widget menu() {
    return Container(
      color: Color(0xFFFFFF),
      child: TabBar(
        labelColor: Colors.black,
        unselectedLabelColor: Colors.black,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: EdgeInsets.all(5.0),
        indicatorColor: Colors.blue,
        labelStyle: TextStyle(fontSize: 5.5, fontFamily: 'Family Name'),
        tabs: [
          Tab(
            text: "ホーム",
            icon: Icon(Icons.water_damage_outlined),
          ),
          Tab(
            text: "タイムライン",
            icon: Icon(Icons.access_time),
          ),
          Tab(
            text: "クエスト",
            icon: Icon(Icons.map_outlined),
          ),
          Tab(
            text: "ランキング",
            icon: Icon(Icons.search),
          ),
          Tab(
            text: "支払い",
            icon: Icon(Icons.receipt),
          ),
          Tab(
            text: "マイページ",
            icon: Icon(Icons.person_rounded),
          ),
        ],
      ),
    );
  }
}
