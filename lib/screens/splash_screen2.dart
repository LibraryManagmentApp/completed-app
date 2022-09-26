import 'package:flutter/material.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import '../constant.dart';
import '../screens/auth_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class mainsplashscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'IQRA LIBRARY',
        theme: ThemeData(primarySwatch: Colors.brown),
        home: Scaffold(
            body: Stack(
          children: [
            EasySplashScreen(
              logo: Image.asset("assets/images/logo2.png"),
              durationInSeconds:4,
              showLoader:false,
              loadingText: const Text("loading...",
                  style: TextStyle(
                      color: secondaryColor,
                      fontSize: 17,
                      fontStyle: FontStyle.italic)),
              //loaderColor: firstColor,
              logoSize: 130,
              navigator: AuthScreen(),
            ),
            Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 550,
                  ),
                  Center(
                    child:SpinKitPumpingHeart(
                      color:firstColor,
                      size: 40,
                      duration: Duration(seconds:2),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )));
  }
}
