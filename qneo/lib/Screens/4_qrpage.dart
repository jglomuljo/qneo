import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qneo/models/allLocations.dart';
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
          body: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              buildQrView(context),
              Positioned(
                bottom: 50,
                child: reminder(),
              ),
              Positioned(
                top: 50,
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

  Widget notebelow() => Text("Please align the QR code within the frame.",
      maxLines: 10,
      style: TextStyle(
        color: Colors.white,
      ));

  Widget buildQrView(BuildContext context) => QRView(
        key: qrKey,
        onQRViewCreated: onQRViewCreated,
        overlay: QrScannerOverlayShape(
          borderColor: Theme.of(context).accentColor,
          borderWidth: 10,
          borderLength: 20,
          borderRadius: 10,
          cutOutSize: MediaQuery.of(context).size.width * 0.8,
        ),
      );

  void onQRViewCreated(QRViewController controller) {
    setState(() => this.controller = controller);

    controller.scannedDataStream
        .listen((barcode) => setState(() => this.barcode = barcode));
  }

//   Widget accept() {
//     return AlertDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(50),
//           ),
//           title: Text('Scan complete'),
//           content: Text('Tap "Yes" to confirm.\n Tap "No" to abort.'),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(DialogAction.abort),
//               child: const Text('No'),
//             ),
//             ElevatedButton(
//               onPressed: () => Navigator.of(context).pop(DialogAction.abort),
//               child: const Text('Yes'),
//             ),
//           ],
//         );
//       },
//     );
//   }
}

// enum DialogAction { yes, abort }

// class Accept {
//   static Future<DialogAction> dialogYesAbort(
//     BuildContext context,
//     String title,
//     String body,
//   ) async {
//     final action = await showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(50),
//           ),
//           title: Text(title),
//           content: Text(body),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () => Navigator.of(context).pop(DialogAction.abort),
//               child: const Text('No'),
//             ),
//             ElevatedButton(
//               onPressed: () => Navigator.of(context).pop(DialogAction.abort),
//               child: const Text('Yes'),
//             ),
//           ],
//         );
//       },
//     );
//     return (action != null) ? action : DialogAction.abort;
//   }
// }

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
    for (var i = 0; i < allLocations.length; i++) {
      if (allLocations[i].uid == widget.barcode!.code) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          title: Text('Scan Successful'),
          content: const Text('Tap "OK" to record location.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => ProfilePage()));
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                await DatabaseService().updateUserData(
                    user.uid.toString(), widget.barcode!.code.toString());
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => ProfilePage()));
              }, //func here
              child: const Text('OK'),
            ),
          ],
        );
      }
      // return AlertDialog(
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(50),
      //   ),
      //   title: Text('Scan Failed'),
      //   content: const Text('Invalid Code'),
      //   actions: <Widget>[
      //     TextButton(
      //       onPressed: () {
      //         Navigator.pushReplacement(context,
      //             MaterialPageRoute(builder: (context) => ProfilePage()));
      //       },
      //       child: const Text('Cancel'),
      //     )
      //   ],
      // );
    }
    return Container();
  }
}

// class Confirmation extends StatelessWidget {
//   final Barcode? barcode;
//   Confirmation(this.barcode);

//   @override
//   Widget build(BuildContext context) {
//     final user = FirebaseAuth.instance.currentUser!;
//     return AlertDialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(50),
//       ),
//       title: Text('Scan Successful ' + this.barcode!.code),
//       content: const Text('Tap "OK" to record location.'),
//       actions: <Widget>[
//         TextButton(
//           onPressed: () {
//             Navigator.pushReplacement(context,
//                 MaterialPageRoute(builder: (context) => ProfilePage()));
//           },
//           child: const Text('Cancel'),
//         ),
//         ElevatedButton(
//           onPressed: () async {
//             await DatabaseService().updateUserData(
//                 user.uid.toString(), this.barcode!.code.toString());
//             Navigator.pushReplacement(context,
//                 MaterialPageRoute(builder: (context) => ProfilePage()));
//           }, //func here
//           child: const Text('OK'),
//         ),
//       ],
//     );
//   }
// }

class Validation extends StatefulWidget {
  final Barcode? barcode;
  const Validation({Key? key, this.barcode}) : super(key: key);

  @override
  _ValidationState createState() => _ValidationState();
}

class _ValidationState extends State<Validation> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<AllLocations>?>.value(
      value: DatabaseService().allLocations,
      initialData: null,
      child: Confirmation(barcode: widget.barcode),
    );
  }
}


// class Reminder extends StatelessWidget {
//   @override
 
// }


