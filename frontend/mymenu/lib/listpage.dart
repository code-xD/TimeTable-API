import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

class Item {
  final String plan;
  final String name;
  final String date;
  final String foodcourt;

  Item(this.plan, this.name, this.date, this.foodcourt);
}

class ListPage extends StatefulWidget {
  final String plan;
  final String date;
  final String fc;
  ListPage({@required this.plan, @required this.date, @required this.fc});

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {

  Future<List<Item>> _getItems() async {
    var data = await http.get(
        "http://timetable-api-manipal.herokuapp.com/get_item/?item_food_plan=${widget.plan}&item_name=&item_date=${widget.date}&item_foodcourt=${widget.fc}");

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
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.orange),
        title: Text(
          widget.plan.toLowerCase(),
          style: TextStyle(
            color: Colors.orange,
            fontSize: 30,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.only(top: 5.0),
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
                  Color color;
                  Color textColor;
                  if (index % 2 == 0) {
                    color = Colors.orange[500];
                    textColor = Colors.white;
                  } else {
                    color = Colors.grey[50];
                    textColor = Colors.orange[500];
                  }
                  /* return Container(
                    height: 150.0,
                    child: Card(
                      elevation: 4.0,
                      color: color,
                      child: ListTile(
                        title: Text(
                          snapshot.data[index].name,
                          style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 30,
                          ),
                        ),
                      ),
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(15.0)),
                      ),
                  ); */
                  return CreateCard(
                    color: color,
                    textColor: textColor,
                    name: snapshot.data[index].name,
                    foodcourt: snapshot.data[index].foodcourt
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

class CreateCard extends StatelessWidget {
  final Color color;
  final Color textColor;
  final String name;
  final String foodcourt;

  CreateCard({
    this.color, 
    this.textColor,
    this.name,
    this.foodcourt,
  });

  @override 
  Widget build(BuildContext context) {
    return new Container(
      child: Stack(
        children: <Widget>[
          Container(
            height: 150,
            //margin: EdgeInsets.all(10.0),
            child: Card(
              elevation: 4.0,
              color: color,
              child: ListTile(
                title: Text(
                  name,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 30,
                  ),
                ),
              ),
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(15.0)),
            ),
          ),
          Container(
            height: 150.0,
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
            alignment: Alignment.bottomRight,
            child: Text(
              foodcourt,
              style: TextStyle(
                color: textColor,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            )
          )
        ],
      )
    );
  }
}
