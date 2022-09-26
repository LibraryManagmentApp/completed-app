import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/themeprovider.dart';
import '../screens/Book_detailes.dart';

class Search extends StatelessWidget {
  final String id;
  final String imageUrl;
  final String name;
  final double price;
  final String category;

  const Search({this.id, this.imageUrl, this.name, this.price, this.category});

  void selectbook(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(BookDetailes.routename,arguments:id);
  }

  @override
  Widget build(BuildContext context) {
    var Th=Provider.of<ThemeProvider>(context,listen: true);
    return InkWell(
      onTap: ()=> selectbook(context),
      child: ListTile(
            contentPadding: EdgeInsets.all(8),
            title: Text(
              name,
              style: TextStyle(
                  color:Th.getColor("BW"),
                  fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              "${category} ",
              style:TextStyle(
                color: Th.getColor("BW"),
              ),
            ),
            trailing: Text('${price}',
                style: TextStyle(
                  color: Th.getColor("firstColor"),
                )),
          )
    );
  }
}
