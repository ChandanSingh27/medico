import 'package:flutter/material.dart';

class NavigationNotificationPage extends StatefulWidget {
  const NavigationNotificationPage({Key? key}) : super(key: key);

  @override
  State<NavigationNotificationPage> createState() => _NavigationNotificationPageState();
}

class _NavigationNotificationPageState extends State<NavigationNotificationPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Text("Notification Functionality Here"),
        ),
      ),
    );
  }
}
