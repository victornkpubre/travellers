// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:travellers/presentation/resources/color_manager.dart';
import 'package:travellers/presentation/resources/font_manager.dart';

class StylesManager {
  static final TextStyle splashTextStyle = getSplashTextStyle();

  static TextStyle getSplashTextStyle({double? fontSize, String? fontFamily, FontWeight? fontWeight, Color? color}) {
    return TextStyle(
      fontSize: fontSize??28,
      fontFamily: fontFamily??FontConstants.fontFamily,
      color: color??Colors.white,
      fontWeight: fontWeight??FontWeightManager.bold
    );
  }

  static InputBorder getDefaultInputBorder() {
    return const UnderlineInputBorder(      
      borderSide: BorderSide(color: Colors.white),   
    );
  }

  static TextStyle getDefaultInputStyle(){
    return TextStyle(
      color: Colors.white,
      fontFamily: "Montserrat",
      fontSize: 18
    );
  }

   static TextStyle getSecondaryInputStyle(){
    return TextStyle(
      color: ColorManager.mainColor,
      fontFamily: "Montserrat",
      fontSize: 18
    );
  }




}



class AppText extends StatelessWidget {
  double size;
  final String text;
  final Color color;

  AppText({Key? key, this.size=16 , required this.text, this.color=Colors.black54 }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: size,
        
      )
    );
  }
}


//Text Widgets

class AppLargeText extends StatelessWidget {
  double size;
  final String text;
  final Color color;

  AppLargeText({Key? key, this.size=30 , required this.text, this.color=Colors.black }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.end,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: FontWeight.bold,
        overflow: TextOverflow.fade
      )
    );
  }
}



//Button Widgets
class AppButton extends StatelessWidget {
  String? text;
  IconData? icon;
  final Color color;
  final Color backgroundColor;
  double size;
  final Color borderColor;

  AppButton(
    {Key? key,
    this.text='0',
    this.icon,
    required this.color,
    required this.backgroundColor,
    required this.borderColor,
    required this.size}
  ): super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 5, top: 5),
      width: size,
      height: size,
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(15),
        color: backgroundColor
      ),
      child: Center(
        child: icon==null? 
          AppText(text: text!, color: color): 
        Icon(icon, color: color),

      )
    );
  }
}


class ResponsiveButton extends StatelessWidget {
  double? width;
  bool? isResponsive;
  String text;

  ResponsiveButton({
    Key? key,
    this.width,
    this.isResponsive,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Felxible Requires Parent of Row, Column or Flex
    return Flexible(
      child: Container(
        width: isResponsive==true? double.maxFinite: width,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ColorManager.mainColor
        ),
        child: Row(
          mainAxisAlignment: isResponsive==true? MainAxisAlignment.spaceBetween: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: AppText(text: text, color: Colors.white)
             ),
            Image.asset("assets/images/button-one.png")
          ],
        ),
      ),
    );
  }
}
