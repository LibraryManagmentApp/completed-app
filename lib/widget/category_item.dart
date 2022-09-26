import 'package:flutter/material.dart';
import '../models/category.dart';
import '../widget/card_scroll_view.dart';
import '../screens/Books_Screen.dart';

class CategoryItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;


  void selectbook(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(BooksScreen.routename,
        arguments:{
          'id': id,
          'title':title,
        });
  }

  CategoryItem( this.id, this.title, this.imageUrl);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=> selectbook(context),
      splashColor: Theme.of(context).primaryColor,
      child: Container(
        padding: EdgeInsets.all(15),
        child: Text(title,style:TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),),
      ),
    );
  }
}
