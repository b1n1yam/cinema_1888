import 'package:cinema_1888/pages/cinema-ticket.dart';
import 'package:cinema_1888/services/apiResponse.dart';
import 'package:flutter/material.dart';
import 'package:cinema_1888/widgets/buy-ticket/calendar-date.dart';
import 'package:cinema_1888/widgets/buy-ticket/cinema-seat.dart';
import 'package:cinema_1888/widgets/buy-ticket/show-time.dart';

import 'package:cinema_1888/widgets/buy-ticket/const.dart';
import 'package:cinema_1888/services/cinema_api.dart';
import 'package:cinema_1888/core/models/schedule_list.dart';
import 'package:cinema_1888/core/models/time_reducer.dart';
import 'package:cinema_1888/core/models/create_ticket.dart';
import 'package:get_it/get_it.dart';
import 'package:cinema_1888/core/helpers/common.dart';

///this page includes the detail implementation
/// of the ticket buying logic
class BuyTicket extends StatefulWidget {
  // var title;
  final String title;

  const BuyTicket({Key key, this.title}) : super(key: key);
  // BuyTicket({String title});
  @override
  _BuyTicketState createState() => _BuyTicketState();
}

class _BuyTicketState extends State<BuyTicket> {
  int activeTime;
  int activeDate;
  final int yMax = 11;
  final int xMax = 7;
  final int ticketPrice = 80;
  int price = 0;
  String currentTime;
  String currentDate;
  List<String> selectedSeats = new List<String>();
  List<String> initiallySlectedSeats = new List<String>();
  bool buying = false;

  List<TimeReducer> dateOfTime = new List<TimeReducer>();

//set active time on click
  setActiveTime(i, time) {
    List<TimeReducer> selectedTime =
        dateOfTime.where((i) => i.time == time).toList();

    setState(() {
      activeTime = i;
      initiallySlectedSeats = selectedTime[0].reserved;
      selectedSeats = []; //reset selected
      currentTime = time;
    });
  }

//set active date on calendar click
  setActiveDate(i, date) {
    List<ScheduleForListing> res =
        _apiResponse.data.where((i) => i.date == date).toList();
    setState(() {
      activeDate = i;
      dateOfTime = res[0].times; //filtering times from selected date
      activeTime = 0; // reset active time postition
      initiallySlectedSeats = res[0]
          .times[0]
          .reserved; //set the initaial reserved seats for the initial time
      selectedSeats = []; //reset selected
      price = 0; //reset price
      currentDate = date;
    });
  }

//action on seat cliecked
  onSeatClicked(String i) {
    //check if seat is not initially selected
    if (!initiallySlectedSeats.contains(i)) {
      //if this is a check
      if (!selectedSeats.contains(i)) {
        setState(() {
          selectedSeats.add(i);
          price += ticketPrice; // increase price
        });
      } else {
        //remove
        setState(() {
          selectedSeats.removeWhere((item) => item == i);
          //decrease price
          price -= ticketPrice;
        });
      }
      print(selectedSeats);
    }
  }

  bool loading = false;
  CinemaAPI get service => GetIt.I<CinemaAPI>();

  APIResponse<List<ScheduleForListing>> _apiResponse;

