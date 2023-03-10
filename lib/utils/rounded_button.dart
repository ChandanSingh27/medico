import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class RoundedButton extends StatelessWidget {
  String buttonName;
  Color buttonColor;
  final buttonIcons;
  bool isIcons;
  bool isLoading;
  final VoidCallback callBack;
  RoundedButton({Key? key,required this.isLoading,required this.buttonName,required this.buttonColor,this.buttonIcons,required this.isIcons,required this.callBack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callBack,
      child: Container(
        alignment: Alignment.center,
        width: 300,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          color: buttonColor,
        ),
        child: isLoading ? CircularProgressIndicator(color: Colors.white,) :Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            isIcons ? Icon(buttonIcons,color: Colors.white,):CircleAvatar(backgroundImage: AssetImage(buttonIcons),maxRadius: 15,backgroundColor: Colors.transparent,),
            SizedBox(width: 5,),
            Text(buttonName,style: TextStyle(fontFamily: GoogleFonts.chakraPetch().fontFamily,fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),)
          ],
        ),
      ),
    );
  }
}
class RoundedButtonNoIcon extends StatelessWidget {
  String buttonName;
  Color buttonColor;
  bool isLoading;
  final VoidCallback callBack;
  RoundedButtonNoIcon({Key? key,required this.isLoading,required this.buttonName,required this.buttonColor,required this.callBack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callBack,
      child: Container(
        alignment: Alignment.center,
        width: 300,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          color: buttonColor,
        ),
        child: isLoading ? const CircularProgressIndicator(color: Colors.white,) : Text(buttonName,style: TextStyle(fontFamily: GoogleFonts.chakraPetch().fontFamily,fontSize: 15,color: Colors.white,fontWeight: FontWeight.bold),),
      ),
    );
  }
}