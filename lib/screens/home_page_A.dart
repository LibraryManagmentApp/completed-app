import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:two2/screens/search_for_books_free.dart';
import '../screens/Organization.dart';
import '../provider/themeprovider.dart';
import '../widget/app_drawer_A.dart';
import '../widget/app_drawer.dart';
import 'package:provider/provider.dart';
import '../widget/Toop.dart';
import '../screens/category_page.dart';

class HomePageA extends StatefulWidget {
  @override
  State<HomePageA> createState() => _HomePageAState();
}

class _HomePageAState extends State<HomePageA>
    with SingleTickerProviderStateMixin {

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 2, vsync: this);
  }

  Widget build(BuildContext context) {
    var Th=Provider.of<ThemeProvider>(context,listen: true);
    return Scaffold(
      drawer:appdrawer_A(),
      backgroundColor: Th.getColor("thirdColor"),
      body: AnnotatedRegion(
        value: SystemUiOverlayStyle,
        child:
        ListView(
            padding: EdgeInsets.symmetric(vertical: 50.0,),
            children: [
              Padding(
                padding:const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:[
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
                        color:Th.getColor("firstColor"),
                      ),),
                    Text('Home',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Th.getColor("firstColor"),fontFamily: "Pacifico",)),
                    IconButton(
                      padding: EdgeInsets.only(right:10),
                      icon:Icon(Icons.search,
                        size: 26,
                        color:Th.getColor("firstColor"),
                      ),
                      onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AllBooksFree())
                      ),
                    ),
                    IconButton(
                        icon: Icon(Icons.mode_edit,
                          size: 26,
                          color:Th.getColor("firstColor"),
                        ),
                        onPressed: () =>
                            Navigator.of(context).pushNamed(Organization.routename),
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
                  labelPadding: EdgeInsets.symmetric(horizontal:80),
                  isScrollable: true,
                  tabs: [
                    Tab(
                        child: Text(
                          'Top',
                          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold,color: Th.getColor("secondaryColor")),
                        )),
                    Tab(
                      child: Text(
                        'Categories',
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color:Th.getColor("secondaryColor")),
                      ),
                    ),
                  ]),
              SizedBox(height: 20),
              Container(
                width: 200,
                height: double.maxFinite,
                child: TabBarView(
                    controller: _tabController,
                    children: [
                      Toop(),
                      CategoryPage(),
                    ]),
              ),
            ]

        ),
      ),
    );
  }
}