import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/lanproviders.dart';
import '../provider/themeprovider.dart';

class AboutUs extends StatefulWidget {
  static const routename = '/aboutUs';

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    var Th=Provider.of<ThemeProvider>(context,listen: true);
    var lan=Provider.of<LanguageProvider>(context,listen: true);

    return Directionality(
      textDirection: lan.isEn? TextDirection.ltr:TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Th.getColor("thirdColor"),
        appBar: AppBar(
          toolbarHeight: 70,
          backgroundColor: Th.getColor("firstColor"),
          title:Text(lan.getTexts("About Us"),
            style: TextStyle(fontFamily: "Pacifico",fontWeight: FontWeight.bold),
          ),
        ),
        body: ListView(
          children:[
            Container(
            child: Column(
              children: [
                Stack(children:[
                  Image.network("https://media.istockphoto.com/photos/library-picture-id1028739954?k=20&m=1028739954&s=612x612&w=0&h=C4qqWK_7DDvHPpVYrVGRsqhqdIidTrK64zii9A6jBbU="),
                  Column(
                    children: [
                      SizedBox(height:60),
                      Text(lan.getTexts("  Who Are We?"),
                        style: TextStyle(fontSize:25,fontFamily: "Pacifico",fontWeight: FontWeight.bold),
                      ),
                      Text("&",
                        style: TextStyle(fontSize:25,fontFamily: "Pacifico",fontWeight: FontWeight.bold),
                      ),
                      Text(lan.getTexts("   What Do We Do?"),
                        style: TextStyle(fontSize:25,fontFamily: "Pacifico",fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ]
                ),
                //SizedBox(height:17),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(lan.getTexts("Us"),
                    style: TextStyle(color: Th.getColor("BW"),fontSize:15,fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          ]
        ),


      ),
    );
  }
}
