import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hakathon/ranking/rankingtbl.dart';
import 'package:hakathon/db/database_helper.dart';
import 'package:hakathon/tabbar/ranking.dart';

List<Rankings> getRankings() {
  List<Rankings> items = <Rankings>[];
  items.add(Rankings("三谷様", "すごい！！！", 2000, "shop_icon.png"));
  items.add(Rankings("ルック様", "頑張る", 2500, "shop_icon.png"));
  items.add(Rankings("池田様", "お疲れ様です。", 1000, "shop_icon.png"));
  items.add(Rankings("林様", "ファイア", 900, "shop_icon.png"));
  items.add(Rankings("山田様", "いい天気ですね", 200, "shop_icon.png"));
  items.add(Rankings("樋高田様", "焼肉を食べたい", 150, "shop_icon.png"));

  items.sort((a, b) => b.point.compareTo(a.point));

  return items;
}

void _refreshJournals() async {
  final allRankings = await SQLHelper.getRankings();
  // items.addAll(allRankings);
}

class RatingBox extends StatefulWidget {
  @override
  _RatingBoxState createState() => _RatingBoxState();
}

class _RatingBoxState extends State<RatingBox> {
  int _rating = 1;
  void _setRatingAsOne() {
    setState(() {
      _rating = 1;
    });
  }

  void _setRatingAsTwo() {
    setState(() {
      _rating = 2;
    });
  }

  void _setRatingAsThree() {
    setState(() {
      _rating = 3;
    });
  }

  Widget build(BuildContext context) {
    double _size = 20;
    // print(_rating);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
          width: 30,
          padding: EdgeInsets.all(0),
          child: IconButton(
            icon: (_rating >= 1
                ? Icon(
                    Icons.star,
                    size: _size,
                  )
                : Icon(
                    Icons.star_border,
                    size: _size,
                  )),
            color: Colors.red[500],
            // onPressed: _setRatingAsOne,
            onPressed: sqlite,
            iconSize: _size,
          ),
        ),
        Container(
          width: 30,
          padding: EdgeInsets.all(0),
          child: IconButton(
            icon: (_rating >= 2
                ? Icon(
                    Icons.star,
                    size: _size,
                  )
                : Icon(
                    Icons.star_border,
                    size: _size,
                  )),
            color: Colors.red[500],
            onPressed: _setRatingAsOne,
            iconSize: _size,
          ),
        ),
        Container(
          width: 30,
          padding: EdgeInsets.all(0),
          child: IconButton(
            icon: (_rating >= 3
                ? Icon(
                    Icons.star,
                    size: _size,
                  )
                : Icon(
                    Icons.star_border,
                    size: _size,
                  )),
            color: Colors.red[500],
            onPressed: _setRatingAsOne,
            iconSize: _size,
          ),
        ),
        Container(
          width: 30,
          padding: EdgeInsets.all(0),
          child: IconButton(
            icon: (_rating >= 4
                ? Icon(
                    Icons.star,
                    size: _size,
                  )
                : Icon(
                    Icons.star_border,
                    size: _size,
                  )),
            color: Colors.red[500],
            onPressed: _setRatingAsOne,
            iconSize: _size,
          ),
        ),
        Container(
          width: 30,
          padding: EdgeInsets.all(0),
          child: IconButton(
            icon: (_rating >= 5
                ? Icon(
                    Icons.star,
                    size: _size,
                  )
                : Icon(
                    Icons.star_border,
                    size: _size,
                  )),
            color: Colors.red[500],
            onPressed: _setRatingAsOne,
            iconSize: _size,
          ),
        )
      ],
    );
  }
}

class RankingsBox extends StatelessWidget {
  RankingsBox({Key? key, required this.item, required this.index})
      : super(key: key);
  final Rankings item;
  int index;

  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(2),
        height: 140,
        child: Card(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: 70,
                  height: 70,
                  margin: EdgeInsets.all(10.0),
                  decoration: index <= 3
                      ? BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('images/ranking_icon.png'),
                          ),
                        )
                      : BoxDecoration(
                          color: Colors.black54,
                        ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      index.toString(),
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
                Image.asset("images/" + this.item.image,
                    fit: BoxFit.cover, width: 80, height: 100),
                Expanded(
                    child: Container(
                        padding: EdgeInsets.all(5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(this.item.name,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(this.item.description),
                            Text("ポイント: " + this.item.point.toString()),
                            RatingBox(),
                          ],
                        )))
              ]),
        ));
  }
}

class RankingRankings extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RankingRankings();
  }
}

List<Rankings> itemsSearch = <Rankings>[];

class _RankingRankings extends State<RankingRankings> {
  // TODO: implement setState
  TextEditingController controller = new TextEditingController();
  // Get json result and convert it to model. Then add

  final items = getRankings();
  Future<Null> getUserDetails() async {
    setState(() {
      itemsSearch.clear();
      itemsSearch.addAll(items);
    });
  }

  @override
  void initState() {
    super.initState();

    getUserDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'MishimaWalk',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: new Column(
        children: <Widget>[
          new Container(
            color: Colors.blue.shade50,
            child: new Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Card(
                child: new ListTile(
                  leading: new Icon(Icons.search),
                  title: new TextField(
                    controller: controller,
                    decoration: new InputDecoration(
                        hintText: '検索', border: InputBorder.none),
                    onChanged: onSearchTextChanged,
                  ),
                  trailing: new IconButton(
                    icon: new Icon(Icons.cancel),
                    onPressed: () {
                      controller.clear();
                      onSearchTextChanged('');
                    },
                  ),
                ),
              ),
            ),
          ),
          new Expanded(
              child: ListView.builder(
            itemCount: itemsSearch.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                child: RankingsBox(item: itemsSearch[index], index: index + 1),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          RankingPage(item: itemsSearch[index]),
                    ),
                  );
                },
              );
            },
          ))
        ],
      ),
    );
  }

  onSearchTextChanged(String text) async {
    itemsSearch.clear();
    if (text.isEmpty) {
      itemsSearch.addAll(items);
      setState(() {});
      return;
    }
    items.forEach((item) {
      if (item.name.contains(text) ||
          item.description.contains(text) ||
          item.point.toString().contains(text)) {
        itemsSearch.add(item);
      }
    });
    // print(items);
    // print("----------");
    setState(() {});
  }
}

class RankingPage extends StatelessWidget {
  RankingPage({Key? key, required this.item}) : super(key: key);
  final Rankings item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.item.name),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "images/" + this.item.image,
                    width: 200,
                    height: 200,
                  ),
                ),
                Expanded(
                    child: Container(
                        padding: EdgeInsets.all(5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(this.item.name,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(this.item.description),
                            Text("Price: " + this.item.point.toString()),
                            RatingBox(),
                          ],
                        )))
              ]),
        ),
      ),
    );
  }
}
