import 'package:flutter/material.dart';
import 'package:two2/screens/search_all_books_page.dart';
import '../provider/BOOKS.dart';
import 'package:provider/provider.dart';
import '../provider/themeprovider.dart';
import '../widget/app_drawer_A.dart';
import './edit_product_screen.dart';
import '../widget/Orga_item.dart';

class Orga extends StatelessWidget {
  static const routename = '/orga';


  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<products>(context, listen: false)
        .fetchandsetproducts(true);
  }

  @override
  Widget build(BuildContext context) {
    var Th=Provider.of<ThemeProvider>(context,listen: true);
    return Scaffold(
        drawer:appdrawer_A(),
        backgroundColor: Th.getColor("thirdColor"),
        appBar: AppBar(
          toolbarHeight: 70,
          backgroundColor: Th.getColor("secondaryColor"),
          title:Text("My Books Paid",style: TextStyle(fontFamily: "Pacifico",fontWeight: FontWeight.bold),),
          actions: [
            Row(
              children: [
                IconButton(
                  padding: EdgeInsets.only(right:10),
                  icon:Icon(Icons.search),
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AllBooksPage())
                  ),
                ),
                IconButton(
                  padding: EdgeInsets.only(right:20),
                  icon: const Icon(Icons.add),
                  onPressed: () => Navigator.of(context).pushNamed(
                    EditProductScreen.routename,),
                ),
                SizedBox(width: 10,),
              ],
            ),
          ],
        ),
        body: FutureBuilder(
          future: _refreshProducts(context),
          builder: (ctx, AsyncSnapshot<dynamic> snapshot) =>
          snapshot.connectionState == ConnectionState.waiting
              ? const Center(child: CircularProgressIndicator())
              : RefreshIndicator(
            onRefresh: () => _refreshProducts(context),
            child: Consumer<products>(
              builder: (ctx, productsData, _) => Padding(
                padding: const EdgeInsets.all(8),
                child: ListView.builder(
                  itemCount: productsData.item.length,
                  itemBuilder: (_, int index) => Column(
                    children: [
                      UserProductItem(
                        productsData.item[index].id,
                        productsData.item[index].name,
                        productsData.item[index].imageUrl,
                      ),
                      const Divider(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
  }
}
