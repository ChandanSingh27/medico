import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:medico/Pages/Navigation_Screen/navigation_home_page.dart';
import 'package:medico/Pages/Navigation_Screen/navigation_news_page.dart';
import 'package:medico/Pages/Navigation_Screen/navigation_notification_page.dart';
import 'package:medico/Pages/Navigation_Screen/navigation_profile_page.dart';
import 'package:medico/Pages/Navigation_Screen/navigation_search_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import '../provider/user_data_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _controller ;
  int pageNo = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = PageController(initialPage: 0);
  }
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserDataProvider>(context);
    return Scaffold(
      body: SizedBox(
        child: provider.dataLoaded ? PageView(
          controller: _controller,
          physics: const NeverScrollableScrollPhysics(),
          children:  const [
            NavigationHomePage(),
            NavigationSearchPage(),
            NavigationNewsPage(),
            NavigationNotificationPage(),
            NavigationProfilePage(),
          ],
        ): const Center(child: CircularProgressIndicator(),),
      ),
      bottomNavigationBar: provider.dataLoaded?CurvedNavigationBar(
          onTap: (value) {
            _controller.animateToPage(value, duration: const Duration(milliseconds: 600), curve: Curves.easeOutSine);
          },
          items: const [
            Icon(CupertinoIcons.home,size:35,),
            Icon(CupertinoIcons.search,size:35,),
            Icon(CupertinoIcons.news,size:35,),
            Icon(CupertinoIcons.heart_fill,size:35,),
            Icon(CupertinoIcons.profile_circled,size:35,),
          ],
      ):Container(),
    );
  }
}
