import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medico/provider/user_data_provider.dart';
import 'package:provider/provider.dart';

class NavigationProfilePage extends StatefulWidget {
  const NavigationProfilePage({Key? key}) : super(key: key);

  @override
  State<NavigationProfilePage> createState() => _NavigationProfilePageState();
}

class _NavigationProfilePageState extends State<NavigationProfilePage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserDataProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(radius:60,backgroundImage: NetworkImage(provider.snapshot['imageUrl'])),
                const SizedBox(height: 20,),
                Text(provider.snapshot['role']=="Doctor"?"Dr. ${provider.snapshot['name']}":provider.snapshot['gender']=="Male"?"Mr. ${provider.snapshot['name']}":"Mrs. ${provider.snapshot['name']}",style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                const SizedBox(height: 10,),
                Text(provider.snapshot['email'].toString()),
                const SizedBox(height: 10,),
                Text(provider.snapshot['phoneNumber'].toString()),
                const SizedBox(height: 10,),
                Text(provider.snapshot['address'].toString()),
                const SizedBox(height: 20,),
                const Text("About :",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                const SizedBox(height: 10,),
                Text(provider.snapshot['about'].toString()??""),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
