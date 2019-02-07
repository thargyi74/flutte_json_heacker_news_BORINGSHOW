import 'dart:async';

import 'package:flutter/material.dart';

//import 'json_parsing.dart';
import 'src/article.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // TBS: Import articles from static data (fixtures)
  List<Article> _articles = articles;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: RefreshIndicator(
        child: new ListView(
          children: _articles.map(_buildItem).toList(),
        ),
        onRefresh: _handleRefresh,
      ),
    );
  }

  Future<Null> _handleRefresh() async {
    print("Mockup Data Change to simulate a Refresh: note setState");
    setState(() {
      print("Removing country data for: ${_articles[0].text}");
      _articles.removeAt(0);
    });

    print("Handling Refresh: 3 second delay!");
    await new Future.delayed(new Duration(seconds: 3));
  }

  Widget _buildBottomRow(Article article) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        new Text(
          "Flag: ",
          style: TextStyle(fontSize: 12.0),
        ),
        new IconButton(
            icon: new Icon(Icons.image),
            onPressed: () async {
              final fakeUrl = "http://${article.domain}";
              if (await canLaunch(fakeUrl)) {
                launch(fakeUrl);
              }
            }),
      ],
    );
  }

  Widget _buildItem(Article item) {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new ExpansionTile(
        title: new Text(
          "${item.text}, ${item.by} / ${item.age} subregion",
          style: new TextStyle(
            fontSize: 22.0,
            color: Colors.blueGrey,
          ),
        ),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: new Text(
                "The population of ${item.text} is distributed over a ${item.age} sq km area. The national currency is the ${item.domain}. Official language(s): ${item.score}."),
          ),
          _buildBottomRow(item),
        ],
      ),
    );
  }
}
