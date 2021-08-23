import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LocationsPage extends StatefulWidget {
  @override
  _LocationsPage createState() => _LocationsPage();
}

// ignore: must_be_immutable
class _LocationsPage extends State<LocationsPage> {
  DateTime dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title:
              Text('Recent Locations', style: TextStyle(color: Colors.white)),
          actions: [
            IconButton(
              icon: Icon(Icons.date_range_rounded),
              onPressed: () => showSheet(
                context,
                child: buildDatePicker(),
                onClicked: () {
                  final value = DateFormat('yyyy/MM/dd').format(dateTime);
                  showSnackBar(context, 'Selected "$value"');

                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
        body: Center(),
      );

  Widget buildDatePicker() => SizedBox(
      height: 180,
      child: CupertinoDatePicker(
        minimumYear: 2021,
        maximumYear: 2025,
        initialDateTime: dateTime,
        mode: CupertinoDatePickerMode.date,
        onDateTimeChanged: (dateTime) =>
            setState(() => this.dateTime = dateTime),
      ));

  static void showSheet(
    BuildContext context, {
    required Widget child,
    required VoidCallback onClicked,
  }) =>
      showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
          actions: [
            child,
          ],
          cancelButton: CupertinoActionSheetAction(
            child: Text('Done'),
            onPressed: onClicked,
          ),
        ),
      );

  static void showSnackBar(BuildContext context, String text) {
    final snackBar = SnackBar(
      content: Text(text, style: TextStyle(fontSize: 24)),
    );
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
