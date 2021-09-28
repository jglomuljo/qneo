import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HeaderWithPic extends StatelessWidget {
  const HeaderWithPic({
    Key? key,
    required this.size,
    required this.screenSize,
    required this.user,
  }) : super(key: key);

  final Size size;
  final Size screenSize;
  final User user;

  @override
  Widget build(BuildContext context) {
    return Container(
      //extract widget - headerwithpic
      height: size.height * 0.3,
      child: Stack(
        children: <Widget>[
          Container(
            height: size.height * 0.3 - 70,
            decoration: BoxDecoration(
              color: Color(0xFFA7DCCA),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(45),
                bottomRight: Radius.circular(45),
              ),
            ),
            child: Row(
              children: <Widget>[
                Image(
                  image: AssetImage('assets/images/profiledeco.png'),
                  width: screenSize.width * 1,
                  height: screenSize.height * 3,
                )
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundImage: NetworkImage(user.photoURL!),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
