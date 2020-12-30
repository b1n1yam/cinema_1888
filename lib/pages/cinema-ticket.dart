import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cinema_1888/widgets/buy-ticket/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ticket_widget/flutter_ticket_widget.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:ui' as ui;
import 'package:permission_handler/permission_handler.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cinema_1888/widgets/cinema-ticket/ticket-detail.dart';
import 'package:cinema_1888/core/models/get_ticket.dart';
import 'package:cinema_1888/core/helpers/common.dart';

///this file contains the logic of
///showing and saving cinema ticket
class QRTicket extends StatefulWidget {
  final GetTicket ticket;

  const QRTicket({Key key, this.ticket}) : super(key: key);
  @override
  _QRTicketState createState() => _QRTicketState();
}

class _QRTicketState extends State<QRTicket> {
  GlobalKey _globalKey = new GlobalKey();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool loading = false;
  @override
  void initState() {
    super.initState();
    print(widget.ticket.id);
    _requestPermission();
  }

  _requestPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();

    final info = statuses[Permission.storage].toString();
    print(info);
  }

  Future _capturePng(BuildContext context) async {
    try {
      setState(() {
        loading = true;
      });
      //getting boundary object
      RenderRepaintBoundary boundary =
          _globalKey.currentContext.findRenderObject();
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      //converting file image to bite data
      ByteData byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      String dir = (await getApplicationDocumentsDirectory()).path;

      var pngBytes = byteData.buffer.asUint8List();
      var bs64 = base64Encode(pngBytes);
      print(pngBytes); //optional pngBytes
      print(bs64);

      Uint8List bytes = base64.decode(bs64);

      String fullPath =
          "$dir/" + DateTime.now().millisecondsSinceEpoch.toString();
      File file = File(fullPath);
      await file.writeAsBytes(bytes);

      await ImageGallerySaver.saveImage(byteData.buffer.asUint8List());

      _displaySnackBar(context);
      setState(() {
        loading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
          backgroundColor: kBackgroundColor,
          title: const Text('Cinema Ticket'),
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
          )),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [
              Color(0xFF1b1e44),
              Color(0xFF2d3447),
            ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                tileMode: TileMode.clamp)),
        child: ListView(
            padding: EdgeInsets.only(
              top: 30.0,
            ),
            children: [
              RepaintBoundary(
                key: _globalKey,
                child: Center(
                  child: FlutterTicketWidget(
                    width: 350.0,
                    height: 500.0,
                    isCornerRounded: true,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Center(
                            child: Text(
                              'Cinema Ticket',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: 10),
                          Center(
                            child: Text(
                              'Deadpool 3: The underground mantion just got discovered',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 25.0),
                            child: Column(
                              children: <Widget>[
                                ticketDetailsWidget(
                                    'Date',
                                    getDateStringAndDate(widget.ticket.date),
                                    'Time',
                                    widget.ticket.time),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 12.0, right: 40.0),
                                  child: ticketDetailsWidget('Cinema Hall', 'A',
                                      'Seat', widget.ticket.seats),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 20,
                            ),
                            child: Container(
                              width: double.infinity,
                              height: 200,
                              child: Center(
                                child: QrImage(
                                  data: widget.ticket.id,
                                  version: QrVersions.auto,
                                  size: 200.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 15, bottom: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Notice!",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "1. Keep this receipt safe and private",
                      style: TextStyle(fontSize: 14, color: Colors.white70),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      "2. Do not share or duplicate this recipt",
                      style: TextStyle(fontSize: 14, color: Colors.white70),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      "3.The above Code is valid for only one use",
                      style: TextStyle(fontSize: 14, color: Colors.white70),
                    ),
                  ],
                ),
              ),
              Container(
                height: Theme.of(context).buttonTheme.height + 20,
                width: double.infinity,
                child: new RaisedButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.save),
                      new Text(loading ? "saving..." : "Save ticket as image",
                          style: new TextStyle(
                            color: Colors.white,
                          )),
                    ],
                  ),
                  colorBrightness: Brightness.dark,
                  onPressed: !loading ? () => _capturePng(context) : () {},
                  color: Colors.blue,
                ),
              ),
            ]),
      ),
    );
  }

  _displaySnackBar(BuildContext context) {
    final snackBar = SnackBar(content: Text('Image is saved to gallery!'));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
