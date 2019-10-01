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
  String selectedPlan = "Lunch";
  String selectedFc;
  List<FoodCourt> fclist;

  Future<List<FoodCourt>> _getFoodCourt() async {
    var data = await http
        .get("http://timetable-api-manipal.herokuapp.com/getfoodcourt");
    if (data.statusCode == 200) {
      var jsonData = json.decode(data.body);

      List<FoodCourt> fcs = [];

      for (var u in jsonData) {
        FoodCourt fc = FoodCourt(u["name"]);
        fcs.add(fc);
      }
      return fcs;
    } else {
      throw Exception('Failed to load internet');
    }
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

  _buildDropdownFc() {
    return Container(
      padding: EdgeInsets.only(top: 30.0),
      child: FutureBuilder<List<FoodCourt>>(
        future: _getFoodCourt(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return DropdownButton<String>(
              hint: Text("Foodcourt", style: TextStyle(fontSize: 25.0)),
              value: selectedFc,
              onChanged: (newValue) {
                setState(() {
                  selectedFc = newValue;
                  print(selectedFc);
                });
              },
              items: snapshot.data.map((fc) {
                return DropdownMenuItem<String>(
                  child: Text(fc.name, style: TextStyle(fontSize: 25.0)),
                  value: fc.name,
                );
              }).toList(),
            );
          } else if(snapshot.hasError) {
            return Center(child: Text("Failed to load internet"));
          } else {
            return Column(
              children: <Widget>[
                CircularProgressIndicator(),
                SizedBox(height: 10,),
                Text("Make sure your internet is working.")
              ],
            );
          }
        }
      ),
    );
  }

  _buildDropdownMeal() {
    return Container(
      padding: EdgeInsets.only(top: 30.0),
      child: DropdownButton(
        hint: Text("Meal", style: TextStyle(fontSize: 25.0)),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.orange,
          size: 20.0,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.android),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DevPage()
                ),
              );
            },
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.fromLTRB(5.0, 20.0, 5.0, 20.0),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 30.0),
                  child: Center(
                    child: Text(
                      'MyMenu',
                      style: TextStyle(
                        fontSize: 75,
                        fontWeight: FontWeight.w700,
                        color: Colors.orange,
                      ),
                    ),
                  ),
                ),
                _buildDropdownFc(),
                Container(
                  padding: EdgeInsets.only(top: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        date,
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      IconButton(
                        onPressed: () => _selectDate(context),
                        color: Colors.orange,
                        icon: Icon(Icons.calendar_today),
                        iconSize: 30.0,
                      ),
                    ],
                  ),
                ),
                _buildDropdownMeal(),
                Container(
                  padding: EdgeInsets.only(top:50.0),
                  child: RaisedButton(
                    padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    elevation: 5.0,
                    child: Text("Search",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
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
                      print("$selectedFc-admin");
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                  ),
                ),
              ],
            ),
          ),
        ],
      )
    );
  }
}
