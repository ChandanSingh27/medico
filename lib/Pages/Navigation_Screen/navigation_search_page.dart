import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medico/provider/user_data_provider.dart';
import 'package:provider/provider.dart';

class NavigationSearchPage extends StatefulWidget {
  const NavigationSearchPage({Key? key}) : super(key: key);

  @override
  State<NavigationSearchPage> createState() => _NavigationSearchPageState();
}

class _NavigationSearchPageState extends State<NavigationSearchPage> {

  final TextEditingController _search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserDataProvider>(context);
    final stream = FirebaseFirestore.instance.collection(provider.snapshot['role']=="Patient"?"doctorProfile":"patientProfile").snapshots();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // const SizedBox(height: 15,),
              Container(
                padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black.withOpacity(0.2),
                ),
                child: TextField(
                  controller: _search,
                    decoration: const InputDecoration.collapsed(hintText: "Search",)),
              ),
              StreamBuilder(
                stream: stream,
                builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return const Center(child: CircularProgressIndicator(),);
                  }else if(snapshot.hasError){
                    return Center(child: Text(snapshot.error.toString()),);
                  }else{
                    return Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) => ListTile(
                            leading: CircleAvatar(backgroundImage: NetworkImage(snapshot.data!.docs[index]['imageUrl'].toString()),),
                            title: Text(snapshot.data!.docs[index]['name'].toString()),
                            subtitle: Text(snapshot.data!.docs[index]['role'].toString(),style: TextStyle(fontSize: 12),),
                          ),
                        ));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

