import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'listpage.dart';
import 'devpage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime selectedDate = DateTime.now();
  String date = DateFormat('yyyy-MM-dd').format(DateTime.now());
  List<String> plans = ["Breakfast", "Lunch", "Snacks", "Dinner"];
  String selectedPlan = "Breakfast";
  List<String> foodcourts = ["Sodexo", "FC2"];
  String selectedFc = "Sodexo";

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
          SizedBox(height: 30),
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
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
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
              DropdownButton(
                hint:
                    Text('Please choose a meal'), // Not necessary for Option 1
                value: selectedFc,
                onChanged: (newValue) {
                  setState(() {
                    selectedFc = newValue;
                  });
                },
                items: foodcourts.map((fc) {
                  return DropdownMenuItem(
                    child: new Text(
                      fc,
                      style: TextStyle(fontSize: 25),
                    ),
                    value: fc,
                  );
                }).toList(),
              ),
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
                hint:
                    Text('Please choose a meal'), // Not necessary for Option 1
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
                                )));
                  },
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)))
            ],
          ),
        ],
      ),
    );
  }
}
