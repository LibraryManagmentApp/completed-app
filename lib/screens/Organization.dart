import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/themeprovider.dart';

import '../screens/Orga.dart';
import '../screens/OrgaFree.dart';
import '../widget/app_drawer_A.dart';

class Organization extends StatelessWidget {
  static const routename = '/organization';

  @override
  Widget build(BuildContext context) {
    var Th=Provider.of<ThemeProvider>(context,listen: true);
    return Scaffold(
      drawer:appdrawer_A(),
      backgroundColor: Th.getColor("thirdColor"),
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Th.getColor("secondaryColor"),
        title:Text("Organization",style: TextStyle(fontFamily: "Pacifico",fontWeight: FontWeight.bold),),
      ),
      body: Stack(
        children:[
          Image(
              image: NetworkImage("https://alqiyady.awicdn.com/site-images/sites/default/files/offline/album/12276/57313.jpg?preset=v3.0_1200xDYN&save-png=1&rnd=0519151220214-OLD"),
              fit: BoxFit.fill,
              height: double.infinity,
          ),
          Container(
            color: Colors.black.withOpacity(0.5),
          ),
          Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                RaisedButton(
                  child: Text('Free Books',style: TextStyle(fontSize:30,fontFamily: "Pacifico",fontWeight: FontWeight.bold ),
                  ),
                  onPressed: () =>
                      Navigator.of(context).pushNamed(OrgaFree.routename),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  padding: const EdgeInsets.symmetric(horizontal:40, vertical:50),
                  color: Th.getColor("firstColor"),
                  textColor:Theme.of(context).primaryTextTheme.headline6.color,
                ),

                SizedBox(width:20,),

                RaisedButton(
                  child: Text('Paid Books',
                    style: TextStyle(fontSize:30,fontFamily: "Pacifico",fontWeight: FontWeight.bold ),
                  ),
                  onPressed: () =>
                      Navigator.of(context).pushNamed(Orga.routename),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  padding: const EdgeInsets.symmetric(horizontal:40, vertical:50),
                  color: Th.getColor("firstColor"),
                  textColor:Theme.of(context).primaryTextTheme.headline6.color,
                ),

              ],),
          ),
        ],
      ),
    );
  }
}
