import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:two2/provider/BOOKS_Free.dart';
import 'package:two2/widget/Search_Free_item.dart';
import 'package:two2/widget/Search_item.dart';
import '../models/book.dart';
import '../models/book_free.dart';
import '../provider/BOOKS.dart';
import '../provider/themeprovider.dart';

class AllBooksFree extends StatefulWidget {

  @override
  State<AllBooksFree> createState() => _AllBooksFreeState();
}

class _AllBooksFreeState extends State<AllBooksFree> {

  List<Bookfree> display_list = [];
  Widget build(BuildContext context) {
    var book1= Provider.of<productsFree>(context,listen:false);
    var Book= book1.item;
    var Th=Provider.of<ThemeProvider>(context,listen: true);
    return Scaffold(
      backgroundColor:Th.getColor("thirdColor"),
      appBar: AppBar(
        toolbarHeight:70,
        backgroundColor:Th.getColor("firstColor"),
        title: Text('Result of Search',style: TextStyle(fontSize:25,
          fontWeight: FontWeight.bold,
          fontFamily: "Pacifico",
          color:Colors.white,
        ),),
      ),
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                setState((){
                  display_list =Book.where((element) =>
                      element.name.toLowerCase().contains(value.toLowerCase()))
                      .toList();
                }
                );
              },
              style: TextStyle(color: Th.getColor("BW")),
              decoration: InputDecoration(
                fillColor:Color(0xffDCD2D2).withOpacity(0.4),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                hintText: "Search",
                hintStyle: TextStyle(color: Th.getColor("BW54")),
                prefixIcon: Icon(
                  Icons.search,
                  color:Th.getColor("BW54") ,
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Expanded(
              child: display_list.length == 0
                  ? Center(
                  child: Text(
                    'No result found',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Th.getColor("BW38"),fontSize: 15),
                  ))
                  :ListView.builder(
                padding: EdgeInsets.all(10),
                itemBuilder: (ctx,index){
                  return SearchFree(
                    id: display_list[index].id,
                    imageUrl: display_list[index].imageUrl,
                    name: display_list[index].name,
                    category: display_list[index].category,
                  );
                },
                itemCount: display_list.length,
              ),


            ),
          ],
        ),
      ),
    );
  }
}

