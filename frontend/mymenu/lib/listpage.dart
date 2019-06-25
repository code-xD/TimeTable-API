import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ListPage extends StatefulWidget {
  final String plan;
  final String date;
  ListPage({@required this.plan, @required this.date});

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  Future<List<Item>> _getItems() async {
    var data = await http.get(
        "http://timetable-api-manipal.herokuapp.com/get_item/?item_food_plan=${widget.plan}&item_name=&item_date=${widget.date}&item_food_court=");

    var jsonData = json.decode(data.body);

    List<Item> items = [];

    for (var u in jsonData) {
      Item item = Item(u["item_food_plan"], u["item_name"], u["item_date"],
          u["item_foodcourt"]);
      items.add(item);
    }
    print(items.length);
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "MyMenu",
          style: TextStyle(color: Colors.white),
        ),
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
      ),
      body: Container(
        child: FutureBuilder(
          future: _getItems(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.data.length == 0) {
              return Center(child: Text("Menu hasn't been uploaded yet"));
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: ListTile(
                      title: Text(
                        snapshot.data[index].name,
                        style: TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      subtitle: Text(snapshot.data[index].foodcourt),
                    ),
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(15.0)),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

class Item {
  final String plan;
  final String name;
  final String date;
  final String foodcourt;

  Item(this.plan, this.name, this.date, this.foodcourt);
}
