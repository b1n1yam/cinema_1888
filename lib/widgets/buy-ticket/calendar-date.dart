import 'package:flutter/material.dart';

import './const.dart';

class CalendarDay extends StatefulWidget {
  final String monthAbr;
  final String dayAbbreviation;
  final String dayNumber;
  final bool isActive;
  final String date;
  final position;
  final setActiveDate;
  CalendarDay(
      {@required this.dayNumber,
      this.dayAbbreviation,
      this.isActive,
      this.monthAbr,
      @required this.position,
      this.setActiveDate,
      this.date});

  @override
  _CalendarDayState createState() => _CalendarDayState();
}

class _CalendarDayState extends State<CalendarDay> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        widget.setActiveDate(widget.position, widget.date);
      },
      child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Container(
            width: 80.0,
            height: 100.0,
            decoration: BoxDecoration(
                border: Border.all(
                  color: widget.isActive ? kPimaryColor : Colors.grey[600],
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(15.0)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  child: Container(
                    width: 80.0,
                    alignment: Alignment.topCenter,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(13),
                          topRight: Radius.circular(13)),
                      color: widget.isActive ? kPimaryColor : null,
                    ),
                    child: Text(widget.monthAbr,
                        style: TextStyle(
                            color:
                                widget.isActive ? Colors.white : Colors.white30,
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                Text(widget.dayNumber,
                    style: TextStyle(
                        color:
                            widget.isActive ? Colors.white60 : Colors.white30,
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold)),
                Text(
                  widget.dayAbbreviation.toUpperCase(),
                  style: TextStyle(
                    color: widget.isActive ? Colors.white60 : Colors.white30,
                    fontSize: 19.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
