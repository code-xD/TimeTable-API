import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DevPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.chevron_left),
                onPressed: () {
                  Navigator.pop(context);
                },
                iconSize: 40,
                color: Colors.orange,
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Text(
                'Developers',
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 100,
                child: GestureDetector(
                  child: Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          width: 20,
                        ),
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/pp3.jpeg'),
                          radius: 30,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Sayantan Karmakar',
                              style: TextStyle(
                                color: Colors.orange,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            Text('Undergrad at MIT, Manipal'),
                            Text('github.com/sayantank')
                          ],
                        ),
                      ],
                    ),
                  ),
                  onDoubleTap: () {
                    _launchSayaURL();
                  },
                ),
              ),
              SizedBox(
                height: 100,
                child: GestureDetector(
                  child: Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          width: 20,
                        ),
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/pp2.jpg'),
                          radius: 30,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Shivansh Anand',
                              style: TextStyle(
                                color: Colors.orange,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            Text('Undergrad at BITS, Pilani'),
                            Text('github.com/code-xD')
                          ],
                        ),
                      ],
                    ),
                  ),
                  onDoubleTap: () {
                    _launchShivuURL();
                  },
                ),
              ),
              Icon(
                Icons.more_horiz,
                size: 40,
                color: Colors.orange,
              )
            ],
          ),
        ],
      ),
    );
  }

  _launchSayaURL() async {
    const url = 'https://github.com/sayantank';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchShivuURL() async {
    const url = 'https://github.com/code-xD';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
