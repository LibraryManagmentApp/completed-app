import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constant.dart';
import '../provider/auth.dart';
import '../provider/lanproviders.dart';
import '../provider/themeprovider.dart';
import '../screens/aboutUs.dart';
import '../screens/order_screen.dart';
import '../screens/search_all_books_page.dart';

class appdrawer_A extends StatelessWidget {
  //static const routename = '/appdrawer';
  @override
  Widget build(BuildContext context) {
    var lan=Provider.of<LanguageProvider>(context,listen: true);
    var Th=Provider.of<ThemeProvider>(context,listen: true);
    return Drawer(
      backgroundColor:Th.getColor("thirdColor"),
      child: Container(
        child: Column(
          children: [
            AppBar(
              backgroundColor:Th.getColor("firstColor"),
              title: Text("Iqra Library",
                style: TextStyle(fontSize:30,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Pacifico",
                  color:Colors.white,
                ),),
              automaticallyImplyLeading: false,
              toolbarHeight:70,
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.account_circle_rounded,color:Th.getColor("secondaryColor"),),
              title: Text('My Account',style: TextStyle(color:Th.getColor("secondaryColor"),fontWeight:FontWeight.bold),),
              onTap: () {
              },
            ),
            ListTile(
              leading: Icon(Icons.search,color:Th.getColor("secondaryColor"),),
              title: Text('Search',style: TextStyle(color:Th.getColor("secondaryColor"),fontWeight:FontWeight.bold),),
              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AllBooksPage())),
            ),
            ListTile(
              leading: Icon(Icons.wallet_travel_rounded,color:Th.getColor("secondaryColor"),),
              title: Text('LIBRARY',style: TextStyle(color:Th.getColor("secondaryColor"),fontWeight:FontWeight.bold),),
              onTap: () => Navigator.of(context).pushReplacementNamed('/'),
            ),
            /*ListTile(
              leading: Icon(Icons.work_rounded,color: secondaryColor),
              title: Text('ORDERS',style: TextStyle(color:secondaryColor,fontWeight:FontWeight.bold),),
              onTap: () => Navigator.of(context)
                  .pushReplacementNamed(orderscreen.routename),
            ),*/
            Divider(),
            ListTile(
              leading: Icon(Icons.accessibility,color:Th.getColor("secondaryColor")),
              title: Text('ABOUT US',style: TextStyle(color: Th.getColor("secondaryColor"),fontWeight:FontWeight.bold),),
              onTap: () =>Navigator.of(context)
                .pushNamed(AboutUs.routename),
            ),
            ListTile(
                leading: Icon(Icons.exit_to_app,color:Th.getColor("secondaryColor"),),
                title: Text('LOUGOUT',style: TextStyle(color: Th.getColor("secondaryColor"),fontWeight:FontWeight.bold),),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacementNamed('/');
                  Provider.of<Auth>(context, listen: false).logOut();
                }),
            Divider(),
            Container(
              alignment: lan.isEn? Alignment.centerLeft: Alignment.centerRight,
              padding: EdgeInsets.only(top: 20,right: 22),
              child:Text(lan.getTexts('drawer_switch_title'),
                style: TextStyle(color:Th.getColor("secondaryColor"),fontWeight:FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: (lan.isEn?0:20),left:(lan.isEn?20:0),bottom:15,top:15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(lan.getTexts('drawer_switch_item2'),
                    style: TextStyle(color:Th.getColor("secondaryColor"),fontWeight:FontWeight.bold),
                  ),
                  Switch(
                    value: Provider.of<LanguageProvider>(context,listen: true).isEn,
                    onChanged:(newValue){
                      Provider.of<LanguageProvider>(context,listen:false).changeLan(newValue);
                      Navigator.of(context).pop();
                    },
                    activeColor: Th.getColor("firstColor"),

                  ),
                  Text(lan.getTexts('drawer_switch_item1'),
                    style: TextStyle(color:Th.getColor("secondaryColor"),fontWeight:FontWeight.bold),
                  ),
                ],
              ),
            ),
            Divider(),
            Container(
              alignment:Alignment.centerLeft,
              padding: EdgeInsets.only(top: 20,right: 22),
              child:Text('   Choose Your Prefer Theme.',
                style: TextStyle(color:Th.getColor("secondaryColor"),fontWeight:FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: (lan.isEn?0:20),left:(lan.isEn?20:0),bottom:15,top:15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Dark',
                    style: TextStyle(color:Th.getColor("secondaryColor"),fontWeight:FontWeight.bold),
                  ),
                  Switch(
                    value: Provider.of<ThemeProvider>(context,listen: true).isLight,
                    onChanged:(newValue){
                      Provider.of<ThemeProvider>(context,listen:false).changeTheme(newValue);
                      Navigator.of(context).pop();
                    },
                    activeColor:Th.getColor("firstColor"),

                  ),
                  Text('Light',
                    style: TextStyle(color:Th.getColor("secondaryColor"),fontWeight:FontWeight.bold),
                  ),
                ],
              ),
            ),
            Divider(),

          ],
        ),
      ),
    );
  }
}
