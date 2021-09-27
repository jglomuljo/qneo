import 'package:flutter/material.dart';
import '3_userpage.dart';
import '4_qrpage.dart';
import '5_locationspage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    Key? key,
  }) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int currentTab = 0;
  final List<Widget> screens = [
    UserPage(),
    QRPage(),
    LocationsPage(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget screen = UserPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(child: screen, bucket: bucket),
      floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.qr_code_scanner_rounded,
          ),
          backgroundColor: Color(0xFFFF99AA),
          onPressed: () {
            setState(() {
              screen = QRPage();
            });
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
          color: Color(0xFF1E0FAC),
          shape: CircularNotchedRectangle(),
          notchMargin: 10,
          child: Container(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                      minWidth: 155,
                      onPressed: () {
                        setState(() {
                          screen = UserPage();
                          currentTab = 0;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.person_outline_rounded,
                            color: currentTab == 0
                                ? Color(0xFFFF99AA)
                                : Color(0xFFFFFFFF),
                          ),
                          Text(
                            'Profile',
                            style: TextStyle(
                                color: currentTab == 0
                                    ? Color(0xFFFF99AA)
                                    : Color(0xFFFFFFFF)),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MaterialButton(
                      minWidth: 155,
                      onPressed: () {
                        setState(() {
                          screen = LocationsPage();
                          currentTab = 2;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.apartment_rounded,
                            color: currentTab == 2
                                ? Color(0xFFFF99AA)
                                : Color(0xFFFFFFFF),
                          ),
                          Text(
                            'Recent Locations',
                            style: TextStyle(
                                color: currentTab == 2
                                    ? Color(0xFFFF99AA)
                                    : Color(0xFFFFFFFF)),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }
}
