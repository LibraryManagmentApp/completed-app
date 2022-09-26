import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:like_button/like_button.dart';
import '../provider/themeprovider.dart';
import '../screens/Book_detailes.dart';

class BookItem extends StatelessWidget {
  final String id;
  final String imageUrl;
  final String name;
  final double price;

  const BookItem({
    this.imageUrl, this.name, this.price,this.id
  });


  void selectbook(BuildContext ctx) {
   Navigator.of(ctx).pushNamed(BookDetailes.routename,arguments:id);
  }

  @override
  Widget build(BuildContext context) {
    var Th= Provider.of<ThemeProvider>(context,listen: true);
    return InkWell(
      onTap:()=> selectbook(context),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        //elevation:4,
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  child: Image.network(
                    imageUrl,
                    height:200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                    Icon(Icons.person_remove_alt_1_rounded,size: 13,color: Th.getColor("secondaryColor")),
                    //SizedBox(width: 4),
                    Text(name,style: TextStyle(
                      color:Th.getColor("secondaryColor"),
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),),
                  ],),
                  Column(children: [
                    Row( children: [
                      Icon(Icons.attach_money,size: 13,color: Th.getColor("secondaryColor")),
                      //SizedBox(width: 6),
                      Text("$price",style: TextStyle(
                        fontSize: 13,
                        color: Th.getColor("secondaryColor"),
                      ),),
                    ],),
                    SizedBox(height: 7,),
                    LikeButton(
                      circleColor: const CircleColor(
                          start: Color(0xff00ddff), end: Color(0xff0099cc)),
                      bubblesColor: const BubblesColor(
                        dotPrimaryColor: Colors.amber,
                        dotSecondaryColor: Colors.amberAccent,
                      ),
                      likeBuilder: (bool isLiked) {
                        return Icon(
                          Icons.favorite,
                          color:
                          isLiked ? Colors.pink : Colors.grey,
                        );
                      },
                      //likeCount: 0,
                    ),

                  ],)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
