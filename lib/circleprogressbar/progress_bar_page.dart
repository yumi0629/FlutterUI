import 'package:flutter/material.dart';
import 'package:flutter_ui/circleprogressbar/circle_progress_bar.dart';

class ProgressBarPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ProgressBarState();
}

class ProgressBarState extends State<ProgressBarPage> {
  double progress = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CircleProgressBar'),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Text('Degree:${(progress * 360.0).round()}°',style: TextStyle(fontSize: 20.0),),
          CircleProgressBar(
            radius: 120.0,
            dotColor: Colors.pink,
            dotRadius: 18.0,
            shadowWidth: 2.0,
            progress: 0.0,
            progressChanged: (value) {
              setState(() {
                progress = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
