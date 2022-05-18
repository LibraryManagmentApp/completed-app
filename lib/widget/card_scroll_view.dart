import 'dart:math';
import 'package:flutter/material.dart';
import '../models/category.dart';
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

            for(var i = 0;i < images.length; i++){
              var delta = i - widget.currentPage;
              bool isOnRight = delta > 0;

              var start = padding + max(primaryCardLeft - horizontalInset * -delta * (isOnRight ? 15 : 1), 0.0);

              var cardItem = Positioned.directional(
                top: padding + verticalInset * max(-delta,0.0),
                bottom: padding + verticalInset * max(-delta,0.0),
                start: start,
                textDirection: TextDirection.rtl,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Stack(
                      children:[
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.black,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
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
                                  Image.asset(images[i],fit: BoxFit.cover,),
                                  Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        height: 60,
                                        width: 180,
                                        decoration: BoxDecoration(
                                            color: Color.fromRGBO(153, 77, 0, 0.9),
                                            borderRadius: BorderRadius.circular(20)
                                        ),
                                        child: Center(child: Text(title[i],style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.w600),)),
                                      )
                                  ),
                                ],
                              )
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(color: Colors.black38),
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