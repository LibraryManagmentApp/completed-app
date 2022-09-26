import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './provider/BOOKS_Free.dart';
import './screens/Organization.dart';
import './screens/OrgaFree.dart';
import './screens/edit_product_screen_free.dart';
import './provider/themeprovider.dart';
import './provider/lanproviders.dart';
import './provider/BOOKS.dart';
import './screens/Orga.dart';
import './screens/aboutUs.dart';
import './screens/edit_product_screen.dart';
import './screens/home_page_A.dart';
import '../screens/splash_screen2.dart';
import './provider/auth.dart';
import './provider/order.dart';
import './screens/home_page.dart';
import '../screens/cart_screen.dart';
import '../screens/order_screen.dart';
import '../provider/cart.dart';
import '../provider/order.dart';
import './widget/app_drawer.dart';
import './screens/Books_Screen.dart';
import './screens/Book_detailes.dart';
import './screens/Book_detailes_free.dart';

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
        ChangeNotifierProxyProvider<Auth,products>(
          create:(_)=> products(),
          update:(ctx,authValue,previosproducts)=> previosproducts
            ..getdata(
              authValue.token,
              authValue.userId,
              previosproducts == null?null : previosproducts.item,
            ),
        ),
        ChangeNotifierProxyProvider<Auth,productsFree>(
          create:(_)=> productsFree(),
          update:(ctx,authValue,previosproducts)=> previosproducts
            ..getdata(
              authValue.token,
              authValue.userId,
              previosproducts == null?null : previosproducts.item,
            ),
        ),
        ChangeNotifierProvider<LanguageProvider>(create: (ctx)=>LanguageProvider(),),
        ChangeNotifierProvider<ThemeProvider>(create: (ctx)=>ThemeProvider(),),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          home:auth.isAuth
              ? auth.userId =='PvYRfwpVrZRVqKmIovt4lJujhPM2'?HomePageA():HomePage()
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
            BooksScreen.routename:(_)=>BooksScreen(),
            BookDetailes.routename: (_) => BookDetailes(),
            BookDetailesFree.routename: (_) => BookDetailesFree(),
            Organization.routename:(_) => Organization(),
            Orga.routename:(_) => Orga(),
            OrgaFree.routename:(_) => OrgaFree(),
            EditProductScreen.routename:(_) => EditProductScreen(),
            EditProductScreenFree.routename:(_) => EditProductScreenFree(),
            AboutUs.routename:(_)=>AboutUs(),
          },
        ),
      ),
    );
  }
}
