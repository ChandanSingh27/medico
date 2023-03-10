import 'dart:async';

import 'package:flutter/material.dart';

class HomeProvider with ChangeNotifier{
  int pageNo = 0;
  changePageNo (pageNo){
    pageNo = pageNo;
    notifyListeners();
  }

  //here code affect the navigation home page...
  String containerBackgroundImage = "https://thumbs.dreamstime.com/b/landscape-rays-sun-branches-tree-early-autumn-morning-sunrise-solar-glare-beautiful-scenery-meadow-96218261.jpg";
  String greetingText = "Good Morning";

  setImage(){
    Timer.periodic(const Duration(seconds: 1), (timer) {
       int hour = DateTime.now().hour;
       if(hour>=1 && hour<12){
         greetingText = "Good Morning";
         containerBackgroundImage = "https://thumbs.dreamstime.com/b/landscape-rays-sun-branches-tree-early-autumn-morning-sunrise-solar-glare-beautiful-scenery-meadow-96218261.jpg";
         notifyListeners();
       }
       else if(hour>=12 && hour<16){
         greetingText = "Good Afternoon";
         containerBackgroundImage = "https://upload.wikimedia.org/wikipedia/commons/thumb/0/09/A_good_afternoon_%286933189752%29.jpg/1200px-A_good_afternoon_%286933189752%29.jpg";
         notifyListeners();
       }
       else{
         greetingText = "Good Evening";
         containerBackgroundImage = "https://images.unsplash.com/photo-1603221378108-041a9320d1ca?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OXx8ZXZlbmluZyUyMHN1bnxlbnwwfHwwfHw%3D&w=1000&q=80";
         notifyListeners();
       }
    });
    notifyListeners();
  }
}