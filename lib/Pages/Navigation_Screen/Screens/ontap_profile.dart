import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  String uid;
  Profile({Key? key,required this.uid}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // CircleAvatar(minRadius: 50,backgroundImage: ,)
          ],
        ),
      ),
    );
  }
}
