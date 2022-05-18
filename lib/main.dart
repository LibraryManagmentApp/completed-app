import 'package:flutter/material.dart';
import '../screens/splash_screen2.dart';
import './provider/auth.dart';
import './provider/order.dart';
import './screens/home_page.dart';
//import './screens/splash_screen.dart';
import 'package:provider/provider.dart';
import './provider/auth.dart';
import '../screens/cart_screen.dart';
import '../screens/order_screen.dart';
import '../provider/cart.dart';
import '../provider/order.dart';
import './widget/app_drawer.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  //static const routeName = '/MyApp';
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: cart()),
        ChangeNotifierProvider.value(value: Auth()),
        ChangeNotifierProxyProvider<Auth,order>(
          create: (_)=>order(),
          update: (ctx,authvalue,previousorder)=>previousorder
            ..getdata(
                authvalue.token,
                authvalue.userId,
                previousorder==null?null:previousorder.orders
            ),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          home:auth.isAuth
              ? HomePage()
              : FutureBuilder(
            future: auth.tryAutoLogin(),
            builder: (ctx,AsyncSnapshot authSnapShot) =>
            authSnapShot.connectionState == ConnectionState.waiting
                ? mainsplashscreen()
                :mainsplashscreen(),
          ),
          routes: {
            //MyApp.routeName:(_)=>MyApp(),
            cartscreen.routename:(_)=>cartscreen(),
            orderscreen.routename:(_)=>orderscreen(),
            appdrawer.routename:(_)=>appdrawer(),
          },
        ),
      ),
    );
  }
}
