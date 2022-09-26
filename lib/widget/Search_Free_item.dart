import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/Book_detailes_free.dart';
import '../provider/themeprovider.dart';

class SearchFree extends StatelessWidget {
  final String id;
  final String imageUrl;
  final String name;
  final String category;

  const SearchFree({this.id, this.imageUrl, this.name, this.category});

  void selectbook(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(BookDetailesFree.routename,arguments:id);
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
          trailing: Text('Free',
              style: TextStyle(
                color: Th.getColor("firstColor"),
              )),
        )
    );
  }
}
