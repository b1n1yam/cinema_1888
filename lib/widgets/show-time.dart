import 'package:flutter/material.dart';

import '../const.dart';

class ShowTime extends StatefulWidget {
  bool isActive;
  final int possition;
  final int price;
  final setActiveTime;
  final String time;

  ShowTime(
      {@required this.time,
      @required this.price,
      @required this.possition,
      @required this.isActive = false,
      this.setActiveTime});

  @override
  _ShowTimeState createState() => _ShowTimeState();
}

class _ShowTimeState extends State<ShowTime> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        widget.setActiveTime(widget.possition);
      },
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 10, right: 15, left: 15),
        padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
        decoration: BoxDecoration(
            border: Border.all(
                color: widget.isActive ? kPimaryColor : Colors.white12),
            borderRadius: BorderRadius.circular(15.0)),
        child: Row(
          children: <Widget>[
            Text(
              widget.time,
              style: TextStyle(
                  color: widget.isActive ? kPimaryColor : Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 10),
            Text('(Available)',
                style: TextStyle(color: Colors.white, fontSize: 14.0))
          ],
        ),
      ),
    );
  }
}
