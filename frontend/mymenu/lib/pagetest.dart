import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'testmodels.dart';

class ListPage extends StatefulWidget {
  final String plan;
  final String date;
  ListPage({@required this.plan, @required this.date});

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  var itemslist = new ItemsList();

  Future getItems() async {
    String url = 'http://timetable-api-manipal.herokuapp.com/get_item/';
    final res = await http.get(url);
    final jres = json.decode(res.body);
    setState(() {
      //Iterable list = json.decode(res.body);
      itemslist = ItemsList.fromJson(jres);
    });
  }

  void initState() {
    super.initState();
    getItems();
  }

  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List"),
      ),
      body: ListView.builder(
        itemCount: itemslist.items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(itemslist.items[index].plan),
            subtitle: Column(
              children: <Widget>[
                Text(itemslist.items[index].name),
                Text(itemslist.items[index].date),
              ],
            ),
          );
        },
      ),
    );
  }
}
