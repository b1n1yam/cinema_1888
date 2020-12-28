import 'package:flutter/material.dart';
import 'package:cinema_1888/core/helpers/colors.dart';

class GetGeners extends StatefulWidget {
  @override
  _GetGenersState createState() => _GetGenersState();
}

class _GetGenersState extends State<GetGeners> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 20,
      child: Wrap(
        direction: Axis.horizontal,
        runSpacing: 8,
        spacing: 8,
        crossAxisAlignment: WrapCrossAlignment.start,
        children: [
          RowItems(),
          RowItems(),
          RowItems(),
          RowItems(),
          RowItems(),
          RowItems()
        ],
      ),
    );
  }

  Widget RowItems() {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
        child: new Text('sawads', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
