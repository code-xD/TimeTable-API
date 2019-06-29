import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'listpage.dart';
import 'devpage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FoodCourt {
  final String name;

  FoodCourt(this.name);
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime selectedDate = DateTime.now();
  String date = DateFormat('yyyy-MM-dd').format(DateTime.now());
  List<String> plans = ["Breakfast", "Lunch", "Snacks", "Dinner"];
  String selectedPlan = "Breakfast";
  String selectedFc;
  List<FoodCourt> fclist;

  Future<List<FoodCourt>> _getFoodCourt() async {
    var data = await http
        .get("http://timetable-api-manipal.herokuapp.com/getfoodcourt");
    var jsonData = json.decode(data.body);

    List<FoodCourt> fcs = [];

    for (var u in jsonData) {
      FoodCourt fc = FoodCourt(u["name"]);
      fcs.add(fc);
    }
    return fcs;
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(
        () {
          selectedDate = picked;
          date = DateFormat("yyyy-MM-dd").format(picked);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.code),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => DevPage()));
                },
                iconSize: 40.0,
                color: Colors.orange,
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              'MyMenu',
              style: TextStyle(
                fontSize: 75,
                fontWeight: FontWeight.w700,
                color: Colors.orange,
              ),
            ),
          ),
          SizedBox(height: 30),
          FutureBuilder<List<FoodCourt>>(
              future: _getFoodCourt(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return DropdownButton<String>(
                    hint: Text("Select"),
                    value: selectedFc,
                    onChanged: (newValue) {
                      setState(() {
                        selectedFc = newValue;
                        print(selectedFc);
                      });
                    },
                    items: snapshot.data.map((fc) {
                      return DropdownMenuItem<String>(
                        child: Text(fc.name),
                        value: fc.name,
                      );
                    }).toList(),
                  );
                } else {
                  return CircularProgressIndicator();
                }
              }),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                date,
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
              SizedBox(
                width: 20.0,
              ),
              RaisedButton(
                onPressed: () => _selectDate(context),
                child: Text('Select date',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    )),
                color: Colors.orange,
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
              ),
            ],
          ),
          SizedBox(height: 30),
          DropdownButton(
            value: selectedPlan,
            onChanged: (newValue) {
              setState(() {
                selectedPlan = newValue;
              });
            },
            items: plans.map((plan) {
              return DropdownMenuItem(
                child: new Text(
                  plan,
                  style: TextStyle(fontSize: 25),
                ),
                value: plan,
              );
            }).toList(),
          ),
          SizedBox(
            height: 30,
          ),
          RaisedButton(
            child: Text("Search",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                )),
            color: Colors.orange,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ListPage(
                        plan: selectedPlan.toUpperCase(),
                        date: date,
                        fc: "$selectedFc-admin",
                      ),
                ),
              );
            },
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
          ),
        ],
      ),
    );
  }
}
