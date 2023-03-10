import 'package:flutter/material.dart';

class NavigationNewsPage extends StatefulWidget {
  const NavigationNewsPage({Key? key}) : super(key: key);

  @override
  State<NavigationNewsPage> createState() => _NavigationNewsPageState();
}

class _NavigationNewsPageState extends State<NavigationNewsPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Text("Posts related to medical news Functionality Here"),
        ),
      ),
    );
  }
}
