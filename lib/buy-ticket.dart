import 'package:flutter/material.dart';
import 'widgets/calendar-date.dart';
import 'widgets/cinema-seat.dart';
import 'widgets/show-time.dart';

import 'const.dart';

class BuyTicket extends StatefulWidget {
  // var title;

  // BuyTicket({String title});
  @override
  _BuyTicketState createState() => _BuyTicketState();
}

class _BuyTicketState extends State<BuyTicket> {
  int activeTime;
  int activeDate;
  final int yMax = 11;
  final int xMax = 7;

  var demoTime = [1, 2, 3, 4, 5];

  setActiveTime(i) {
    setState(() {
      activeTime = i;
    });
    print(activeTime);
  }

  setActiveDate(i) {
    setState(() {
      activeDate = i;
    });
    print(activeDate);
  }

  @override
  void initState() {
    setState(() {
      activeTime = 0;
      activeDate = 0;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 15.0, left: 15.0),
              child: Row(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * .12,
                    height: MediaQuery.of(context).size.width * .12,
                    decoration: kRoundedFadedBorder,
                    child: IconButton(
                        icon: Icon(
                          Icons.keyboard_arrow_left,
                          size: 28.0,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .75,
                    child: Text(
                      "Deadpool 3",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.5,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Flexible(
              child: ListView(shrinkWrap: true, children: <Widget>[
                Center(
                    child: Column(
                  children: [
                    Text("Select Schedule",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.white)),
                    SizedBox(height: 10),
                    Text("FRIDAY,12 | 09:30 AM",
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                    SizedBox(height: 20),
                    Text("Hall 1: Block A-B",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white38)),
                    Text("Tap on your preferd seat",
                        style: TextStyle(color: Colors.white24)),
                    SizedBox(height: 5),
                  ],
                )),
                Center(child: Image.asset('assets/screen.png')),
                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Column(
                    children:

                        //loop on y axis

                        getCinemaSits(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                    width: MediaQuery.of(context).size.width * .9,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25.0),
                        topLeft: Radius.circular(25.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: <Widget>[
                            for (var i = 0; i < demoTime.length; i++)
                              CalendarDay(
                                  dayNumber: '${i + 9}',
                                  dayAbbreviation: 'MO',
                                  position: i,
                                  isActive: activeDate == i,
                                  setActiveDate: setActiveDate),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      for (var i = 0; i < demoTime.length; i++)
                        ShowTime(
                            time: '12:30',
                            price: 10,
                            isActive: i == activeTime,
                            possition: i,
                            setActiveTime: setActiveTime)
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0),
                      child: Text(
                        '30\$',
                        style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 40.0, vertical: 10.0),
                      decoration: BoxDecoration(
                          color: kActionColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25.0))),
                      child: InkWell(
                          child: Text('Pay',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold))),
                    )
                  ],
                )
              ]),
            )

            ///here close thingy
          ],
        ),
      ),
    );
  }

  List<Widget> getCinemaSits() {
    List<Widget> verticalList = new List<Widget>();
    for (int i = 0; i < yMax + 1; i++) {
      verticalList.add(getHorzontalList(i));
    }
    return verticalList;
  }

  Widget getHorzontalList(int position) {
    int y = 0;
    List<Widget> horizontalList = new List<Widget>();
    if (position != yMax)
      horizontalList.add(Text("${String.fromCharCode(position + 65)}",
          style: TextStyle(color: Colors.white)));
    //replacing corner items with empty spaces
    for (int j = 0; j < xMax; j++) {
      //get horizontal lables
      if (position == yMax) {
        if (j != (xMax / 2).floor()) {
          y++;

          horizontalList.add(Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 7.0, vertical: 5.0),
            width: MediaQuery.of(context).size.width / 15,
            height: MediaQuery.of(context).size.width / 15,
            child: Text("$y",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                )),
          ));
        } else {
          horizontalList.add(SizedBox(
            width: (MediaQuery.of(context).size.width / 20) * 2,
          ));
        }
        continue;
      }
      if (j == 0 && position == 0 ||
          j == xMax - 1 && position == 0 ||
          j == 0 && position == yMax - 1 ||
          j == xMax - 1 && position == yMax - 1 ||
          j == (xMax / 2).floor()) {
        horizontalList.add(SizedBox(
          width: (MediaQuery.of(context).size.width / 20) * 2,
        ));
      } else {
        horizontalList.add(CienmaSeat(id: '$position'));
      }
    }
    return Row(
        mainAxisAlignment: MainAxisAlignment.center, children: horizontalList);
  }
}