  fetchSchedules() async {
    setState(() {
      loading = true;
    });

//API CALLING
    _apiResponse = await service.getSchedules();
    if (!_apiResponse.error) {
      var res = _apiResponse.data[0];
      setState(() {
        dateOfTime = res.times; //filtering times from selected date
        activeTime = 0; // reset active time postition
        initiallySlectedSeats = res.times[0]
            .reserved; //set initial selected state to the first element
        currentDate = res.date;
        currentTime = res.times[0].time;
      });
    }
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    //set top items as initial data

    fetchSchedules();
    setState(() {
      activeTime = 0;
      activeDate = 0;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
            Color(0xFF2d3447),
            Color(0xFF1b1e44),
          ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              tileMode: TileMode.clamp)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: buildAppBar(),
        body: Builder(builder: (_) {
          if (loading) {
            return Center(child: CircularProgressIndicator());
          }
          if (_apiResponse.error) {
            print(_apiResponse.errorMessage);
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "sorry something went wrong",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 20, left: 12.0, bottom: 12.0),
                  child: InkWell(
                    onTap: fetchSchedules,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 22.0, vertical: 6.0),
                      decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(20.0)),
                      child: Text("Try again",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                )
              ],
            ));
          }

          return SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
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
                                fontSize: 20,
                                color: Colors.white)),
                        SizedBox(height: 10),
                        Text(
                            "${getDateStringAndDate(currentDate)} | $currentTime",
                            style:
                                TextStyle(fontSize: 16, color: Colors.white)),
                        SizedBox(height: 20),
                        Text("Hall 1: Block A-B",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white60)),
                        Text("Tap on your preferd seat",
                            style: TextStyle(color: Colors.white54)),
                        SizedBox(height: 16),
                      ],
                    )),
                    Center(child: Image.asset('assets/screen.png')),
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Column(
                        children:

                            //loop on y axis

                            getCinemaSeats(),
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
                                for (var i = 0;
                                    i < _apiResponse.data.length;
                                    i++)
                                  CalendarDay(
                                      monthAbr: getMonthString(
                                          _apiResponse.data[i].date),
                                      dayNumber:
                                          getDateNum(_apiResponse.data[i].date),
                                      dayAbbreviation: getDateString(
                                          _apiResponse.data[i].date),
                                      position: i,
                                      isActive: activeDate == i,
                                      date: _apiResponse.data[i].date,
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
                          for (var i = 0; i < dateOfTime.length; i++)
                            ShowTime(
                                time: dateOfTime[i].time,
                                price: 10,
                                isActive: i == activeTime,
                                availability: dateOfTime[i].availability,
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
                            '$price ETB',
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
                              color: price == 0 || buying
                                  ? kActionColorDisabled
                                  : kActionColor,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25.0))),
                          child: InkWell(
                              onTap: onGetTicket,
                              child: Text(buying ? "Sending..." : 'Get ticket',
                                  style: TextStyle(
                                      color: price == 0 || buying
                                          ? Colors.black45
                                          : Colors.white,
                                      fontSize: 23.0,
                                      fontWeight: FontWeight.bold))),
                        )
                      ],
                    )
                  ]),
                )

                ///here close thingy
              ],
            ),
          );
        }),
      ),
    );
  }

  List<Widget> getCinemaSeats() {
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
        String id_ = '${String.fromCharCode(position + 65)}${j + 1}';
        horizontalList.add(CienmaSeat(
            onSeatClicked: onSeatClicked,
            isSelected: selectedSeats.contains(id_),
            isReserved: initiallySlectedSeats.contains(id_),
            id: id_));
      }
    }
    return Row(
        mainAxisAlignment: MainAxisAlignment.center, children: horizontalList);
  }

  buildAppBar() {
    return AppBar(
        backgroundColor: kBackgroundColor,
        title: Center(
          child: Text(
            widget.title,
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.5,
                color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
        leading: Container(
          width: MediaQuery.of(context).size.width * .12,
          height: MediaQuery.of(context).size.width * .12,
          child: IconButton(
              icon: Icon(
                Icons.keyboard_arrow_left,
                size: 28.0,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
        ));
  }

//store ticket on database
  onGetTicket() async {
    if (price != 0 || !buying) {
      setState(() {
        buying = true;
      });
      final ticket = TicketCrate(
          price: '$price', title: widget.title, seat: selectedSeats);

      final result =
          await service.createTicket(ticket, currentDate, currentTime);

      setState(() {
        buying = false;
      });
      print(result.errorMessage);
      if (!result.error) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => QRTicket(ticket: result.data),
          ),
        );
      }
    }
  }
}
