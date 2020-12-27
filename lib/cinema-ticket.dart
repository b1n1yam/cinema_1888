import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ticket_widget/flutter_ticket_widget.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'const.dart';
import 'dart:ui' as ui;
import 'package:permission_handler/permission_handler.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';

class QRTicket extends StatefulWidget {
  @override
  _QRTicketState createState() => _QRTicketState();
}

class _QRTicketState extends State<QRTicket> {
  GlobalKey _globalKey = new GlobalKey();
  @override
  void initState() {
    super.initState();

    _requestPermission();
  }

  _requestPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();

    final info = statuses[Permission.storage].toString();
    print(info);
  }

  _saveScreen() async {
    RenderRepaintBoundary boundary =
        _globalKey.currentContext.findRenderObject();
    ui.Image image = await boundary.toImage();
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  }

  Future _capturePng() async {
    try {
      print('inside');
      RenderRepaintBoundary boundary =
          _globalKey.currentContext.findRenderObject();
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      String dir = (await getApplicationDocumentsDirectory()).path;

      var pngBytes = byteData.buffer.asUint8List();
      var bs64 = base64Encode(pngBytes);
      print(pngBytes);
      print(bs64);
      setState(() {});

      Uint8List bytes = base64.decode(bs64);

      String fullPath =
          "$dir/" + DateTime.now().millisecondsSinceEpoch.toString();
      File file = File(fullPath);
      await file.writeAsBytes(bytes);

      final result =
          await ImageGallerySaver.saveImage(byteData.buffer.asUint8List());

      print(result);
      String albumName = 'Media';
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cinema Ticket'),
      ),
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
                                    'Date', 'Dec 12 Fri', 'Time', '04:10 AM'),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 12.0, right: 40.0),
                                  child: ticketDetailsWidget(
                                      'Cinema Hall', 'A', 'Seat', '1A'),
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
                                  data: "1234567890",
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
                      new Text("Save ticket as image",
                          style: new TextStyle(
                            color: Colors.white,
                          )),
                    ],
                  ),
                  colorBrightness: Brightness.dark,
                  onPressed: _capturePng,
                  color: Colors.blue,
                ),
              ),
            ]),
      ),
    );
  }

  Widget ticketDetailsWidget(String firstTitle, String firstDesc,
      String secondTitle, String secondDesc) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                firstTitle,
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  firstDesc,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                secondTitle,
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  secondDesc,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
