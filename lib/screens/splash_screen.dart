import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import '../constant.dart';
import '../main.dart';
import 'auth_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen>{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IQRA LIBRARY',
      home: Scaffold(
        body:EasySplashScreen(
          logo: Image.asset("assets/images/logo2.png",),
          logoSize:130,
          durationInSeconds:5,
          navigator:AuthScreen(),
          loaderColor:firstColor,
          //adingText: Text("Please Waitting!!",style: TextStyle(fontSize: 13),),
        )
        /*Column(        //alignment:Alignment.center,
          children:[
      Container(height: 100,),
            Image.asset("assets/images/logo.png",
            height: 300,
            width:350,
            //  fit: BoxFit.cover,
            ),

            Container(
              height: 200,
              alignment:Alignment.bottomCenter,
              child:const SpinKitPumpingHeart(
                color: firstColor,
                size: 40,
                duration: Duration(seconds:2),
              ),),
            Container(
              height:50,
              alignment:Alignment.bottomCenter,
              child:const SpinKitFadingFour(
                color: Colors.black12,
                size:60,
                duration: Duration(seconds:2),
              ),),
          ],
        ),*/

      ),
    );
  }
}
