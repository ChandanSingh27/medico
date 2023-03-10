
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:medico/provider/user_data_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../provider/HomeProvider.dart';
import '../Authentication_pages/signIn_page.dart';

class NavigationHomePage extends StatefulWidget {
  const NavigationHomePage({Key? key}) : super(key: key);

  @override
  State<NavigationHomePage> createState() => _NavigationHomePageState();
}

class _NavigationHomePageState extends State<NavigationHomePage> {
  late PageController _pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(initialPage: 1);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          child: PageView(
            controller: _pageController,
            children: [
              NavigationHomeCameraPage(),
              NavigationHomeAppointmentsPage(),
              NavigationHomeChattingPage(),
            ],
          ),
        ),
      ),
    );
  }
}

//Camera Page
class NavigationHomeCameraPage extends StatefulWidget {
  const NavigationHomeCameraPage({Key? key}) : super(key: key);

  @override
  State<NavigationHomeCameraPage> createState() => _NavigationHomeCameraPageState();
}
class _NavigationHomeCameraPageState extends State<NavigationHomeCameraPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Text("Camera/video recording Functionality Here"),
        ),
      ),
    );
  }
}

//Appointments details Page
class NavigationHomeAppointmentsPage extends StatefulWidget {

  const NavigationHomeAppointmentsPage({Key? key}) : super(key: key);

  @override
  State<NavigationHomeAppointmentsPage> createState() => _NavigationHomeAppointmentsPageState();
}
class _NavigationHomeAppointmentsPageState extends State<NavigationHomeAppointmentsPage> {

  @override
  void initState(){
    // TODO: implement initState
    super.initState();

   }
  @override
  Widget build(BuildContext context) {
    final stream = FirebaseFirestore.instance.collection('appointments').snapshots();
    final provider = Provider.of<UserDataProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10,),
              Row(
                children: [
                  CircleAvatar(minRadius: 25,backgroundImage: NetworkImage(provider.snapshot['imageUrl'])),
                  const SizedBox(width: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Hello ${provider.snapshot['name'].toString().substring(0,provider.snapshot['name'].toString().indexOf(" "))??"none"},",style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                      Text("How're you today?",style: TextStyle(color: Colors.black.withOpacity(0.5)),)

                    ],
                  )


                ],
              ),
              const SizedBox(height: 30,),
              const Text("Today Appointment",style: TextStyle(fontSize: 18,fontWeight: FontWeight.normal),),
              Expanded(
                child:StreamBuilder(
                    stream: stream,
                    builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return CircularProgressIndicator();
                      }
                      else if(snapshot.hasError){
                        return Text(snapshot.error.toString());
                      }else{
                          return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            final uid = FirebaseAuth.instance.currentUser!.uid.toString();
                            return ListTile(title: Text(
                                snapshot.data!.docs[index]['uid']),);
                          }
                          );
                        }
                      }
    ,
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}

//Chatting Page
class NavigationHomeChattingPage extends StatefulWidget {
  const NavigationHomeChattingPage({Key? key}) : super(key: key);

  @override
  State<NavigationHomeChattingPage> createState() => _NavigationHomeChattingPageState();
}
class _NavigationHomeChattingPageState extends State<NavigationHomeChattingPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Text("Chatting Functionality Here"),
        ),
      ),
    );
  }
}




