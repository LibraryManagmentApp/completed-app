import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../constant.dart';
import '../provider/auth.dart';
import '../provider/cart.dart';
import '../screens/cart_screen.dart';
import '../widget/app_drawer.dart';
import 'package:provider/provider.dart';
import './cart_screen.dart';
import '../screens/cart_screen.dart';
import '../provider/order.dart';
import '../screens/order_screen.dart';
import '../screens/category_page.dart';
import '../widget/badge.dart';
import '../widget/top.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 3, vsync: this);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      drawer:appdrawer(),
      backgroundColor: Colors.white,
      body: AnnotatedRegion(
        value: SystemUiOverlayStyle,
        child:
        ListView(
            padding: EdgeInsets.symmetric(vertical: 50.0,),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          appdrawer.routename;
                        });
                      },
                    //Navigator.of(context).pushNamed(appdrawer.routename),
                      icon:Icon(
                      Icons.menu,
                      size: 30,
                      color:firstColor,
                    ),),
                    /*GestureDetector(
                      onTap: () {appdrawer();},
                      child: Icon(
                        Icons.menu,
                        size: 30,
                        color:firstColor,
                      ),
                    ),*/
                    Text('Home',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: firstColor,fontFamily: "Pacifico",)),
                    Consumer<cart>(
                      child: IconButton(
                        icon: Icon(Icons.shopping_cart,
                          size: 30,
                          color:firstColor,
                        ),
                        onPressed: () =>
                            Navigator.of(context).pushNamed(cartscreen.routename),
                      ),
                      builder: (_, cart, ch) =>
                          badge(value: cart.itemcount.toString(), child: ch),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TabBar(
                  controller: _tabController,
                  indicatorColor: Colors.transparent,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey.withOpacity(.6),
                  labelPadding: EdgeInsets.symmetric(horizontal: 29),
                  isScrollable: true,
                  tabs: [
                    Tab(
                        child: Text(
                          'Top',
                          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold,color: secondaryColor),
                        )),
                    Tab(
                      child: Text(
                        'Categories',
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: secondaryColor),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'favorite',
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold,color: secondaryColor),
                      ),
                    )
                  ]),
              SizedBox(height: 20),
              Container(
                width: 200,
                height: double.maxFinite,
                child: TabBarView(
                    controller: _tabController,
                    children: [
                      Top(),
                      CategoryPage(),
                      Text('data',style: TextStyle(color: secondaryColor),)
                    ]),
              ),
            ]),
      ),
    );
  }
}