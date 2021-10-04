import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qneo/models/allLocations.dart';
import 'package:qneo/models/location.dart';
import 'package:qneo/services/database.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:io' show Platform;
import '2_home.dart';

class QRPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QRScanPageState();
}

class _QRScanPageState extends State<QRPage> {
  final qrKey = GlobalKey(debugLabel: 'QR');

  Barcode? barcode;
  QRViewController? controller;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() async {
    super.reassemble();

    if (Platform.isAndroid) {
      await controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
          extendBody: true,
          body: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              buildQrView(context),
              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.05,
                child: reminder(),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.1,
                child: buildControlButtons(),
              ),
            ],
          ),
        ),
      );

  Widget buildControlButtons() => Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: FutureBuilder<bool?>(
                future: controller?.getFlashStatus(),
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    return Icon(Icons.flash_on_rounded);
                  } else {
                    return Container();
                  }
                },
              ),
              onPressed: () async {
                await controller?.toggleFlash();
                setState(() {});
              },
            ),
            IconButton(
              icon: FutureBuilder(
                future: controller?.getCameraInfo(),
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    return Icon(Icons.switch_camera_rounded);
                  } else {
                    return Container();
                  }
                },
              ),
              onPressed: () async {
                await controller?.flipCamera();
                setState(() {});
              },
            ),
          ],
        ),
      );

  Widget reminder() {
    if (barcode != null) {
      return Validation(barcode: barcode);
    } else {
      return notebelow();
    }
  }

  Widget notebelow() => Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 130),
        child: Text("Please align the QR code within the frame.",
            maxLines: 10,
            style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: 'Comfortaa',
                fontWeight: FontWeight.bold)),
      );

  Widget buildQrView(BuildContext context) => QRView(
        key: qrKey,
        onQRViewCreated: onQRViewCreated,
        overlay: QrScannerOverlayShape(
          borderColor: Color(0xFFA7DCCA),
          borderWidth: MediaQuery.of(context).size.width * 0.03,
          borderLength: MediaQuery.of(context).size.width * 0.1,
          borderRadius: MediaQuery.of(context).size.width * 0.05,
          cutOutSize: MediaQuery.of(context).size.width * 0.5,
        ),
      );

  void onQRViewCreated(QRViewController controller) {
    setState(() => this.controller = controller);

    controller.scannedDataStream
        .listen((barcode) => setState(() => this.barcode = barcode));
  }
}

class Confirmation extends StatefulWidget {
  final Barcode? barcode;
  const Confirmation({Key? key, this.barcode}) : super(key: key);

  @override
  _ConfirmationState createState() => _ConfirmationState();
}

class _ConfirmationState extends State<Confirmation> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    final allLocations = Provider.of<List<AllLocations>?>(context) ?? [];
    final locations = Provider.of<List<Location>?>(context) ?? [];
    List userLocs = [];
    var status = 'Time-in';
    var barcodeLocation = widget.barcode!.code.toString();
    var scanStatus = '';
    var extraMsg = '';
    bool _buttonPressed = false;

    for (final record in locations) {
      if (record.user == user.uid) {
        var temp = {
          'User': record.user,
          'dateTime': record.dateTime,
          'location': record.location,
          'status': record.status
        };
        userLocs.add(temp);
      }
    }
    userLocs.sort((a, b) => b['dateTime'].compareTo(a['dateTime']));

    //checks if user's last record was a time-in
    if (userLocs.length > 0 &&
        userLocs[0]['status'] == 'Time-in' &&
        userLocs[0]['location'] == barcodeLocation) {
      status = 'Time-out';
    }

    //checks if the scanned QR code is valid
    var i = 0;
    while (i < allLocations.length) {
      if (allLocations[i].uid.contains(barcodeLocation)) {
        scanStatus = 'Scan Successful';
        extraMsg = 'Press \'OK\' to record location';
        break;
      } else {
        scanStatus = 'Scan Failed: Invalid QR code';
        extraMsg = 'Press \'Cancel\' to exit';
      }
      i++;
    }

    Future recordData() async {
      _buttonPressed = true;
      //checks if user forgot to timeout
      if (userLocs.length > 0 &&
          userLocs[0]['status'] == 'Time-in' &&
          userLocs[0]['location'] != barcodeLocation) {
        status = 'Time-out';
        DatabaseService().updateUserData(
            user.uid.toString(), userLocs[0]['location'], status);
        status = 'Time-in';
      }
      DatabaseService()
          .updateUserData(user.uid.toString(), barcodeLocation, status);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => ProfilePage()));
    }

    //prompt after scanning the QR code
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(MediaQuery.of(context).size.height * 0.02),
      ),
      title: Text(scanStatus,
          style: TextStyle(
            fontFamily: 'Comfortaa',
            fontWeight: FontWeight.bold,
            fontSize: 16,
            letterSpacing: 0.5,
          )),
      content: Text(extraMsg,
          style: TextStyle(
            fontFamily: 'Comfortaa',
            fontWeight: FontWeight.bold,
            fontSize: 14,
            letterSpacing: 0.5,
          )),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => ProfilePage()));
          },
          child: const Text(
            'Cancel',
            style: TextStyle(
              fontFamily: 'Comfortaa',
              fontWeight: FontWeight.bold,
              fontSize: 14,
              letterSpacing: 0.5,
              color: Color(0xFF1e0fac),
            ),
          ),
        ),
        scanStatus == 'Scan Successful'
            ? ElevatedButton(
                onPressed: _buttonPressed ? null : recordData,
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0xFF1e0fac)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
                child: const Text('OK',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Comfortaa',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      letterSpacing: 0.5,
                    )),
              )
            : SizedBox(height: 0),
      ],
    );
  }
}

class Validation extends StatefulWidget {
  final Barcode? barcode;
  const Validation({Key? key, this.barcode}) : super(key: key);

  @override
  _ValidationState createState() => _ValidationState();
}

class _ValidationState extends State<Validation> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<List<AllLocations>?>.value(
          value: DatabaseService().allLocations,
          initialData: null,
        ),
        StreamProvider<List<Location>?>.value(
          value: DatabaseService().locations,
          initialData: null,
        ),
      ],
      child: Confirmation(barcode: widget.barcode),
    );
  }
}
