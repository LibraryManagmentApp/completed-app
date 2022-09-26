import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:two2/provider/lanproviders.dart';
import '../data_cat.dart';
import '../provider/themeprovider.dart';
import '../screens/Books_Screen.dart';
import '../screens/category_page.dart';
// ignore: must_be_immutable
class CardScrollView extends StatefulWidget {

  var currentPage;

  CardScrollView(this.currentPage);

  @override
  _CardScrollViewState createState() => _CardScrollViewState();
}

class _CardScrollViewState extends State<CardScrollView> {

  var padding = 20.0;
  var verticalInset = 30.0;
  @override
  Widget build(BuildContext context) {
    var Th=Provider.of<ThemeProvider>(context,listen: true);
    var lan=Provider.of<LanguageProvider>(context,listen: true);
    return AspectRatio(
        aspectRatio: widgetAspectRadio,
        child: LayoutBuilder(
            builder:(context,contraints){
              var width = contraints.maxWidth;
              // ignore: unused_local_variable
              var height = contraints.maxHeight;

              var safeWidth = width - 3 * padding;
              var safeHeight = width - 2 * padding;

              var heightOfPrimaryCard = safeHeight;
              var widthOfPrimaryCard = cardAspectRatio * heightOfPrimaryCard;

              var primaryCardLeft = safeWidth - widthOfPrimaryCard;
              var horizontalInset = primaryCardLeft / 2;

              // ignore: deprecated_member_use
              List<Widget> cardList = new List();

              for(var i = 0;i < category.length; i++){
                var delta = i - widget.currentPage;
                bool isOnRight = delta > 0;

                var start = padding + max(primaryCardLeft - horizontalInset * -delta * (isOnRight ? 15 : 1), 0.0);

                var cardItem = Positioned.directional(
                  top: padding + verticalInset * max(-delta,0.0),
                  bottom: padding + verticalInset * max(-delta,0.0),
                  start: start,
                  textDirection: lan.isEn?TextDirection.rtl:TextDirection.ltr,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Stack(
                        children:[
                          Container(
                            decoration: BoxDecoration(
                                color: Th.getColor("BW"),
                                boxShadow: [
                                  BoxShadow(
                                    color: Th.getColor("BW12"),
                                    offset: Offset(3, 6),
                                    blurRadius: 10,
                                  )
                                ]
                            ),
                            child: AspectRatio(
                                aspectRatio: cardAspectRatio,
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    Image.asset(category[i].imageUrl,fit:BoxFit.cover,),
                                    Align(
                                        alignment: Alignment.bottomCenter,
                                        child:Container(
                                            height: 60,
                                            width: 180,
                                            decoration: BoxDecoration(
                                                color: Th.getColor("firstColor"),
                                                borderRadius: BorderRadius.circular(20)
                                            ),
                                            child: Center(child: Text(category[i].title,style: TextStyle(color: Th.getColor("thirdColor"),fontSize: 20,fontWeight: FontWeight.w600),)),
                                          ),

                                    ),
                                  ],
                                )
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(color: Th.getColor("BW38")),
                          )
                        ]
                    ),
                  ),
                );
                cardList.add(cardItem);
              }
              return Stack(
                children: cardList,
              );
            }),
      );

  }
}