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
                    children: <Widget>[
                      // First Seat Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            width: (MediaQuery.of(context).size.width / 20),
                          ),
                          CienmaSeat(),
                          CienmaSeat(),
                          CienmaSeat(),
                          SizedBox(
                            width: (MediaQuery.of(context).size.width / 20) * 2,
                          ),
                          CienmaSeat(),
                          CienmaSeat(),
                          SizedBox(
                            width: (MediaQuery.of(context).size.width / 20),
                          ),
                        ],
                      ),
                      // Second Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CienmaSeat(),
                          CienmaSeat(),
                          CienmaSeat(),
                          CienmaSeat(),
                          SizedBox(
                            width: (MediaQuery.of(context).size.width / 20) * 2,
                          ),
                          CienmaSeat(
                            isReserved: true,
                          ),
                          CienmaSeat(),
                          CienmaSeat(),
                        ],
                      ),
                      // Third  Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CienmaSeat(),
                          CienmaSeat(),
                          CienmaSeat(),
                          CienmaSeat(),
                          SizedBox(
                            width: (MediaQuery.of(context).size.width / 20) * 2,
                          ),
                          CienmaSeat(),
                          CienmaSeat(
                            isReserved: true,
                          ),
                          CienmaSeat(
                            isReserved: true,
                          ),
                        ],
                      ),
                      // 4TH Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CienmaSeat(),
                          CienmaSeat(),
                          CienmaSeat(),
                          CienmaSeat(),
                          SizedBox(
                            width: (MediaQuery.of(context).size.width / 20) * 2,
                          ),
                          CienmaSeat(
                            isReserved: true,
                          ),
                          CienmaSeat(),
                          CienmaSeat(),
                        ],
                      ),
                      // 5TH Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CienmaSeat(),
                          CienmaSeat(),
                          CienmaSeat(),
                          CienmaSeat(),
                          SizedBox(
                            width: (MediaQuery.of(context).size.width / 20) * 2,
                          ),
                          CienmaSeat(),
                          CienmaSeat(),
                          CienmaSeat(),
                        ],
                      ),
                      // 6TH Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CienmaSeat(),
                          CienmaSeat(),
                          CienmaSeat(),
                          CienmaSeat(),
                          SizedBox(
                            width: (MediaQuery.of(context).size.width / 20) * 2,
                          ),
                          CienmaSeat(),
                          CienmaSeat(),
                          CienmaSeat(),
                        ],
                      ),
                      // final Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            width: (MediaQuery.of(context).size.width / 20),
                          ),
                          CienmaSeat(),
                          CienmaSeat(),
                          CienmaSeat(),
                          SizedBox(
                            width: (MediaQuery.of(context).size.width / 20) * 2,
                          ),
                          CienmaSeat(),
                          CienmaSeat(),
                          SizedBox(
                            width: (MediaQuery.of(context).size.width / 20),
                          ),
                        ],
                      ),
                    ],
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
}

getTimeWidegt() {
  List<ShowTime> showTimeList;
  for (int i = 0; i > 5; i++) {
    showTimeList.add(
      ShowTime(
        time: '12:30',
        price: 10,
        isActive: false,
      ),
    );
  }

  return showTimeList;
}
