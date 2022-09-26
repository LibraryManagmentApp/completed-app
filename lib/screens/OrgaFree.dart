import 'package:flutter/material.dart';
import 'package:two2/screens/search_for_books_free.dart';
import '../provider/BOOKS_Free.dart';
import '../screens/edit_product_screen_free.dart';
import '../provider/BOOKS.dart';
import 'package:provider/provider.dart';
import '../provider/themeprovider.dart';
import '../widget/Orga_Free_item.dart';
import '../widget/app_drawer_A.dart';

class OrgaFree extends StatelessWidget {
  static const routename = '/orgafree';


  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<productsFree>(context, listen: false)
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
        title:Text("My Books Free",style: TextStyle(fontFamily: "Pacifico",fontWeight: FontWeight.bold),),
        actions: [
          Row(
            children: [
              IconButton(
                padding: EdgeInsets.only(right:10),
                icon:Icon(Icons.search),
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AllBooksFree())
                ),
              ),
              IconButton(
                padding: EdgeInsets.only(right:20),
                icon: const Icon(Icons.add),
                onPressed: () => Navigator.of(context).pushNamed(
                  EditProductScreenFree.routename,),
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
          child: Consumer<productsFree>(
            builder: (ctx, productsData, _) => Padding(
              padding: const EdgeInsets.all(8),
              child: ListView.builder(
                itemCount: productsData.item.length,
                itemBuilder: (_, int index) => Column(
                  children: [
                    UserProductItemFree(
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
