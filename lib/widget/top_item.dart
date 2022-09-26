import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/themeprovider.dart';
import '../screens/Book_detailes_free.dart';

class TopItem extends StatefulWidget {
  final String id;
  final String imageUrl;
  final String name;
  final String pdf;
  final String category;
  final String description;

  const TopItem({ this.description,this.id, this.imageUrl, this.name, this.pdf, this.category});

  @override
  State<TopItem> createState() => _TopItemState();
}

class _TopItemState extends State<TopItem> {
  //get pageController =>widget.pageController;

  void selectbook(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(BookDetailesFree.routename,arguments:widget.id);
  }


  @override
  Widget build(BuildContext context) {
    var Th=Provider.of<ThemeProvider>(context,listen: true);
    return InkWell(
      onTap: ()=> selectbook(context),
      child: Column(
        children:[
          Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: Container(
                      child: Container(
                        decoration: BoxDecoration(borderRadius:BorderRadius.circular(16),),
                        margin: EdgeInsets.fromLTRB(10, 10, 10, 25),
                        child: Image(
                          image: NetworkImage(widget.imageUrl),
                          width: 300,
                          height: 450,
                          fit: BoxFit.fill,
                        ),
                      )

                ),
              ),
            ],
          ),
          SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Description',
                  style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                      color: Th.getColor("firstColor")),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  widget.description,
                  style: TextStyle(color: Th.getColor("BW"), fontSize: 16),
                )
              ],
            ),
          ),
          SizedBox(
            height: 35,
          ),
        ],
      ),
    );
  }
}
